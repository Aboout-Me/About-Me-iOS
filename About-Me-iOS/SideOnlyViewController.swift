//
//  SideOnlyViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/01.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin

class SideOnlyViewController: UIViewController {
    @IBOutlet weak var todayQuestionButton: UIButton!
    @IBOutlet weak var advisoryAnswerButton: UIButton!
    @IBOutlet weak var socialButton: UIButton!
    @IBOutlet weak var myProfileButton: UIButton!
    @IBOutlet weak var myFeedButton: UIButton!
    @IBOutlet weak var mySetLabel: UILabel!
    @IBOutlet weak var myProfileEditButton: UIButton!
    @IBOutlet weak var alarmSetButton: UIButton!
    @IBOutlet weak var inquireButton: UIButton!
    @IBOutlet weak var noticeButton: UIButton!
    @IBOutlet weak var appVersionInfoButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSideLayoutInit()
        getUserProfileInfo()
        
        // 모달프레젠트 설정
        let vc = UIViewController()
        vc.modalPresentationStyle = .fullScreen
        
        // 네비게이션바 설정
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .black
        self.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getUserProfileInfo()
    }
    
    private func setSideLayoutInit() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.view.backgroundColor = .white
        self.todayQuestionButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        self.todayQuestionButton.titleLabel?.textAlignment = .center
        self.advisoryAnswerButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        self.advisoryAnswerButton.titleLabel?.textAlignment = .center
        self.socialButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        self.socialButton.titleLabel?.textAlignment = .center
        self.myProfileButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        self.myProfileButton.titleLabel?.textAlignment = .center
        self.myFeedButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        self.myFeedButton.titleLabel?.textAlignment = .center
        self.mySetLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        self.mySetLabel.textAlignment = .center
        self.myProfileEditButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        self.myProfileEditButton.titleLabel?.textAlignment = .center
        self.alarmSetButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        self.alarmSetButton.titleLabel?.textAlignment = .center
        self.inquireButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        self.inquireButton.titleLabel?.textAlignment = .center
        self.noticeButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        self.noticeButton.titleLabel?.textAlignment = .center
        self.logoutButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        self.logoutButton.titleLabel?.textAlignment = .center
        self.logoutButton.layer.borderColor = UIColor.lineEee.cgColor
        self.logoutButton.layer.borderWidth = 1
        self.logoutButton.layer.cornerRadius = 20
        guard let dictionary = Bundle.main.infoDictionary, let version = dictionary["CFBundleShortVersionString"] as? String else { return }
        print("버전 정보 \(version)")
        self.appVersionInfoButton.setTitle("버전정보 \(version)", for: .normal)
        self.appVersionInfoButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        self.appVersionInfoButton.titleLabel?.textAlignment = .center
        
        self.todayQuestionButton.addTarget(self, action: #selector(self.showQuestionButtonDidTap(_:)), for: .touchUpInside)
        self.advisoryAnswerButton.addTarget(self, action: #selector(self.showadvisoryButtonDidTap(_:)), for: .touchUpInside)
        self.socialButton.addTarget(self, action: #selector(self.showSocialButtonDidTap(_:)), for: .touchUpInside)
        self.myProfileButton.addTarget(self, action: #selector(self.showMyProfileButtonDidTap(_:)), for: .touchUpInside)
        self.myFeedButton.addTarget(self, action: #selector(self.showMyFeedButtonDidTap(_:)), for: .touchUpInside)
        self.logoutButton.addTarget(self, action: #selector(self.logoutButtonDidTap(_:)), for: .touchUpInside)
    }
    
    @objc
    private func showQuestionButtonDidTap(_ sender: UIButton) {
        HomeServerApi.getIsDailyWrite(userId: USER_ID) { result in
            if case let .success(data) = result, let list = data {
                if list.isWritten == true {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeAfterView = storyboard.instantiateViewController(withIdentifier: "HomeAfterVC") as?
                    HomeAfterViewController
                    guard let homeAfterVC = homeAfterView else { return }
                    self.navigationController?.pushViewController(homeAfterVC, animated: true)
                } else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeBeforeView = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeBeforeViewController
                    guard let homeBeforeVC = homeBeforeView else { return }
                    self.navigationController?.pushViewController(homeBeforeVC, animated: true)
                }
            }
        }
    }
    
    @objc
    private func showadvisoryButtonDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let advisoryAnswerView = storyboard.instantiateViewController(withIdentifier: "AdvisoryAnswerVC") as? AdvisoryAnswerViewController
        guard let advisoryAnswerVC = advisoryAnswerView else { return }
        self.navigationController?.pushViewController(advisoryAnswerVC, animated: true)
    }
    
    @objc
    private func showSocialButtonDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let SocialView = storyboard.instantiateViewController(withIdentifier: "SocialVC") as? SocialViewController
        guard let SocialVC = SocialView else { return }
        self.navigationController?.pushViewController(SocialVC, animated: true)
    }
    
    @objc
    private func showMyProfileButtonDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let MyProfileView = storyboard.instantiateViewController(withIdentifier: "MyProfileVC") as? MyProfileViewController
        guard let MyProfileVC = MyProfileView else { return }
        
        self.navigationController?.pushViewController(MyProfileVC, animated: true)
    }
    
    @objc
    private func showMyFeedButtonDidTap(_ sender: UIButton) {
        let moreVC = SocialMoreContentViewController(nibName: "SocialMoreContentViewController", bundle: nil)
        moreVC.state = .none
        self.navigationController?.pushViewController(moreVC, animated: true)
    }
    
    @objc
    private func showMySetButtonDidTap(_ sender: UIButton) {
        
    }
    
    @objc
    private func logoutButtonDidTap(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "USER_ID")
        UserDefaults.standard.removeObject(forKey: "USER_NICKNAME")
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        
        if let AUTH_TYPE = UserDefaults.standard.string(forKey: "AUTH_TYPE") {
            if AUTH_TYPE == "Kakao" {
                UserApi.shared.logout {(error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("logout() success.")
                        
                        UserDefaults.standard.removeObject(forKey: "USER_ID")
                        UserDefaults.standard.removeObject(forKey: "USER_NICKNAME")
                        UserDefaults.standard.removeObject(forKey: "AUTH_TYPE")
                        
                        print("카카오 로그아웃 성공")
                        
                        let loginView = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
                        guard let loginVC = loginView else { return }
                        let navigationController = UINavigationController(rootViewController: loginVC)
                        UIApplication.shared.windows.first?.rootViewController = navigationController
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                    }
                }
            }
            else if AUTH_TYPE == "Naver" {
                let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
                
                loginInstance?.requestDeleteToken()
                
                UserDefaults.standard.removeObject(forKey: "USER_ID")
                UserDefaults.standard.removeObject(forKey: "USER_NICKNAME")
                UserDefaults.standard.removeObject(forKey: "AUTH_TYPE")
                
                print("네이버 로그아웃 성공")
                
                let loginView = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
                guard let loginVC = loginView else { return }
                let navigationController = UINavigationController(rootViewController: loginVC)
                UIApplication.shared.windows.first?.rootViewController = navigationController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
            else if AUTH_TYPE == "Apple" {
                
                UserDefaults.standard.removeObject(forKey: "USER_ID")
                UserDefaults.standard.removeObject(forKey: "USER_NICKNAME")
                UserDefaults.standard.removeObject(forKey: "AUTH_TYPE")
                
                print("애플 로그아웃 성공")
                
                let loginView = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
                guard let loginVC = loginView else { return }
                let navigationController = UINavigationController(rootViewController: loginVC)
                UIApplication.shared.windows.first?.rootViewController = navigationController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
            else {
                print("=========")
                print("로그아웃 오류 : AUTH_TYPE 식별실패")
                print("=========")
            }
        }
        else {
            print("=========")
            print("로그아웃 오류 : UserDefaults에서 AUTH_TYPE 가져오기 실패")
            print("=========")
            let loginView = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
            guard let loginVC = loginView else { return }
            let navigationController = UINavigationController(rootViewController: loginVC)
            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        
        //        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        //        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        //        guard let loginVC = loginVC else { return }
        //        let navigationController = UINavigationController(rootViewController: loginVC)
        //        UIApplication.shared.windows.first?.rootViewController = navigationController
        //        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    
    public func getUserProfileInfo(){
        ProfileServerApi.getUserProfileProgress(userId: USER_ID) { [self] result in
            if case let .success(data) = result, let list = data {
                if list.data.isEmpty == true || list.data[0].experience.isZero && list.data[1].experience.isZero && list.data[2].experience.isZero && list.data[3].experience.isZero && list.data[4].experience.isZero {
                    myFeedButton.isEnabled = false
                    advisoryAnswerButton.isEnabled = false
                    socialButton.isEnabled = false
                    myProfileButton.isEnabled = false
                    let userAlert = UIAlertController(title: "", message: "내 피드가 비어있습니다. \n오늘의 질문에 답변해주세요", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                    userAlert.addAction(alertAction)
                    self.present(userAlert, animated: true, completion: nil)
                } else {
                        myFeedButton.isEnabled = true
                        advisoryAnswerButton.isEnabled = true
                        socialButton.isEnabled = true
                        myProfileButton.isEnabled = true
                    }
                }
            }
        }
}
