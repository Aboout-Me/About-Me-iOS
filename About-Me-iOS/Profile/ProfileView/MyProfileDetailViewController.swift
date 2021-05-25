//
//  MyProfileDetailViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/28.
//

import UIKit

class MyProfileDetailViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var myProfileBackgroundImageView: UIImageView!
    @IBOutlet weak var myProfileTitleLabel: UILabel!
    @IBOutlet weak var myProfileSubTitleLabel: UILabel!
    @IBOutlet weak var myProfileCategoryTitleLabel: UILabel!
    @IBOutlet weak var myProfileCategoryContainerView: UIView!
    @IBOutlet weak var myProfileScrollView: UIScrollView!
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
    @IBOutlet weak var myProfileWeeklyTitleLabel: UILabel!
    @IBOutlet weak var myProfileWeeklyNextButton: UIButton!
    @IBOutlet weak var myProfileWeeklyLine: UIView!
    @IBOutlet weak var myProfileWeeklyPreviousButton: UIButton!
    @IBOutlet weak var myProfileWeeklyMonImageView: UIImageView!
    @IBOutlet weak var myProfileWeeklyTueImageView: UIImageView!
    @IBOutlet weak var myProfileWeeklyWedImageView: UIImageView!
    @IBOutlet weak var myProfileWeeklyThuImageView: UIImageView!
    @IBOutlet weak var myProfileWeeklyFriImageView: UIImageView!
    @IBOutlet weak var myProfileWeeklySatImageView: UIImageView!
    @IBOutlet weak var myProfileWeeklySunImageView: UIImageView!
    private var categoryData = [CategoryProgressModel]()
    private var weeklyData = [WeeklyProgressListModel]()
    public var sequence: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getWeeklyList()
        self.getCategoryList()
        self.setCategoryViewLayoutInit()
        self.setWeeklyViewLayoutInit()
    }
    
    
    private func setCategoryViewLayoutInit() {
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Settings"), style: .plain, target: self, action: nil)
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.title = "프로필"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 18)!]
        self.view.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
        self.myProfileScrollView.delegate = self
        self.myProfileScrollView.contentInsetAdjustmentBehavior = .never
        self.myProfileScrollView.automaticallyAdjustsScrollIndicatorInsets = false
        self.myProfileScrollView.bounces = false
        self.myProfileBackgroundImageView.image = UIImage(named: "bgRed")
        self.myProfileBackgroundImageView.contentMode = .scaleToFill
        self.myProfileBackgroundImageView.layer.cornerRadius = 30
        self.myProfileBackgroundImageView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        self.myProfileTitleLabel.text = "빨간 질문을 많이 답한 당신은..."
        self.myProfileTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 13)
        self.myProfileTitleLabel.textColor = UIColor.white
        self.myProfileTitleLabel.textAlignment = .center
        self.myProfileSubTitleLabel.text = "현재 열정이 넘치시는군요!"
        self.myProfileSubTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 20)
        self.myProfileSubTitleLabel.textColor = UIColor.white
        self.myProfileSubTitleLabel.textAlignment = .center
        self.myProfileCategoryTitleLabel.text = "카테고리별 통계"
        self.myProfileCategoryTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 14)
        self.myProfileCategoryTitleLabel.textColor = UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.0)
        self.myProfileCategoryTitleLabel.textAlignment = .left
        self.myProfileCategoryContainerView.layer.cornerRadius = 15
        self.myProfileCategoryContainerView.layer.masksToBounds = false
        self.myProfileCategoryContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.myProfileCategoryContainerView.layer.shadowRadius = 8
        self.myProfileCategoryContainerView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1).cgColor
        self.myProfileCategoryContainerView.layer.shadowOpacity = 0.8
        self.myProfileCharacterTitleLabel.text = "열정충만"
        self.myProfileCharacterTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 14)
        self.myProfileCharacterTitleLabel.textAlignment = .left
        self.myProfileCharacterTitleLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.myProfileCharacterProgressView.transform = CGAffineTransform(scaleX: 1,y: 1.5)
        self.myProfileCharacterProgressView.tintColor = UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0)
        self.myProfileCharacterLine.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        self.myProfileCharacterLevelLabel.font = UIFont(name: "GmarketSansMedium", size: 10)
        self.myProfileCharacterLevelLabel.textAlignment = .left
        self.myProfileCharacterLevelLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.myProfileCharacterTitleLabelTwo.text = "소소한 일상"
        self.myProfileCharacterTitleLabelTwo.font = UIFont(name: "GmarketSansMedium", size: 14)
        self.myProfileCharacterTitleLabelTwo.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.myProfileCharacterTitleLabelTwo.textAlignment = .left
        self.myProfileCharacterProgressViewTwo.transform = CGAffineTransform(scaleX: 1, y: 1.5)
        self.myProfileCharacterProgressViewTwo.tintColor = UIColor(red: 255/255, green: 215/255, blue: 73/255, alpha: 1.0)
        self.myProfileCharacterLevelLabelTwo.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.myProfileCharacterLevelLabelTwo.font = UIFont(name: "GmarketSansMedium", size: 10)
        self.myProfileCharacterLevelLabelTwo.textAlignment = .left
        self.myProfileCharacterLineTwo.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        self.myProfileCharacterTitleLabelThird.text = "기억상자"
        self.myProfileCharacterTitleLabelThird.font = UIFont(name: "GmarketSansMedium", size: 14)
        self.myProfileCharacterTitleLabelThird.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.myProfileCharacterTitleLabelThird.textAlignment = .left
        self.myProfileCharacterLevelLabelThird.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.myProfileCharacterLevelLabelThird.textAlignment = .left
        self.myProfileCharacterLevelLabelThird.font = UIFont(name: "GmarketSansMedium", size: 10)
        self.myProfileCharacterProgressViewThird.transform = CGAffineTransform(scaleX: 1, y: 1.5)
        self.myProfileCharacterProgressViewThird.tintColor = UIColor(red: 42/255, green: 212/255, blue: 141/255, alpha: 1.0)
        self.myProfileCharacterLineThird.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        self.myProfileCharacterTitleLabelFour.text = "관계의 미학"
        self.myProfileCharacterTitleLabelFour.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.myProfileCharacterTitleLabelFour.font = UIFont(name: "GmarketSansMedium", size: 14)
        self.myProfileCharacterTitleLabelFour.textAlignment = .left
        self.myProfileCharacterLevelLabelFour.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.myProfileCharacterLevelLabelFour.textAlignment = .left
        self.myProfileCharacterLevelLabelFour.font = UIFont(name: "GmarketSansMedium", size: 10)
        self.myProfileCharacterProgressViewFour.transform = CGAffineTransform(scaleX: 1, y: 1.5)
        self.myProfileCharacterProgressViewFour.tintColor = UIColor(red: 245/255, green: 103/255, blue: 154/255, alpha: 1.0)
        self.myProfileCharacterLineFive.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        self.myProfileCharacterTitleLabelFive.text = "상상플러스"
        self.myProfileCharacterTitleLabelFive.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.myProfileCharacterTitleLabelFive.font = UIFont(name: "GmarketSansMedium", size: 14)
        self.myProfileCharacterTitleLabelFive.textAlignment = .left
        self.myProfileCharacterLevelLabelFive.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.myProfileCharacterLevelLabelFive.textAlignment = .left
        self.myProfileCharacterLevelLabelFive.font = UIFont(name: "GmarketSansMedium", size: 10)
        self.myProfileCharacterProgressViewFive.transform = CGAffineTransform(scaleX: 1, y: 1.5)
        self.myProfileCharacterProgressViewFive.tintColor = UIColor(red: 169/255, green: 107/255, blue: 249/255, alpha: 1.0)
        
    }
    
    private func setWeeklyViewLayoutInit() {
        self.myProfileDayCategoryTitleLabel.text = "요일별 통계"
        self.myProfileDayCategoryTitleLabel.textColor = UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.0)
        self.myProfileDayCategoryTitleLabel.textAlignment = .left
        self.myProfileDayCategoryTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 14)
        self.myProfileDayCategoryContainerView.layer.cornerRadius = 15
        self.myProfileDayCategoryContainerView.layer.masksToBounds = false
        self.myProfileDayCategoryContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.myProfileDayCategoryContainerView.layer.shadowRadius = 8
        self.myProfileDayCategoryContainerView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1).cgColor
        self.myProfileDayCategoryContainerView.layer.shadowOpacity = 0.8
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년MM월"
        let dateString = dateFormatter.string(from: date)
        self.myProfileWeeklyTitleLabel.text = "\(dateString) 첫째주"
        self.myProfileWeeklyTitleLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        self.myProfileWeeklyTitleLabel.textAlignment = .center
        self.myProfileWeeklyTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        self.myProfileWeeklyNextButton.setImage(UIImage(named: "Arrow"), for: .normal)
        self.myProfileWeeklyNextButton.addTarget(self, action: #selector(self.weeklyNextButtonDidTap(_:)), for: .touchUpInside)
        self.myProfileWeeklyLine.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        self.myProfileWeeklyPreviousButton.setImage(UIImage(named: "PreviousArrow"), for: .normal)
        self.myProfileWeeklyPreviousButton.addTarget(self, action: #selector(self.weeklyPreviousButtonDidTap(_:)), for: .touchUpInside)
    }
    
    private func getCategoryList() {
        ProfileServerApi.getCategoryProgress(userId: 1) { result in
            if case let .success(data) = result, let list = data {
                DispatchQueue.main.async {
                    self.categoryData = list
                    if self.categoryData.isEmpty == false {
                        self.setCategoryServerProcessDidFinsh()
                    }
                }
            }
        }
    }
    private func setCategoryServerProcessDidFinsh() {
        self.myProfileCharacterProgressView.progress = self.categoryData[0].experience
        self.myProfileCharacterLevelLabel.text = "lv.\(self.categoryData[0].level)"
        self.myProfileCharacterProgressViewTwo.progress = self.categoryData[1].experience
        self.myProfileCharacterLevelLabelTwo.text = "lv.\(self.categoryData[1].level)"
        self.myProfileCharacterProgressViewThird.progress = self.categoryData[2].experience
        self.myProfileCharacterLevelLabelThird.text = "lv.\(self.categoryData[2].level)"
        self.myProfileCharacterProgressViewFour.progress = self.categoryData[3].experience
        self.myProfileCharacterLevelLabelFour.text = "lv.\(self.categoryData[3].level)"
        self.myProfileCharacterProgressViewFive.progress = self.categoryData[4].experience
        self.myProfileCharacterLevelLabelFive.text = "lv.\(self.categoryData[4].level)"
    }
    
    private func getWeeklyList(){
        ProfileServerApi.getWeeklyProgress(userId: 1) { result in
            if case let .success(data) = result, let list = data {
                self.weeklyData = list.weeklyProgressingList[0]
                print("test color",self.weeklyData)
                DispatchQueue.main.async {
                    self.setWeeklyServerProcessDidFinsh()
                }
            }
        }
    }
    private func setWeeklyServerProcessDidFinsh() {
        if self.weeklyData[0].day == "월" && self.weeklyData[0].isWritten == true {
            self.myProfileWeeklyMonImageView.image = UIImage(named: "WeeklyMon")
        } else if self.weeklyData[1].day == "화" && self.weeklyData[1].isWritten == true {
            self.myProfileWeeklyTueImageView.image = UIImage(named: "WeeklyTue")
        } else if self.weeklyData[2].day == "수" && self.weeklyData[2].isWritten == true {
            self.myProfileWeeklyWedImageView.image = UIImage(named: "WeeklyWed")
        } else if self.weeklyData[3].day == "목" && self.weeklyData[3].isWritten == true {
            self.myProfileWeeklyThuImageView.image = UIImage(named: "WeeklyThu")
        } else if self.weeklyData[4].day == "금" && self.weeklyData[4].isWritten == true {
            self.myProfileWeeklyFriImageView.image = UIImage(named: "WeeklyFri")
        } else if self.weeklyData[5].day == "토" && self.weeklyData[5].isWritten == true {
            self.myProfileWeeklySatImageView.image = UIImage(named: "WeeklySat")
        } else if self.weeklyData[6].day == "일" && self.weeklyData[6].isWritten == true {
            self.myProfileWeeklySunImageView.image = UIImage(named: "WeeklySun")
        }
    }
    
    @objc
    private func weeklyNextButtonDidTap(_ sender: UIButton) {
        ProfileServerApi.getWeeklyProgress(userId: 1) { [self] result in
            if case let .success(data) = result, let list = data {
                self.sequence += 1
                if self.sequence == 2 {
                    self.myProfileWeeklyNextButton.isEnabled = false
                }
                self.weeklyData = list.weeklyProgressingList[sequence]
                print("data\(self.sequence)" ,self.weeklyData)
                DispatchQueue.main.async {
                    self.setWeeklyServerProcessDidFinsh()
                }
            }
        }
    }
    
    @objc
    private func weeklyPreviousButtonDidTap(_ sender: UIButton) {
        ProfileServerApi.getWeeklyProgress(userId: 1) { [self] result in
            if case let .success(data) = result, let list = data {
                self.sequence -= 1
                if self.sequence == 0 {
                    self.myProfileWeeklyPreviousButton.isEnabled = false
                }
                self.weeklyData = list.weeklyProgressingList[sequence]
                DispatchQueue.main.async {
                    self.setWeeklyServerProcessDidFinsh()
                }
                print("data\(self.sequence)" ,self.weeklyData)
            }
        }
    }
}

