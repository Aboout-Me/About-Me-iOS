import UIKit

class ConciergeViewController: UIViewController {

    var authType: String = ""
    var accessToken: String = ""
    var refreshToken: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        self.navigationController?.navigationBar.topItem?.title = ""
        
        print("== Concierge ==")
        print("access token = \(accessToken)")
        print("auth type = \(authType)")
        print("===============")
        
        let flag = LoginApiService.postSignUp(authType: authType, accessToken: accessToken)
        
        // 회원가입인 경우
        if flag == 0 {
            performSegue(withIdentifier: "toOnboarding", sender: nil)
        }
        // 기존유저의 로그인인 경우
        else if flag == 1 {
            performSegue(withIdentifier: "toHome_temp", sender: nil)
        }
    }
}
