import UIKit

class ConciergeViewController: UIViewController {

    var authType: String = ""
    var accessToken: String = ""
    var refreshToken: String = ""
    var userEmail: String = ""
    
    var result: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 회원가입 또는 로그인 API 호출
        print("== Concierge ==")
        print("access token = \(accessToken)")
        print("auth type = \(authType)")
        print("===============")
        
        LoginApiService.postSignUp(authType: authType, accessToken: accessToken) { (flag) -> () in
            self.result = flag
        }
        
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let AdditionalProfileVC = segue.destination as? AdditionalProfileViewController else { return }
        AdditionalProfileVC.userEmail = self.userEmail
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        print("Concierge에서 flag : \(flag)")
        
        // 회원가입인 경우
        if flag == 0 {
            performSegue(withIdentifier: "toOnboarding", sender: nil)
        }
        // 기존유저의 로그인인 경우
        else if flag == 1 {
            performSegue(withIdentifier: "toHome_temp", sender: nil)
        }
        
        else{
            print("Concierge에서 performSegue 에러")
        }
        
    }
}
