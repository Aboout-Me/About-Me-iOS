import UIKit

class ConciergeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 임시로 계속 false값 주기
        LandscapeManager.shared.isFirstLaunch = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 처음 앱 접속 -> 온보딩, 한 번 이상 앱 접속 -> gha
        if LandscapeManager.shared.isFirstLaunch {
            performSegue(withIdentifier: "toOnboarding", sender: nil)
            LandscapeManager.shared.isFirstLaunch = true
        } else {
            performSegue(withIdentifier: "toHome_temp", sender: nil)
        }
    }
}
