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
    @IBOutlet weak var myProfileCharcterImageViewTwo: UIImageView!
    @IBOutlet weak var myProfileCharacterTitleLabelTwo: UILabel!
    @IBOutlet weak var myProfileCharacterLevelLabelTwo: UILabel!
    @IBOutlet weak var myProfileCharacterProgressViewTwo: UIProgressView!
    @IBOutlet weak var myProfileCharacterLineTwo: UIView!
    @IBOutlet weak var myProfileCharacterLine: UIView!
    @IBOutlet weak var myProfileCharacterImageViewThird: UIImageView!
    @IBOutlet weak var myProfileCharacterTitleLabelThird: UILabel!
    @IBOutlet weak var myProfileCharacterProgressViewThird: UIProgressView!
    @IBOutlet weak var myProfileCharacterLevelLabelThird: UILabel!
    @IBOutlet weak var myProfileCharacterLineThird: UIView!
    @IBOutlet weak var myProfileCharacterImageViewFour: UIImageView!
    @IBOutlet weak var myProfileCharacterTitleLabelFour: UILabel!
    @IBOutlet weak var myProfileCharacterProgressViewFour: UIProgressView!
    @IBOutlet weak var myProfileCharacterImageViewFive: UIImageView!
    @IBOutlet weak var myProfileCharacterLevelLabelFour: UILabel!
    @IBOutlet weak var myProfileCharacterLineFive: UIView!
    @IBOutlet weak var myProfileCharacterTitleLabelFive: UILabel!
    @IBOutlet weak var myProfileCharacterProgressViewFive: UIProgressView!
    @IBOutlet weak var myProfileCharacterLevelLabelFive: UILabel!
    @IBOutlet weak var myProfileDayCategoryTitleLabel: UILabel!
    @IBOutlet weak var myProfileDayCategoryContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setDetailLayoutInit()
        
    }
    
    
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
        self.myProfileCharacterTitleLabelTwo.text = "소소한 일상"
        self.myProfileCharacterTitleLabelTwo.font = UIFont(name: "GmarketSans-Medium", size: 14)
        self.myProfileCharacterTitleLabelTwo.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.myProfileCharacterTitleLabelTwo.textAlignment = .left
        self.myProfileCharacterProgressViewTwo.transform = CGAffineTransform(scaleX: 1, y: 1.5)
        self.myProfileCharacterProgressViewTwo.tintColor = UIColor(red: 255/255, green: 215/255, blue: 73/255, alpha: 1.0)
        self.myProfileCharacterProgressViewTwo.progress = 0.3
        self.myProfileCharacterLevelLabelTwo.text = "lv.2"
        self.myProfileCharacterLevelLabelTwo.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.myProfileCharacterLevelLabelTwo.font = UIFont(name: "GmarketSans-Medium", size: 10)
        self.myProfileCharacterLevelLabelTwo.textAlignment = .left
        self.myProfileCharacterLineTwo.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        self.myProfileCharacterTitleLabelThird.text = "관계의: 미학"
        self.myProfileCharacterTitleLabelThird.font = UIFont(name: "GmarketSans-Medium", size: 14)
        self.myProfileCharacterTitleLabelThird.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.myProfileCharacterTitleLabelThird.textAlignment = .left
        self.myProfileCharacterLevelLabelThird.text = "lv.1"
        self.myProfileCharacterLevelLabelThird.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.myProfileCharacterLevelLabelThird.textAlignment = .left
        self.myProfileCharacterLevelLabelThird.font = UIFont(name: "GmarketSans-Medium", size: 10)
        self.myProfileCharacterProgressViewThird.transform = CGAffineTransform(scaleX: 1, y: 1.5)
        self.myProfileCharacterProgressViewThird.progress = 0.2
        self.myProfileCharacterProgressViewThird.tintColor = UIColor(red: 251/255, green: 131/255, blue: 174/255, alpha: 1.0)
        self.myProfileCharacterLineThird.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        self.myProfileCharacterTitleLabelFour.text = "기억상자"
        self.myProfileCharacterTitleLabelFour.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.myProfileCharacterTitleLabelFour.font = UIFont(name: "GmarketSans-Medium", size: 10)
        self.myProfileCharacterTitleLabelFour.textAlignment = .left
        self.myProfileCharacterLevelLabelFour.text = "lv.4"
        self.myProfileCharacterLevelLabelFour.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.myProfileCharacterLevelLabelFour.textAlignment = .left
        self.myProfileCharacterLevelLabelFour.font = UIFont(name: "GmarketSans-Medium", size: 10)
        self.myProfileCharacterProgressViewFour.transform = CGAffineTransform(scaleX: 1, y: 1.5)
        self.myProfileCharacterProgressViewFour.tintColor = UIColor(red: 58/255, green: 217/255, blue: 150/255, alpha: 1.0)
        self.myProfileCharacterProgressViewFour.progress = 0.8
        self.myProfileCharacterLineFive.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        self.myProfileCharacterTitleLabelFive.text = "상상플러스"
        self.myProfileCharacterTitleLabelFive.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.myProfileCharacterTitleLabelFive.font = UIFont(name: "GmarketSans-Medium", size: 10)
        self.myProfileCharacterTitleLabelFive.textAlignment = .left
        self.myProfileCharacterLevelLabelFive.text = "lv.3"
        self.myProfileCharacterLevelLabelFive.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.myProfileCharacterLevelLabelFive.textAlignment = .left
        self.myProfileCharacterLevelLabelFive.font = UIFont(name: "GmarketSans-Medium", size: 10)
        self.myProfileCharacterProgressViewFive.transform = CGAffineTransform(scaleX: 1, y: 1.5)
        self.myProfileCharacterProgressViewFive.tintColor = UIColor(red: 169/255, green: 107/255, blue: 249/255, alpha: 1.0)
        self.myProfileCharacterProgressViewFive.progress = 0.5
        self.myProfileDayCategoryTitleLabel.text = "요일별 통계"
        self.myProfileDayCategoryTitleLabel.textColor = UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.0)
        self.myProfileDayCategoryTitleLabel.textAlignment = .left
        self.myProfileDayCategoryTitleLabel.font = UIFont(name: "GmarketSans-Medium", size: 14)
        self.myProfileDayCategoryContainerView.layer.cornerRadius = 15
        self.myProfileDayCategoryContainerView.layer.masksToBounds = false
        self.myProfileDayCategoryContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.myProfileDayCategoryContainerView.layer.shadowRadius = 8
        self.myProfileDayCategoryContainerView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1).cgColor
        self.myProfileDayCategoryContainerView.layer.shadowOpacity = 0.8
    }
}
