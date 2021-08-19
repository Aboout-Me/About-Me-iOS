import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications

import Alamofire
import KakaoSDKAuth
import KakaoSDKCommon
import NaverThirdPartyLogin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var fcmtoken = ""
    var badgeCount: Int = 0
    var rightBarIcon: String?
    var isPushFlag: Int = 0
    let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        
        let notiOptions: UNAuthorizationOptions = [.alert,.badge,.sound]
        UNUserNotificationCenter
            .current().requestAuthorization(options: notiOptions, completionHandler: {_, _ in })
        if let token = Messaging.messaging().fcmToken {
            fcmtoken = token
            print("fcmToken Check \(fcmtoken)")
        } else {
            print("fcmToken nil \(fcmtoken)")
        }
        
        application.registerForRemoteNotifications()
        
        // MARK: - 카카오
        
        KakaoSDKCommon.initSDK(appKey: "ce4659281ac68752af84768a7e8ef4d3")
        
        // MARK: - 네이버
        
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        
        // 네이버 앱으로 인증하는 방식을 활성화
        instance?.isNaverAppOauthEnable = true
        
        // SafariViewController에서 인증하는 방식을 활성화
        instance?.isInAppOauthEnable = true
        
        // 인증 화면을 iPhone의 세로 모드에서만 사용하기
        instance?.isOnlyPortraitSupportedInIphone()
        
        // 애플리케이션을 등록할 때 입력한 URL Scheme
        instance?.serviceUrlScheme = "naverlogin"
        
        // 애플리케이션 등록 후 발급받은 클라이언트 아이디
        instance?.consumerKey = "lHM0yZEtTVWC9eBcZl7E"
        
        // 애플리케이션 등록 후 발급받은 클라이언트 시크릿
        instance?.consumerSecret = "aKPtEBzXpN"
        
        // 애플리케이션 이름
        instance?.appName = "오늘의나"
        
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
      }
      
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        NaverThirdPartyLoginConnection.getSharedInstance()?.application(app, open: url, options: options)
        return true
      }

    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Message Error \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        var contentAvailable: Int
        print("userInfo \(userInfo)")
        let aps = userInfo["aps"] as? NSDictionary
        if let content = aps!["content-available"] as? String {
            contentAvailable = Int(content)!
        } else {
            contentAvailable = aps!["content-available"] as! Int
            isPushFlag = contentAvailable
        }
        if (contentAvailable == 1) {
            if (application.applicationState == .inactive || application.applicationState == .background)
            {
                self.badgeCount += 1
                rightBarIcon = "BellOn"
                print("badgeCounting \(badgeCount)")
                application.applicationIconBadgeNumber = self.badgeCount
                completionHandler(UIBackgroundFetchResult.newData)
                
            } else {
                completionHandler(UIBackgroundFetchResult.noData)
            }
        }
        
        
    }
}

extension AppDelegate: MessagingDelegate,UNUserNotificationCenterDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        let dataDict: [String:String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    }
    
    // MARK: - foreground
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        if #available(iOS 14, *) {
            completionHandler([.banner, .list, .sound, .badge])
        } else {
            completionHandler([.alert,.badge,.sound])
        }
        //TODO : HomeViewController RootView or Alarm Image upload
        
    }
    
    // MARK: - background
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootView = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController else { return }
        let navigationController = rootView as? UINavigationController
        badgeCount = 0
        print("test userInfo ",userInfo.userInfo)
        if UIApplication.shared.applicationState == .active {
            let notionView = storyboard.instantiateViewController(withIdentifier: "NoticeVC") as? NoticeViewController
            guard let noticeVC = notionView else { return }
            navigationController?.pushViewController(noticeVC, animated: true)
        } else if UIApplication.shared.applicationState == .inactive || UIApplication.shared.applicationState == .background {
            isWriteCardValue()
        }
        completionHandler()
    }
    
    private func isWriteCardValue() {
        HomeServerApi.getIsDailyWrite(userId: USER_ID) { result in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let rootView = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController else { return }
            let navigationController = rootView as? UINavigationController
            if case let .success(data) = result, let list = data {
                print("AppDelegate IsDailyWrite ValueCheck\(list.isWritten)")
                if list.isWritten == false {
                    let homeBeforeView = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeBeforeViewController
                    guard let homeBeforeVC = homeBeforeView else { return }
                    navigationController?.pushViewController(homeBeforeVC, animated: true)
                } else {
                    let homeAfterView = storyboard.instantiateViewController(withIdentifier: "HomeAfterVC") as? HomeAfterViewController
                    guard let homeAfterVC = homeAfterView else { return }
                    navigationController?.pushViewController(homeAfterVC, animated: true)
                }
            }
        }
    }
    
    
}
