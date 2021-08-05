import AuthenticationServices
import Foundation
import SwiftKeychainWrapper
import UIKit

import Alamofire
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import NaverThirdPartyLogin

class LoginViewController: UIViewController, NaverThirdPartyLoginConnectionDelegate {
    
    // MARK: - 변수정의
    
    @IBOutlet var naverloginButton: UIButton!
    @IBOutlet var kakaologinButton: UIButton!
    @IBOutlet var appleloginButton: UIButton!
    @IBOutlet weak var logoDescription: UILabel!
    @IBOutlet var logoImage: UIImageView!
    let img = UIImage(named: "logoImage.png")
    
//    var accessToken: String = ""
//    var refreshToken: String = ""
    var authType: String = ""
    var userEmail: String = ""

    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
//        addButton()
        loginInstance?.delegate = self
        
        self.view.backgroundColor = UIColor(red: (255/255.0), green: (255/255.0), blue: (255/255.0), alpha: 1.0)
        
        logoDescription.text = "간편한 로그인으로\n 다양한 질문을 받아보세요!"
        let attrString = NSMutableAttributedString(string: logoDescription.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 15
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        logoDescription.attributedText = attrString
        logoDescription.textAlignment = .center
        
        logoImage.image = img
        
        logoDescription.font = UIFont(name: "GmarketSansMedium", size: 18)
        
        kakaologinButton.setBackgroundImage(UIImage(named: "kakaologinImage.png"), for: UIControl.State.normal)
        naverloginButton.setBackgroundImage(UIImage(named: "naverloginImage.png"), for: UIControl.State.normal)
        appleloginButton.setBackgroundImage(UIImage(named: "appleloginImage.png"), for: UIControl.State.normal)
        appleloginButton.addTarget(self, action: #selector(handleAppleSignInButton), for: .touchUpInside)
        
        // 네비게이션바 설정
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    // segue로 token 및 authType 전달
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("== LoginVC == ")
        print("auth type = \(authType)")
        print("===============")
        
        guard let ConciergeVC = segue.destination as? ConciergeViewController else { return }
        ConciergeVC.authType = self.authType
        ConciergeVC.userEmail = self.userEmail
    }


    
    // MARK: - 네이버 로그인 파트
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    // 로그인에 성공한 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("네이버 로그인 호출 성공")
        self.authType = "Naver"
        getInfo()
    }
    
    // refresh token
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        let _: Bool = KeychainWrapper.standard.set(loginInstance!.refreshToken, forKey: "refreshToken")
    }
    
    // 로그아웃
    func oauth20ConnectionDidFinishDeleteToken() {
        print("네이버 로그아웃")
    }
    
    // error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("네이버 oauth20Connection 에러 : error = \(error.localizedDescription)")
    }
    
    @IBAction func naverLoginButtonDidTap(_ sender: Any) {
        loginInstance?.requestThirdPartyLogin()
    }
    
    @IBAction func naverLogoutButtonDidTap(_ sender: Any) {
        loginInstance?.requestDeleteToken()
    }
    
    // RESTful API, id가져오기
    func getInfo() {
      guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
      
      if !isValidAccessToken {
        return
      }
      
      guard let tokenType = loginInstance?.tokenType else { return }
        let _: Bool = KeychainWrapper.standard.set(loginInstance!.accessToken, forKey: "accessToken")
        oauth20ConnectionDidFinishRequestACTokenWithRefreshToken()
        
      let urlStr = "https://openapi.naver.com/v1/nid/me"
      let url = URL(string: urlStr)!
      
      let authorization = "\(tokenType) \(KeychainWrapper.standard.string(forKey: "accessToken")!)"
      
      let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
      
      req.responseJSON { response in
        guard let result = response.value as? [String: Any] else { return }
        guard let object = result["response"] as? [String: Any] else { return }
        guard let name = object["name"] as? String else { return }
        guard let email = object["email"] as? String else { return }
        guard let id = object["id"] as? String else {return}
        print("naver user id : \(id)")
        self.userEmail = email
      }
    }
    
    // MARK: - 카카오 로그인 파트
    
    @IBAction func kakaoLoginButtionDidTap(_ sender: Any) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print("카카오 로그인 에러, error : \(error)")
                }
                else {
                    print("카카오 로그인 호출 성공")
                    
                    self.authType = "Kakao"
                    
                    // do something
                    _ = oauthToken
                    
                    // token
                    let _: Bool = KeychainWrapper.standard.set(oauthToken!.accessToken, forKey: "accessToken")
                    print("access token = \(KeychainWrapper.standard.string(forKey: "accessToken")!)")
                    let _: Bool = KeychainWrapper.standard.set(oauthToken!.refreshToken, forKey: "refreshToken")
                    
                    // 카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
                    self.setUserInfo()
                }
        }
    }
    
    func setUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print("카카오 유저정보 가져오기 에러, errror : \(error)")
            }
            else {
                print("카카오 유저정보 가져오기 성공")
                
                //do something
                _ = user
                
                guard let email = user?.kakaoAccount?.email else { return }
                self.userEmail = email
                
//                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
//                    let data = try? Data(contentsOf: url) {
//                    self.profileImageView.image = UIImage(data: data)
//                }
            }
         }
    }
@IBAction func buttonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "presentToConcierge", sender: nil)
    }
}

// MARK: - 애플 로그인 파트
extension LoginViewController: ASAuthorizationControllerDelegate {
    
//    func addButton() {
//        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
//        button.addTarget(self, action: #selector(handleAppleSignInButton), for: .touchUpInside)
//        appleloginView.addArrangedSubview(button)
//    }
    
    @objc func handleAppleSignInButton() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self as ASAuthorizationControllerDelegate
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
     
        self.authType = "Apple"
        
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            let user = credential.user
//            print("User: \(user)")
            self.userEmail = credential.email!
            print("애플로그인 Email: \(self.userEmail)")
            print("apple token : \(credential.identityToken)")
            let _: Bool = KeychainWrapper.standard.set(credential.identityToken!, forKey: "id_token")
            let _: Bool = KeychainWrapper.standard.set(credential.authorizationCode!, forKey: "code")
        }
    }
 
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("애플 로그인 error : \(error)")
    }
}

