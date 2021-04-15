//
//  SideOnlyViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/01.
//

import UIKit

class SideOnlyViewController: UIViewController {
    @IBOutlet weak var questionsButton: UIButton!
    @IBOutlet weak var advisoryAnswerButton: UIButton!
    @IBOutlet weak var socialButton: UIButton!
    @IBOutlet weak var myProfileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSideLayoutInit()
    }
    
    private func setSideLayoutInit() {
        self.navigationController?.navigationBar.barTintColor = .black
        self.view.backgroundColor = UIColor.black
        self.questionsButton.setTitle("질문 / 답", for: .normal)
        self.questionsButton.setTitleColor(UIColor.white, for: .normal)
        self.advisoryAnswerButton.setTitle("자문자답", for: .normal)
        self.advisoryAnswerButton.setTitleColor(UIColor.white, for: .normal)
        self.socialButton.setTitle("소셜", for: .normal)
        self.socialButton.setTitleColor(UIColor.white, for: .normal)
        self.myProfileButton.setTitle("MY", for: .normal)
        self.myProfileButton.setTitleColor(UIColor.white, for: .normal)
        self.questionsButton.addTarget(self, action: #selector(self.showQuestionButtonDidTap(_:)), for: .touchUpInside)
        self.advisoryAnswerButton.addTarget(self, action: #selector(self.showadvisoryButtonDidTap(_:)), for: .touchUpInside)
        self.socialButton.addTarget(self, action: #selector(self.showSocialButtonDidTap(_:)), for: .touchUpInside)
        self.myProfileButton.addTarget(self, action: #selector(self.showMyProfileButtonDidTap(_:)), for: .touchUpInside)
    }
    
    @objc
    private func showQuestionButtonDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let questionView = storyboard.instantiateViewController(withIdentifier: "QuestionsVC") as? QuestionsViewController
        guard let questionVC = questionView else { return }
        self.navigationController?.pushViewController(questionVC, animated: true)
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
    
}
