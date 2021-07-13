import UIKit
import SwiftKeychainWrapper

class ConciergeViewController: UIViewController {

    var authType: String = ""
    var userEmail: String = ""
    
    var result: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 회원가입 또는 로그인 API 호출
        print("== Concierge ==")
        print("auth type = \(authType)")
        print("===============")
        
        if authType == "Apple" {
            LoginApiService.postSignUpForApple(code: KeychainWrapper.standard.string(forKey: "code")! , id_token: KeychainWrapper.standard.string(forKey: "id_token")!) { (flag) -> () in
                self.result = flag
            }
        }
        else {
            LoginApiService.postSignUp(authType: authType, accessToken: KeychainWrapper.standard.string(forKey: "accessToken")!) { (flag) -> () in
                self.result = flag
            }
        }

        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let AdditionalProfileVC = segue.destination as? AdditionalProfileViewController else { return }
        AdditionalProfileVC.userEmail = self.userEmail
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print("Concierge에서 result : \(result)")
        
        // 회원가입인 경우
        if result == 0 {
            performSegue(withIdentifier: "toOnboarding", sender: nil)
        }
        // 기존유저의 로그인인 경우
        else if result == 1 {
            performSegue(withIdentifier: "toHome_temp", sender: nil)
        }
        
        else {
            print("Concierge에서 performSegue 에러")
        }
    }
}
