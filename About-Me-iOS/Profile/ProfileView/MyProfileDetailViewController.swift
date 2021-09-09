//
//  MyProfileDetailViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/28.
//

import UIKit

class MyProfileDetailViewController: UIViewController {
    
    @IBOutlet weak var myProfileBackgroundImageView: UIImageView!
    @IBOutlet weak var myProfileTitleLabel: UILabel!
    @IBOutlet weak var myProfileSubTitleLabel: UILabel!
    @IBOutlet weak var myProfileCategoryTitleLabel: UILabel!
    @IBOutlet weak var myProfileCategoryContainerView: UIView!
    @IBOutlet weak var myProfileScrollView: UIScrollView!
    @IBOutlet weak var myProfileCharacterBackgroundView: UIView!
    @IBOutlet weak var myProfileYellowCharacterBackgroundView: UIView!
    @IBOutlet weak var myProfileGreenCharacterBackgroundView: UIView!
    @IBOutlet weak var myProfilePinkCharacterBackgroundView: UIView!
    @IBOutlet weak var myProfilePurpleCharacterBackgroundView: UIView!
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
    @IBOutlet weak var myProfileMonthButton: UIButton!
    @IBOutlet weak var myProfileTuesdayButton: UIButton!
    @IBOutlet weak var myProfileWednesdayButton: UIButton!
    @IBOutlet weak var myProfileThursdayButton: UIButton!
    @IBOutlet weak var myProfileFridayButton: UIButton!
    @IBOutlet weak var myProfileSaturdayButton: UIButton!
    @IBOutlet weak var myProfileSundayButton: UIButton!
    @IBOutlet weak var myProfileMonthleadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var myProfileFridayleadingConstraint: NSLayoutConstraint!
    private var categoryData = [CategoryProgressModel]()
    private var weeklyData = [WeeklyProgressSubModel]()
    private var weeklyListData = [WeeklyProgressListModel]()
    public var sequence: Int = 0
    public var weekDay: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeeklyList()
        getCategoryList()
        setCategoryViewLayoutInit()
        setWeeklyViewLayoutInit()
        // MARK: - 수정 코드
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.standardAppearance.backgroundColor = nil
        self.navigationController?.view.backgroundColor =  UIColor(red: 244/255, green: 82/255, blue: 82/255, alpha: 1.0)
    }
    
    
    // MARK: - Layout Init
    private func setCategoryViewLayoutInit() {
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Settings"), style: .plain, target: self, action: nil)
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.standardAppearance.shadowColor = .clear
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.title = "프로필"
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ArrowLeft"), style: .plain, target: self, action: #selector(didTapNavigationButton))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18)!,NSAttributedString.Key.foregroundColor : UIColor.white]
        self.view.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
        myProfileScrollView.delegate = self
        myProfileScrollView.contentInsetAdjustmentBehavior = .never
        myProfileScrollView.automaticallyAdjustsScrollIndicatorInsets = false
        myProfileScrollView.bounces = false
        myProfileBackgroundImageView.image = UIImage(named: "bgRed")
        myProfileBackgroundImageView.contentMode = .scaleToFill
        myProfileBackgroundImageView.layer.cornerRadius = 30
        myProfileBackgroundImageView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        myProfileTitleLabel.text = "빨간 질문을 많이 답한 당신은..."
        myProfileTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 13)
        myProfileTitleLabel.textColor = UIColor.white
        myProfileTitleLabel.textAlignment = .center
        myProfileSubTitleLabel.text = "현재 열정이 넘치시는군요!"
        myProfileSubTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 20)
        myProfileSubTitleLabel.textColor = UIColor.white
        myProfileSubTitleLabel.textAlignment = .center
        myProfileCategoryTitleLabel.text = "카테고리별 통계"
        myProfileCategoryTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 14)
        myProfileCategoryTitleLabel.textColor = UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.0)
        myProfileCategoryTitleLabel.textAlignment = .left
        myProfileCategoryContainerView.layer.cornerRadius = 15
        myProfileCategoryContainerView.layer.masksToBounds = false
        myProfileCategoryContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        myProfileCategoryContainerView.layer.shadowRadius = 8
        myProfileCategoryContainerView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1).cgColor
        myProfileCategoryContainerView.layer.shadowOpacity = 0.8
        myProfileCharacterBackgroundView.layer.masksToBounds = true
        myProfileCharacterBackgroundView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        myProfileCharacterBackgroundView.layer.cornerRadius = myProfileCharacterBackgroundView.frame.size.width / 2
        myProfileYellowCharacterBackgroundView.clipsToBounds = true
        myProfileYellowCharacterBackgroundView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        myProfileYellowCharacterBackgroundView.layer.cornerRadius = myProfileYellowCharacterBackgroundView.frame.size.width / 2
        myProfileGreenCharacterBackgroundView.clipsToBounds = true
        myProfileGreenCharacterBackgroundView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        myProfileGreenCharacterBackgroundView.layer.cornerRadius = myProfileGreenCharacterBackgroundView.frame.size.width / 2
        myProfilePinkCharacterBackgroundView.clipsToBounds = true
        myProfilePinkCharacterBackgroundView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        myProfilePinkCharacterBackgroundView.layer.cornerRadius = myProfilePinkCharacterBackgroundView.frame.size.width / 2
        myProfilePurpleCharacterBackgroundView.clipsToBounds = true
        myProfilePurpleCharacterBackgroundView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        myProfilePurpleCharacterBackgroundView.layer.cornerRadius = myProfilePurpleCharacterBackgroundView.frame.size.width / 2
        myProfileCharacterTitleLabel.text = "열정충만"
        myProfileCharacterTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 14)
        myProfileCharacterTitleLabel.textAlignment = .left
        myProfileCharacterTitleLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        myProfileCharacterProgressView.transform = CGAffineTransform(scaleX: 1,y: 1.5)
        myProfileCharacterProgressView.tintColor = UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0)
        myProfileCharacterLine.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        myProfileCharacterLevelLabel.font = UIFont(name: "GmarketSansMedium", size: 10)
        myProfileCharacterLevelLabel.textAlignment = .left
        myProfileCharacterLevelLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        myProfileCharacterTitleLabelTwo.text = "소소한 일상"
        myProfileCharacterTitleLabelTwo.font = UIFont(name: "GmarketSansMedium", size: 14)
        myProfileCharacterTitleLabelTwo.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        myProfileCharacterTitleLabelTwo.textAlignment = .left
        myProfileCharacterProgressViewTwo.transform = CGAffineTransform(scaleX: 1, y: 1.5)
        myProfileCharacterProgressViewTwo.tintColor = UIColor(red: 255/255, green: 215/255, blue: 73/255, alpha: 1.0)
        myProfileCharacterLevelLabelTwo.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        myProfileCharacterLevelLabelTwo.font = UIFont(name: "GmarketSansMedium", size: 10)
        myProfileCharacterLevelLabelTwo.textAlignment = .left
        myProfileCharacterLineTwo.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        myProfileCharacterTitleLabelThird.text = "기억상자"
        myProfileCharacterTitleLabelThird.font = UIFont(name: "GmarketSansMedium", size: 14)
        myProfileCharacterTitleLabelThird.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        myProfileCharacterTitleLabelThird.textAlignment = .left
        myProfileCharacterLevelLabelThird.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        myProfileCharacterLevelLabelThird.textAlignment = .left
        myProfileCharacterLevelLabelThird.font = UIFont(name: "GmarketSansMedium", size: 10)
        myProfileCharacterProgressViewThird.transform = CGAffineTransform(scaleX: 1, y: 1.5)
        myProfileCharacterProgressViewThird.tintColor = UIColor(red: 42/255, green: 212/255, blue: 141/255, alpha: 1.0)
        myProfileCharacterLineThird.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        myProfileCharacterTitleLabelFour.text = "관계의 미학"
        myProfileCharacterTitleLabelFour.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        myProfileCharacterTitleLabelFour.font = UIFont(name: "GmarketSansMedium", size: 14)
        myProfileCharacterTitleLabelFour.textAlignment = .left
        myProfileCharacterLevelLabelFour.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        myProfileCharacterLevelLabelFour.textAlignment = .left
        myProfileCharacterLevelLabelFour.font = UIFont(name: "GmarketSansMedium", size: 10)
        myProfileCharacterProgressViewFour.transform = CGAffineTransform(scaleX: 1, y: 1.5)
        myProfileCharacterProgressViewFour.tintColor = UIColor(red: 245/255, green: 103/255, blue: 154/255, alpha: 1.0)
        myProfileCharacterLineFive.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        myProfileCharacterTitleLabelFive.text = "상상플러스"
        myProfileCharacterTitleLabelFive.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        myProfileCharacterTitleLabelFive.font = UIFont(name: "GmarketSansMedium", size: 14)
        myProfileCharacterTitleLabelFive.textAlignment = .left
        myProfileCharacterLevelLabelFive.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        myProfileCharacterLevelLabelFive.textAlignment = .left
        myProfileCharacterLevelLabelFive.font = UIFont(name: "GmarketSansMedium", size: 10)
        myProfileCharacterProgressViewFive.transform = CGAffineTransform(scaleX: 1, y: 1.5)
        myProfileCharacterProgressViewFive.tintColor = UIColor(red: 169/255, green: 107/255, blue: 249/255, alpha: 1.0)
        myProfileMonthButton.setTitleColor(UIColor.grayCcc, for: .normal)
        myProfileMonthButton.titleLabel?.font = UIFont(name: "GmarketSansMedium", size: 13)
        myProfileTuesdayButton.setTitleColor(UIColor.grayCcc, for: .normal)
        myProfileTuesdayButton.titleLabel?.font = UIFont(name: "GmarketSansMedium", size: 13)
        myProfileWednesdayButton.setTitleColor(UIColor.grayCcc, for: .normal)
        myProfileWednesdayButton.titleLabel?.font = UIFont(name: "GmarketSansMedium", size: 13)
        myProfileThursdayButton.setTitleColor(UIColor.grayCcc, for: .normal)
        myProfileThursdayButton.titleLabel?.font = UIFont(name: "GmarketSansMedium", size: 13)
        myProfileFridayButton.setTitleColor(UIColor.grayCcc, for: .normal)
        myProfileFridayButton.titleLabel?.font = UIFont(name: "GmarketSansMedium", size: 13)
        myProfileSaturdayButton.setTitleColor(UIColor.grayCcc, for: .normal)
        myProfileSaturdayButton.titleLabel?.font = UIFont(name: "GmarketSansMedium", size: 13)
        myProfileSundayButton.setTitleColor(UIColor.grayCcc, for: .normal)
        myProfileSundayButton.titleLabel?.font = UIFont(name: "GmarketSansMedium", size: 13)
    }
    
    private func setWeeklyViewLayoutInit() {
        myProfileDayCategoryTitleLabel.text = "요일별 통계"
        myProfileDayCategoryTitleLabel.textColor = UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.0)
        myProfileDayCategoryTitleLabel.textAlignment = .left
        myProfileDayCategoryTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 14)
        myProfileDayCategoryContainerView.layer.cornerRadius = 15
        myProfileDayCategoryContainerView.layer.masksToBounds = false
        myProfileDayCategoryContainerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        myProfileDayCategoryContainerView.layer.shadowRadius = 8
        myProfileDayCategoryContainerView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1).cgColor
        myProfileDayCategoryContainerView.layer.shadowOpacity = 0.8
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년MM월"
        let dateString = dateFormatter.string(from: date)
        myProfileWeeklyTitleLabel.text = "\(dateString) 첫째주"
        myProfileWeeklyTitleLabel.textColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0)
        myProfileWeeklyTitleLabel.textAlignment = .center
        myProfileWeeklyTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        myProfileWeeklyNextButton.setImage(UIImage(named: "Arrow_Profile"), for: .normal)
        myProfileWeeklyNextButton.addTarget(self, action: #selector(MyProfileDetailViewController.weeklyNextButtonDidTap(_:)), for: .touchUpInside)
        myProfileWeeklyLine.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        myProfileWeeklyPreviousButton.setImage(UIImage(named: "PreviousArrow"), for: .normal)
        myProfileWeeklyPreviousButton.addTarget(self, action: #selector(MyProfileDetailViewController.weeklyPreviousButtonDidTap(_:)), for: .touchUpInside)
        if UIScreen.main.bounds.size.width < 414 {
            myProfileMonthleadingConstraint.constant = 40
            myProfileFridayleadingConstraint.constant = 79
            self.view.layoutIfNeeded()
        } else {
            myProfileMonthleadingConstraint.constant = 70
            myProfileFridayleadingConstraint.constant = 109
            self.view.layoutIfNeeded()
        }
        
    }
    
    // MARK: GET UserCategory API
    private func getCategoryList() {
        ProfileServerApi.getCategoryProgress(userId: USER_ID) { [self] result in
            if case let .success(data) = result, let list = data {
                DispatchQueue.main.async {
                    categoryData = list
                    if categoryData.isEmpty == false {
                        setCategoryServerProcessDidFinsh()
                    }
                }
            }
        }
    }
    
    // MARK: - Character UI Set
    private func setCategoryServerProcessDidFinsh() {
        myProfileCharacterProgressView.progress = categoryData[0].experience
        myProfileCharacterLevelLabel.text = "lv.\(categoryData[0].level)"
        myProfileCharacterProgressViewTwo.progress = categoryData[1].experience
        myProfileCharacterLevelLabelTwo.text = "lv.\(categoryData[1].level)"
        myProfileCharacterProgressViewThird.progress = categoryData[2].experience
        myProfileCharacterLevelLabelThird.text = "lv.\(categoryData[2].level)"
        myProfileCharacterProgressViewFour.progress = categoryData[3].experience
        myProfileCharacterLevelLabelFour.text = "lv.\(categoryData[3].level)"
        myProfileCharacterProgressViewFive.progress = categoryData[4].experience
        myProfileCharacterLevelLabelFive.text = "lv.\(categoryData[4].level)"
    }
    
    // MARK: - Now Date Set
    private func setnowDate() {
        weekDay = weeklyListData.count - 1
        
        if weekDay == 0 {
            myProfileWeeklyTitleLabel.text = weeklyListData[0].date
        } else if weekDay == 1 {
            myProfileWeeklyTitleLabel.text = weeklyListData[1].date
        } else if weekDay == 2 {
            myProfileWeeklyTitleLabel.text = weeklyListData[2].date
        } else if weekDay == 3 {
            myProfileWeeklyTitleLabel.text = weeklyListData[3].date
        } else {
            myProfileWeeklyTitleLabel.text = weeklyListData[4].date
        }
    }
    
    // MARK: - Increment Date Set
    private func updateDate() {
        weekDay = weekDay + 1
        if weekDay == 0 {
            myProfileWeeklyTitleLabel.text = weeklyListData[0].date
        } else if weekDay == 1 {
            myProfileWeeklyTitleLabel.text = weeklyListData[1].date
        } else if weekDay == 2 {
            myProfileWeeklyTitleLabel.text = weeklyListData[2].date
        } else if weekDay == 3 {
            myProfileWeeklyTitleLabel.text = weeklyListData[3].date
        } else {
            myProfileWeeklyTitleLabel.text = weeklyListData[4].date
        }
        
    }
    
    // MARK: - Decrement Date Set
    private func previousDate() {
        weekDay = weekDay - 1
        print("weekDay Number \(weekDay)")
        if weekDay == 0 {
            myProfileWeeklyTitleLabel.text = weeklyListData[0].date
        } else if weekDay == 1 {
            myProfileWeeklyTitleLabel.text = weeklyListData[1].date
        } else if weekDay == 2 {
            myProfileWeeklyTitleLabel.text = weeklyListData[2].date
        } else {
            myProfileWeeklyTitleLabel.text = weeklyListData[3].date
        }
    }
    
    // MARK: - GET Weekly List
    private func getWeeklyList(){
        ProfileServerApi.getWeeklyProgress(userId: USER_ID) { [self] result in
            if case let .success(data) = result, let list = data {
                var indexRow = list.weeklyProgressingList.count - 1
                sequence = indexRow
                print("get indexRow value \(indexRow)")
                weeklyData = list.weeklyProgressingList[indexRow].week!
                weeklyListData = list.weeklyProgressingList
                let index = weeklyListData.endIndex - 1
                if weeklyListData[index].week == nil || weeklyListData[index].date == nil {
                    weeklyListData.removeLast()
                }
                setnowDate()
                if list.weeklyProgressingList.count == 1 {
                    myProfileWeeklyNextButton.isEnabled = false
                } else {
                    myProfileWeeklyNextButton.isEnabled = true
                }
                DispatchQueue.main.async {
                    setWeeklyServerProcessDidFinsh()
                    if sequence == weeklyListData.endIndex - 1 {
                        myProfileWeeklyNextButton.isEnabled = false
                    }
                    if sequence == weeklyListData.startIndex {
                        myProfileWeeklyPreviousButton.isEnabled = false
                    }
                }
            }
        }
    }
    
    // MARK: - Weekly UI Set
    private func setWeeklyServerProcessDidFinsh() {
        if weeklyData[0].day == "월" && weeklyData[0].isWritten == true {
            if weeklyData[0].color == "red" {
                myProfileMonthButton.setBackgroundImage(UIImage(named: "StampRed"), for: .normal)
                myProfileMonthButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[0].color == "yellow" {
                myProfileMonthButton.setBackgroundImage(UIImage(named: "StampYellow"), for: .normal)
                myProfileMonthButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[0].color == "green" {
                myProfileMonthButton.setBackgroundImage(UIImage(named: "StampGreen"), for: .normal)
                myProfileMonthButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[0].color == "pink" {
                myProfileMonthButton.setBackgroundImage(UIImage(named: "StampPink"), for: .normal)
                myProfileMonthButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[0].color == "purple" {
                myProfileMonthButton.setBackgroundImage(UIImage(named: "StampPurple"), for: .normal)
                myProfileMonthButton.setTitleColor(UIColor.white, for: .normal)
            }
        } else {
            myProfileMonthButton.setBackgroundImage(UIImage(named: "StampDefault"), for: .normal)
            myProfileMonthButton.setTitleColor(UIColor.grayCcc, for: .normal)
        }
        if weeklyData[1].day == "화" && weeklyData[1].isWritten == true {
            if weeklyData[1].color == "red" {
                myProfileTuesdayButton.setBackgroundImage(UIImage(named: "StampRed"), for: .normal)
                myProfileTuesdayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[1].color == "yellow" {
                myProfileTuesdayButton.setBackgroundImage(UIImage(named: "StampYellow"), for: .normal)
                myProfileTuesdayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[1].color == "green" {
                myProfileTuesdayButton.setBackgroundImage(UIImage(named: "StampGreen"), for: .normal)
                myProfileTuesdayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[1].color == "pink" {
                myProfileTuesdayButton.setBackgroundImage(UIImage(named: "StampPink"), for: .normal)
                myProfileTuesdayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[1].color == "purple" {
                myProfileTuesdayButton.setBackgroundImage(UIImage(named: "StampPurple"), for: .normal)
                myProfileTuesdayButton.setTitleColor(UIColor.white, for: .normal)
            }
        } else {
            myProfileTuesdayButton.setBackgroundImage(UIImage(named: "StampDefault"), for: .normal)
            myProfileTuesdayButton.setTitleColor(UIColor.grayCcc, for: .normal)
        }
        if weeklyData[2].day == "수" && weeklyData[2].isWritten == true {
            if weeklyData[2].color == "red" {
                myProfileWednesdayButton.setBackgroundImage(UIImage(named: "StampRed"), for: .normal)
                myProfileWednesdayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[2].color == "yellow" {
                myProfileWednesdayButton.setBackgroundImage(UIImage(named: "StampYellow"), for: .normal)
                myProfileWednesdayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[2].color == "green" {
                myProfileWednesdayButton.setBackgroundImage(UIImage(named: "StampGreen"), for: .normal)
                myProfileWednesdayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[2].color == "pink" {
                myProfileWednesdayButton.setBackgroundImage(UIImage(named: "StampPink"), for: .normal)
                myProfileWednesdayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[2].color == "purple" {
                myProfileWednesdayButton.setBackgroundImage(UIImage(named: "StampPurple"), for: .normal)
                myProfileWednesdayButton.setTitleColor(UIColor.white, for: .normal)
            }
        } else {
            myProfileWednesdayButton.setBackgroundImage(UIImage(named: "StampDefault"), for: .normal)
            myProfileWednesdayButton.setTitleColor(UIColor.grayCcc, for: .normal)
        }
        if weeklyData[3].day == "목" && weeklyData[3].isWritten == true {
            if weeklyData[3].color == "red" {
                myProfileThursdayButton.setBackgroundImage(UIImage(named: "StampRed"), for: .normal)
                myProfileThursdayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[3].color == "yellow" {
                myProfileThursdayButton.setBackgroundImage(UIImage(named: "StampYellow"), for: .normal)
                myProfileThursdayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[3].color == "green" {
                myProfileThursdayButton.setBackgroundImage(UIImage(named: "StampGreen"), for: .normal)
                myProfileThursdayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[3].color == "pink" {
                myProfileThursdayButton.setBackgroundImage(UIImage(named: "StampPink"), for: .normal)
                myProfileThursdayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[3].color == "purple" {
                myProfileThursdayButton.setBackgroundImage(UIImage(named: "StampPurple"), for: .normal)
                myProfileThursdayButton.setTitleColor(UIColor.white, for: .normal)
            }
        } else {
            myProfileThursdayButton.setBackgroundImage(UIImage(named: "StampDefault"), for: .normal)
            myProfileThursdayButton.setTitleColor(UIColor.grayCcc, for: .normal)
        }
        if weeklyData[4].day == "금" && weeklyData[4].isWritten == true {
            if weeklyData[4].color == "red" {
                myProfileFridayButton.setBackgroundImage(UIImage(named: "StampRed"), for: .normal)
                myProfileFridayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[4].color == "yellow" {
                myProfileFridayButton.setBackgroundImage(UIImage(named: "StampYellow"), for: .normal)
                myProfileFridayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[4].color == "green" {
                myProfileFridayButton.setBackgroundImage(UIImage(named: "StampGreen"), for: .normal)
                myProfileFridayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[4].color == "pink" {
                myProfileFridayButton.setBackgroundImage(UIImage(named: "StampPink"), for: .normal)
                myProfileFridayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[4].color == "purple" {
                myProfileFridayButton.setBackgroundImage(UIImage(named: "StampPurple"), for: .normal)
                myProfileFridayButton.setTitleColor(UIColor.white, for: .normal)
            }
        } else {
            myProfileFridayButton.setBackgroundImage(UIImage(named: "StampDefault"), for: .normal)
            myProfileFridayButton.setTitleColor(UIColor.grayCcc, for: .normal)
        }
        if weeklyData[5].day == "토" && weeklyData[5].isWritten == true {
            if weeklyData[5].color == "red" {
                myProfileSaturdayButton.setBackgroundImage(UIImage(named: "StampRed"), for: .normal)
                myProfileSaturdayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[5].color == "yellow" {
                myProfileSaturdayButton.setBackgroundImage(UIImage(named: "StampYellow"), for: .normal)
                myProfileSaturdayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[5].color == "green" {
                myProfileSaturdayButton.setBackgroundImage(UIImage(named: "StampGreen"), for: .normal)
                myProfileSaturdayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[5].color == "pink" {
                myProfileSaturdayButton.setBackgroundImage(UIImage(named: "StampPink"), for: .normal)
                myProfileSaturdayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[5].color == "purple" {
                myProfileSaturdayButton.setBackgroundImage(UIImage(named: "StampPurple"), for: .normal)
                myProfileSaturdayButton.setTitleColor(UIColor.white, for: .normal)
            }
        } else {
            myProfileSaturdayButton.setBackgroundImage(UIImage(named: "StampDefault"), for: .normal)
            myProfileSaturdayButton.setTitleColor(UIColor.grayCcc, for: .normal)
        }
        if weeklyData[6].day == "일" && weeklyData[6].isWritten == true {
            if weeklyData[6].color == "red" {
                myProfileSundayButton.setBackgroundImage(UIImage(named: "StampRed"), for: .normal)
                myProfileSundayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[6].color == "yellow" {
                myProfileSundayButton.setBackgroundImage(UIImage(named: "StampYellow"), for: .normal)
                myProfileSundayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[6].color == "green" {
                myProfileSundayButton.setBackgroundImage(UIImage(named: "StampGreen"), for: .normal)
                myProfileSundayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[6].color == "pink" {
                myProfileSundayButton.setBackgroundImage(UIImage(named: "StampPink"), for: .normal)
                myProfileSundayButton.setTitleColor(UIColor.white, for: .normal)
            } else if weeklyData[6].color == "purple" {
                myProfileSundayButton.setBackgroundImage(UIImage(named: "StampPurple"), for: .normal)
                myProfileSundayButton.setTitleColor(UIColor.white, for: .normal)
            }
        } else {
            myProfileSundayButton.setBackgroundImage(UIImage(named: "StampDefault"), for: .normal)
            myProfileSundayButton.setTitleColor(UIColor.grayCcc, for: .normal)
        }
    }
    
    
    //MARK: - Action
    @objc
    private func weeklyNextButtonDidTap(_ sender: UIButton) {
        ProfileServerApi.getWeeklyProgress(userId: USER_ID) {  [self] result in
            if case let .success(data) = result, let list = data {
                sequence += 1
                print("list end count \(sequence)")
                print("list end index count \(weeklyListData.endIndex)")
                if sequence == weeklyListData.endIndex - 1 {
                    myProfileWeeklyNextButton.isEnabled = false
                    myProfileWeeklyPreviousButton.isEnabled = true
                    weeklyData = list.weeklyProgressingList[sequence].week!
                } else {
                    myProfileWeeklyPreviousButton.isEnabled = true
                    weeklyData = list.weeklyProgressingList[sequence].week!
                }
                DispatchQueue.main.async {
                    setWeeklyServerProcessDidFinsh()
                    updateDate()
                }
            }
        }
    }
    
    @objc
    private func weeklyPreviousButtonDidTap(_ sender: UIButton) {
        ProfileServerApi.getWeeklyProgress(userId: USER_ID) { [self] result in
            if case let .success(data) = result, let list = data {
                sequence -= 1
                print("list count \(sequence)")
                print("list start count \(weeklyListData.startIndex)")
                if sequence == weeklyListData.startIndex {
                    myProfileWeeklyPreviousButton.isEnabled = false
                    myProfileWeeklyNextButton.isEnabled = true
                    weeklyData = list.weeklyProgressingList[sequence].week!
                } else {
                    myProfileWeeklyNextButton.isEnabled = true
                    weeklyData = list.weeklyProgressingList[sequence].week!
                }
                DispatchQueue.main.async {
                    setWeeklyServerProcessDidFinsh()
                    previousDate()
                }
            }
        }
    }
    @objc
    public func didTapNavigationButton() {
        self.navigationController?.popViewController(animated: true)
    }
}


// MARK: - Protocol
extension MyProfileDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let naviBarHeight = self.navigationController?.navigationBar.frame.minY ?? 0
        if scrollView.contentOffset.y > naviBarHeight {
            UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
                self.navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor(red: 244/255, green: 82/255, blue: 82/255, alpha: 1.0)
                self.navigationController?.navigationBar.isTranslucent = false
                self.myProfileBackgroundImageView.isHidden = true
            }, completion: nil)
        } else {
            self.navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.view.backgroundColor = UIColor.white
            UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
                self.myProfileBackgroundImageView.isHidden = false
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }

}
