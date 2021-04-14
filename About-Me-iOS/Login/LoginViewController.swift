import Foundation
import UIKit
import NaverThirdPartyLogin
import Alamofire
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController, NaverThirdPartyLoginConnectionDelegate {
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var id: UILabel!
    @IBOutlet var tmpImage: UIImageView!
    
    let img = UIImage(named: "tmp.jpg")

    
    @IBOutlet var naverloingButton: UIButton!
    @IBOutlet var kakaologinButton: UIButton!
    
    // 네이버
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    override func viewDidLoad() {
        loginInstance?.delegate = self
        
        // 이미지 설정
        tmpImage.image = img
        
        // 버튼 테두리 설정
        naverloingButton.layer.cornerRadius = 3
        kakaologinButton.layer.cornerRadius = 3
        
        naverloingButton.layer.borderWidth = 2
        kakaologinButton.layer.borderWidth = 2
        
        naverloingButton.layer.borderColor = UIColor.black.cgColor
        kakaologinButton.layer.borderColor = UIColor.black.cgColor
    }
    
    // 로그인에 성공한 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("Success login")
        getInfo()
    }
    
    // referesh token
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        loginInstance?.accessToken
    }
    
    // 로그아웃
    func oauth20ConnectionDidFinishDeleteToken() {
        print("log out")
    }
    
    // 모든 error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("error = \(error.localizedDescription)")
    }
    
    @IBAction func login(_ sender: Any) {
        
        loginInstance?.requestThirdPartyLogin()
    }
    
    @IBAction func logout(_ sender: Any) {
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
        
        self.nameLabel.text = "\(name)"
        self.emailLabel.text = "\(email)"
        self.id.text = "\(id)"
      }
    }
    
    
    // 카카오
    @IBAction func onKakaoLoginByAppTouched(_ sender: Any) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")

                    //do something
                    _ = oauthToken
                }
        }
    }
}
