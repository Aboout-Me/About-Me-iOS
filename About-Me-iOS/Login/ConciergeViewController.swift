import UIKit
import SwiftKeychainWrapper

class ConciergeViewController: UIViewController {

    var authType: String = ""
    var userEmail: String = ""
    var result: Int = -1
    
    @IBOutlet weak var logoDescription: UILabel!
    @IBOutlet var logoImage: UIImageView!
    let img = UIImage(named: "logoImage.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoDescription.text = "오늘의 나"
        logoDescription.font = UIFont(name: "GmarketSansMedium", size: 25)
        logoImage.image = img
        
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
                print("**Concierge** user Id : \(self.result)")
            }
        }

        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let AdditionalProfileVC = segue.destination as? AdditionalProfileViewController else { return }
        AdditionalProfileVC.userEmail = self.userEmail
        AdditionalProfileVC.userId = self.result
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
          // 1초 후 실행될 부분
            
            print("Concierge에서 result : \(self.result)")
            
            // 기존유저의 로그인인 경우
            if self.result == 0 {
                self.performSegue(withIdentifier: "toHome_temp", sender: nil)
            }
            // 에러
            else if self.result == -1 {
                print("Concierge에서 performSegue 에러")
            }
            // 회원가입인 경우
            else {
                self.performSegue(withIdentifier: "toOnboarding", sender: nil)
            }
        }
        
    }
}
