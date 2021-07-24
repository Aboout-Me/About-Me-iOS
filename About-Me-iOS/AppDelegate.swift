//
//  AppDelegate.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/03/25.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var fcmtoken = ""
    var badgeCount: Int = 0
    let gcmMessageIDKey = "gcm.message_id"
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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
        let aps = userInfo["aps"] as? NSDictionary
        if let content = aps!["content-available"] as? String {
            contentAvailable = Int(content)!
        } else {
            contentAvailable = aps!["content-available"] as! Int
        }
        if (contentAvailable == 1) {
            if (application.applicationState == .inactive || application.applicationState == .background)
            {
                self.badgeCount += 1
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
        fcmtoken = fcmToken!
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
        self.badgeCount = 0
        print("test userInfo ",userInfo)
        completionHandler()
    }
}


