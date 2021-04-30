//
//  MyProfileViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/01.
//

import UIKit

class MyProfileViewController: UIViewController {
    
    @IBOutlet weak var detailPushButton: UIButton!
    @IBOutlet weak var myProfileContainerView: UIView!
    @IBOutlet weak var myProfileBoxView: UIView!
    @IBOutlet weak var myProfileCharacterNameLabel: UILabel!
    @IBOutlet weak var myProfileCharacterContentLabel: UILabel!
    @IBOutlet weak var myProfileNickNameLabel: UILabel!
    @IBOutlet weak var myProfileCharacterTagFirst: UIButton!
    @IBOutlet weak var myProfileCharacterTagSecond: UIButton!
    @IBOutlet weak var myProfileCharacterTagThird: UIButton!
    @IBOutlet weak var myProfileContentContainerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 18)!,NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    
    
    private func setInitLayout() {
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Settings.png"), style: .plain, target: self, action: nil)
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 18)!,NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationItem.title = "MY"
        self.myProfileContainerView.backgroundColor = UIColor(red: 226/255, green: 49/255, blue: 34/255, alpha: 1.0)
        self.myProfileBoxView.layer.cornerRadius = 15
        self.myProfileBoxView.layer.masksToBounds = false
        self.myProfileBoxView.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.myProfileBoxView.layer.shadowRadius = 10
        self.myProfileBoxView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1).cgColor
        self.myProfileBoxView.layer.shadowOpacity = 0.1
        self.myProfileCharacterNameLabel.text = "열정충만"
        self.myProfileCharacterNameLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.myProfileCharacterNameLabel.textAlignment = .left
        self.myProfileCharacterNameLabel.font = UIFont(name: "GmarketSans-Medium", size: 16)
        self.myProfileCharacterContentLabel.text = "안녕하세요. 저는 다양한 분야에 관심이 많고,  경험하는 것을 좋아하는 프로 열정러입니다!"
        self.myProfileCharacterContentLabel.numberOfLines = 0
        self.myProfileCharacterContentLabel.textColor = UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.0)
        self.myProfileCharacterContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        self.myProfileCharacterContentLabel.textAlignment = .left
        self.myProfileNickNameLabel.text = "@ dohyun"
        self.myProfileNickNameLabel.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        self.myProfileNickNameLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        self.myProfileNickNameLabel.textAlignment = .left
        self.detailPushButton.setImage(UIImage(named: "Arrow.png"), for: .normal)
        self.detailPushButton.addTarget(self, action: #selector(self.didTapdetailPushButton), for: .touchUpInside)
        self.myProfileCharacterTagFirst.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        self.myProfileCharacterTagSecond.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        self.myProfileCharacterTagThird.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        self.myProfileContentContainerView.layer.cornerRadius = 25
        self.myProfileContentContainerView.layer.masksToBounds = true
        
    }
    
    
    
    @objc
    public func didTapdetailPushButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileDetailView = storyboard.instantiateViewController(withIdentifier: "ProfileDetail") as? MyProfileDetailViewController
        guard let profileDetailVC = profileDetailView else { return }
        self.navigationController?.pushViewController(profileDetailVC, animated: true)
    }
}
