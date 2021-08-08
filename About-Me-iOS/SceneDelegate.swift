import UIKit

import Alamofire
import KakaoSDKAuth
import NaverThirdPartyLogin

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appDelegate = UIApplication.shared.delegate as? AppDelegate

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        // MARK: - RootViewController set
        if UserDefaults.standard.string(forKey: "USER_ID") != nil {
            if let windowScene = scene as? UIWindowScene {
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let todayDateValue = dateFormatter.string(from: date)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)

                self.window = UIWindow(windowScene: windowScene)
                if UserDefaults.standard.string(forKey: "last_answerDate") == todayDateValue {
                    let homeAfterView = storyboard.instantiateViewController(withIdentifier: "HomeAfterVC") as? HomeAfterViewController
                    guard let homeAfterVC = homeAfterView else { return }
                    let navigationController = UINavigationController(rootViewController: homeAfterVC)
                    self.window!.rootViewController = navigationController
                    self.window!.makeKeyAndVisible()
                } else {
                    let homeBeforeView = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeBeforeViewController
                    guard let homeBeforeVC = homeBeforeView else { return }
                    let navigationController = UINavigationController(rootViewController: homeBeforeVC)
                    self.window!.rootViewController = navigationController
                    self.window!.makeKeyAndVisible()
                }

            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        appDelegate?.badgeCount = 0
        if appDelegate?.isPushFlag == 1 {
            appDelegate?.rightBarIcon = "BellOn"
        } else {
            appDelegate?.rightBarIcon = nil
        }
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    // MARK: - Foreground
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    // MARK: - Background
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        appDelegate?.badgeCount = 0
        UIApplication.shared.applicationIconBadgeNumber = 0
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.badgeCount = 0
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        // MARK: - 네이버

        NaverThirdPartyLoginConnection
        .getSharedInstance()?
        .receiveAccessToken(URLContexts.first?.url)
        
        // MARK: - 카카오
        
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
}
