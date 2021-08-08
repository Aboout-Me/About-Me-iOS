//
//  SideOnlyViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/01.
//

import UIKit

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
        self.setSideLayoutInit()
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
        if UserDefaults.standard.integer(forKey: "answer_Id") != 0 {
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
        let loginView = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        guard let loginVC = loginView else { return }
        let navigationController = UINavigationController(rootViewController: loginVC)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
