//
//  MyProfileDetailViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/28.
//

import UIKit

class MyProfileDetailViewController: UIViewController {
    
    @IBOutlet weak var myProfiletTitleLabel: UILabel!
    @IBOutlet weak var myProfileSubTitleLabel: UILabel!
    @IBOutlet weak var myProfileCategoryTitleLabel: UILabel!
    @IBOutlet weak var myProfileCategoryContainerView: UIView!
    @IBOutlet weak var myProfileCharacterImageView: UIImageView!
    @IBOutlet weak var myProfileCharacterTitleLabel: UILabel!
    @IBOutlet weak var myProfileCharacterProgressView: UIProgressView!
    @IBOutlet weak var myProfileCharacterLevelLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDetailLayoutInit()
    }
    @IBOutlet weak var myProfileCharacterLine: UIView!
    
    private func setDetailLayoutInit() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationItem.title = "MY"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 18)!]
        self.myProfiletTitleLabel.text = "빨간 질문을 많이 답한 당신은..."
        self.myProfiletTitleLabel.font = UIFont(name: "GmarketSans-Medium", size: 13)
        self.myProfiletTitleLabel.textColor = UIColor.black
        self.myProfiletTitleLabel.textAlignment = .center
        self.myProfileSubTitleLabel.text = "현재 열정이 넘치시는군요!"
        self.myProfileSubTitleLabel.font = UIFont(name: "GmarketSans-Medium", size: 20)
        self.myProfileSubTitleLabel.textColor = UIColor.black
        self.myProfileSubTitleLabel.textAlignment = .center
        self.myProfileCategoryTitleLabel.text = "카테고리별 통계"
        self.myProfileCategoryTitleLabel.font = UIFont(name: "GmarketSans-Medium", size: 14)
        self.myProfileCategoryTitleLabel.textColor = UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.0)
        self.myProfileCategoryTitleLabel.textAlignment = .left
        self.myProfileCategoryContainerView.layer.cornerRadius = 15
        self.myProfileCategoryContainerView.layer.masksToBounds = false
        self.myProfileCategoryContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.myProfileCategoryContainerView.layer.shadowRadius = 8
        self.myProfileCategoryContainerView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1).cgColor
        self.myProfileCategoryContainerView.layer.shadowOpacity = 0.8
        self.myProfileCharacterTitleLabel.text = "열정충만"
        self.myProfileCharacterTitleLabel.font = UIFont(name: "GmarketSans-Medium", size: 14)
        self.myProfileCharacterTitleLabel.textAlignment = .left
        self.myProfileCharacterTitleLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.myProfileCharacterProgressView.transform = CGAffineTransform(scaleX: 1,y: 1.5)
        self.myProfileCharacterProgressView.tintColor = UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0)
        self.myProfileCharacterProgressView.progress = 0.1
        self.myProfileCharacterLine.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        self.myProfileCharacterLevelLabel.text = "lv.5"
        self.myProfileCharacterLevelLabel.font = UIFont(name: "GmarketSans-Medium", size: 10)
        self.myProfileCharacterLevelLabel.textAlignment = .left
        self.myProfileCharacterLevelLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        
    }
}
