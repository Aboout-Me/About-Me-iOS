import AuthenticationServices
import Foundation
import UIKit

import Alamofire
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import NaverThirdPartyLogin

class LoginViewController: UIViewController, NaverThirdPartyLoginConnectionDelegate {
    
    // MARK: - 변수정의(Label, Button ...)
    
    @IBOutlet var naverloginButton: UIButton!
    @IBOutlet var kakaologinButton: UIButton!
    @IBOutlet var appleloginButton: UIButton!
    @IBOutlet weak var logoDescription: UILabel!
    @IBOutlet var logoImage: UIImageView!
    let img = UIImage(named: "logoImage.png")

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
        
        logoDescription.font = UIFont(name: "GmarketSansTTFMedium", size: 18)
        
        kakaologinButton.setImage(UIImage(named: "kakaologinImage.png"), for: .normal)
        naverloginButton.setImage(UIImage(named: "naverloginImage.png"), for: .normal)
        appleloginButton.setImage(UIImage(named: "appleloginImage.png"), for: .normal)
        
        // 네비게이션바 설정
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    // MARK: - 네이버 로그인 파트
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    // 로그인에 성공한 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("Success login")
        getInfo()
    }
    
    // refresh token
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        loginInstance?.accessToken
    }
    
    // 로그아웃
    func oauth20ConnectionDidFinishDeleteToken() {
        print("log out")
    }
    
    // error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("error = \(error.localizedDescription)")
    }
    
    @IBAction func naverLoginButtonDidTap(_ sender: Any) {
        loginInstance?.requestThirdPartyLogin()
    }
    
    @IBAction func naevrLogoutButtonDidTap(_ sender: Any) {
        loginInstance?.requestDeleteToken()
    }
    
    // RESTful API, id가져오기
    func getInfo() {
      guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
      
      if !isValidAccessToken {
        return
      }
      
      guard let tokenType = loginInstance?.tokenType else { return }
      guard let accessToken = loginInstance?.accessToken else { return }
        
      let urlStr = "https://openapi.naver.com/v1/nid/me"
      let url = URL(string: urlStr)!
      
      let authorization = "\(tokenType) \(accessToken)"
      
      let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
      
      req.responseJSON { response in
        guard let result = response.value as? [String: Any] else { return }
        guard let object = result["response"] as? [String: Any] else { return }
        guard let name = object["name"] as? String else { return }
        guard let email = object["email"] as? String else { return }
        guard let id = object["id"] as? String else {return}
        
//        self.naverNameLabel.text = "\(name)"
//        self.naverEmailLabel.text = "\(email)"
//        self.naverIdLabel.text = "\(id)"
      }
    }
    
    // MARK: - 카카오 로그인 파트
    
    @IBAction func kakaoLoginButtionDidTap(_ sender: Any) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    
                    // do something
                    _ = oauthToken
                    
                    // access token
                    let accessToken = oauthToken?.accessToken
                    
                    // 카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
                    self.setUserInfo()
                }
        }
    }
    
    func setUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                
                //do something
                _ = user
                
//                self.kakaoNameLabel.text = user?.kakaoAccount?.profile?.nickname
                
//                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
//                    let data = try? Data(contentsOf: url) {
//                    self.profileImageView.image = UIImage(data: data)
//                }
            }
         }
    }
}

// MARK: - 애플 로그인 파트
extension LoginViewController: ASAuthorizationControllerDelegate {
    
//    func addButton() {
//        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
//        button.addTarget(self, action: #selector(handleAppleSignInButton), for: .touchUpInside)
//        appleLogin.addSubview(button)
//        let image: UIImage = UIImage(named: "appleloginImage.png")!
//        appleLogin.back
//    }
    @objc func handleAppleSignInButton() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self as? ASAuthorizationControllerDelegate
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
     
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let user = credential.user
            print("User: \(user)")
            guard let email = credential.email else { return }
            print("Email: \(email)")
        }
    }
 
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple login error : \(error)")
    }
    
}
