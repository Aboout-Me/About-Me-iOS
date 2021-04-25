import Foundation
import UIKit

import Alamofire
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import NaverThirdPartyLogin

class LoginViewController: UIViewController, NaverThirdPartyLoginConnectionDelegate {
    
    // MARK: - 변수정의(Label, Button ...)
    
    @IBOutlet var naverNameLabel: UILabel!
    @IBOutlet var naverEmailLabel: UILabel!
    @IBOutlet var naverIdLabel: UILabel!
    @IBOutlet var kakaoNameLabel: UILabel!
    
    @IBOutlet var naverloginButton: UIButton!
    @IBOutlet var naverlogoutButton: UIButton!
    @IBOutlet var kakaologinButton: UIButton!
    
    @IBOutlet var tmpImage: UIImageView!
    let img = UIImage(named: "tmp.jpg")
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        loginInstance?.delegate = self
        
        // 이미지 설정
        tmpImage.image = img
        
        // 버튼 테두리 설정
        naverloginButton.layer.cornerRadius = 3
        kakaologinButton.layer.cornerRadius = 3
        
        naverloginButton.layer.borderWidth = 2
        kakaologinButton.layer.borderWidth = 2
        
        naverloginButton.layer.borderColor = UIColor.black.cgColor
        kakaologinButton.layer.borderColor = UIColor.black.cgColor
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
        
        self.naverNameLabel.text = "\(name)"
        self.naverEmailLabel.text = "\(email)"
        self.naverIdLabel.text = "\(id)"
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
                
                self.kakaoNameLabel.text = user?.kakaoAccount?.profile?.nickname
                
//                if let url = user?.kakaoAccount?.profile?.profileImageUrl,
//                    let data = try? Data(contentsOf: url) {
//                    self.profileImageView.image = UIImage(data: data)
//                }
            }
        }
    }
}
