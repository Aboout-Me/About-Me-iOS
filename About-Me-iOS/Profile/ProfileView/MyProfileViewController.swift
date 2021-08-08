//
//  MyProfileViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/01.
//

import UIKit
import Floaty
import SideMenu
import Alamofire

class MyProfileViewController: UIViewController,SideMenuNavigationControllerDelegate {
    @IBOutlet weak var detailPushButton: UIButton!
    @IBOutlet weak var myProfileBackgroundImageView: UIImageView!
    @IBOutlet weak var myProfileCharacterNameLabel: UILabel!
    @IBOutlet weak var myProfileCharacterContentLabel: UILabel!
    @IBOutlet weak var myProfileNickNameLabel: UILabel!
    @IBOutlet weak var myProfileFirstTagContainerView: UIView!
    @IBOutlet weak var myProfileSecondTagContainerView: UIView!
    @IBOutlet weak var myProfileThirdTagContainerView: UIView!
    @IBOutlet weak var myProfileFirstTagLabel: UILabel!
    @IBOutlet weak var myProfileSecondTagLabel: UILabel!
    @IBOutlet weak var myProfileThirdTagLabel: UILabel!
    @IBOutlet weak var myProfileContentContainerView: UIView!
    @IBOutlet weak var myProfileMyAnswerButton: UIButton!
    @IBOutlet weak var myProfileButtonBottomView: UIView!
    @IBOutlet weak var myProfileMyLikeButton: UIButton!
    @IBOutlet weak var myProfileMyScrapButton: UIButton!
    @IBOutlet weak var myProfileBottomLineView: UIView!
    @IBOutlet weak var myProfileCollectionView: UICollectionView!
    @IBOutlet weak var myProfileImageViewContainer: UIView!
    @IBOutlet weak var myProfileTagCollectionView: UICollectionView!
    @IBOutlet weak var myProfileImageView: UIImageView!
    @IBOutlet weak var myProfileFloatingButton: Floaty!
    @IBOutlet weak var myProfileContentViewRaiseButton: UIButton!
    var myProfileBottomLineViewLeadingConstraint:NSLayoutConstraint!
    var myProfileBottomLineViewWidthConstraint: NSLayoutConstraint!
    var myProfileImageViewContainerWidthConstraint: NSLayoutConstraint!
    var myprofileImageViewContainerHeightConstraint: NSLayoutConstraint!
    var myprofileContentLabelBottomConstraint: NSLayoutConstraint!
    var myprofileImageViewWidthConstraint: NSLayoutConstraint!
    var myprofileImageViewHeightConstraint: NSLayoutConstraint!
    var myprofileImageViewCenterXConstraint: NSLayoutConstraint!
    var myprofileImageViewCenterYConstraint: NSLayoutConstraint!
    private var tagNameList = ["전체","열정충만","소소한 일상","기억상자","관계의미학","상상플러스"]
    public var sideMenu: SideMenuNavigationController?
    public var myProfileColor = ""
    public var myProfileData: MyProfilePage? = nil
    public var myProfileFlag = "answer"
    public var myProfileSubData = [MyProfilePageModel]()
    public var myProfileLikeScrapData: MyProfileLikeScrapList? = nil
    public var myProfileLikeScrapSubData = [MyProfileLikeScrapModelBody]()
    public var myProfileTagIndex = 0
    public var myProfileisFlag = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMyProfileList()
        self.setMyProfileSideMenuLayout()
        self.setInitLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.standardAppearance.shadowColor = UIColor(white: 255/255, alpha: 0.2)
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    private func setMyProfileSideMenuLayout() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sideOnlyViewController: SideOnlyViewController = storyboard.instantiateViewController(withIdentifier: "SideOnlyViewController") as! SideOnlyViewController
        self.sideMenu = SideMenuNavigationController(rootViewController: sideOnlyViewController)
        self.sideMenu?.leftSide = true
    }
    
    
    private func setInitLayout() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "NewMenu.png"), style: .plain, target: self, action: #selector(self.didTapSideMenuButton))
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        let navigationApp = UINavigationBarAppearance()
        navigationApp.configureWithTransparentBackground()
        self.navigationController?.navigationBar.standardAppearance = navigationApp
        self.navigationController?.navigationBar.compactAppearance = navigationApp
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18)!,NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.standardAppearance.shadowColor = UIColor(white: 255/255, alpha: 0.2)
        self.navigationItem.title = "프로필"
        let mainNib = UINib(nibName: "MyProfileCollectionViewCell", bundle: nil)
        let tagNib = UINib(nibName: "MyProfileTagCollectionViewCell", bundle: nil)
        let emptyNib = UINib(nibName: "MyProfileEmptyCollectionViewCell", bundle: nil)
        self.myProfileCollectionView.register(mainNib, forCellWithReuseIdentifier: "MyProfileCell")
        self.myProfileTagCollectionView.register(tagNib, forCellWithReuseIdentifier: "MyProfileTagCell")
        self.myProfileCollectionView.register(emptyNib, forCellWithReuseIdentifier: "MyProfileEmptyCell")
        self.myProfileCollectionView.delegate = self
        self.myProfileCollectionView.dataSource = self
        self.myProfileTagCollectionView.delegate = self
        self.myProfileTagCollectionView.dataSource = self
        self.myProfileBackgroundImageView.image = UIImage(named: "imgBackgroundRed.png")
        self.myProfileBackgroundImageView.contentMode = .scaleToFill
        self.myProfileTagCollectionView.showsHorizontalScrollIndicator = false
        self.myProfileTagCollectionView.allowsMultipleSelection = false
        self.myProfileCharacterNameLabel.text = "열정충만"
        self.myProfileCharacterNameLabel.textColor = .white
        self.myProfileCharacterNameLabel.textAlignment = .left
        self.myProfileCharacterNameLabel.font = UIFont(name: "GmarketSansMedium", size: 16)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        self.myProfileCharacterContentLabel.numberOfLines = 0
        self.myProfileCharacterContentLabel.textColor = .white
        self.myProfileCharacterContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        self.myProfileCharacterContentLabel.textAlignment = .left
        self.myProfileCharacterContentLabel.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        self.myProfileImageViewContainer.clipsToBounds = true
        self.myProfileImageViewContainer.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        self.myProfileImageViewContainer.layer.cornerRadius = self.myProfileImageViewContainer.frame.size.width / 2
        self.myProfileImageView.image = UIImage(named: "CharacterRed.png")
        self.myProfileNickNameLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        self.myProfileNickNameLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 11)
        self.myProfileNickNameLabel.textAlignment = .left
        self.detailPushButton.setImage(UIImage(named: "WhiteArrow"), for: .normal)
        self.detailPushButton.addTarget(self, action: #selector(self.didTapdetailPushButton), for: .touchUpInside)
        self.myProfileFirstTagContainerView.layer.borderWidth = 1
        self.myProfileFirstTagContainerView.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4).cgColor
        self.myProfileFirstTagContainerView.backgroundColor = .clear
        self.myProfileFirstTagContainerView.layer.cornerRadius = 3
        self.myProfileFirstTagLabel.textColor = .white
        self.myProfileFirstTagLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 9)
        self.myProfileFirstTagLabel.textAlignment = .left
        self.myProfileSecondTagContainerView.layer.cornerRadius = 3
        self.myProfileSecondTagContainerView.layer.borderWidth = 1
        self.myProfileSecondTagContainerView.backgroundColor = .clear
        self.myProfileSecondTagContainerView.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4).cgColor
        self.myProfileSecondTagLabel.textColor = .white
        self.myProfileSecondTagLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 9)
        self.myProfileSecondTagLabel.textAlignment = .left
        self.myProfileThirdTagContainerView.layer.cornerRadius = 3
        self.myProfileThirdTagContainerView.layer.borderWidth = 1
        self.myProfileThirdTagContainerView.backgroundColor = .clear
        self.myProfileThirdTagContainerView.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4).cgColor
        self.myProfileThirdTagLabel.textColor = .white
        self.myProfileThirdTagLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 9)
        self.myProfileThirdTagLabel.textAlignment = .left
        self.myProfileContentContainerView.layer.cornerRadius = 25
        self.myProfileContentContainerView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        self.myProfileContentContainerView.clipsToBounds = true
        self.myProfileMyAnswerButton.isSelected = true
        self.myProfileMyAnswerButton.setTitle("내가 한 답", for: .normal)
        self.myProfileMyAnswerButton.titleLabel?.font = UIFont(name: "GmarketSansMedium", size: 14)
        self.myProfileMyAnswerButton.titleLabel?.textAlignment = .center
        self.myProfileMyAnswerButton.setTitleColor(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0), for: .selected)
        self.myProfileMyLikeButton.setTitle("좋아요", for: .normal)
        self.myProfileMyLikeButton.titleLabel?.font = UIFont(name: "GmarketSansMedium", size: 14)
        self.myProfileMyLikeButton.titleLabel?.textAlignment = .center
        self.myProfileMyLikeButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.myProfileMyScrapButton.setTitle("스크랩", for: .normal)
        self.myProfileMyScrapButton.titleLabel?.font = UIFont(name: "GmarketSansMedium", size: 14)
        self.myProfileMyScrapButton.titleLabel?.textAlignment = .center
        self.myProfileMyScrapButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.myProfileButtonBottomView.backgroundColor = UIColor.lineEee
        self.myProfileBottomLineView.translatesAutoresizingMaskIntoConstraints = false
        self.myProfileBottomLineView.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.myProfileBottomLineViewWidthConstraint = self.myProfileBottomLineView.widthAnchor.constraint(equalToConstant: 62)
        self.myProfileBottomLineViewWidthConstraint.isActive = true
        self.myProfileBottomLineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        self.myProfileContentViewRaiseButton.setImage(UIImage(named: "VerticalArrow"), for: .normal)
        self.myProfileContentViewRaiseButton.addTarget(self, action: #selector(self.didTapRaiseButton(_:)), for: .touchUpInside)
        self.myProfileBottomLineView.bottomAnchor.constraint(equalTo: self.myProfileMyAnswerButton.bottomAnchor, constant: 0).isActive = true
        self.myProfileMyLikeButton.addTarget(self, action: #selector(self.didTapMyLikeButton(_:)), for: .touchUpInside)
        self.myProfileMyScrapButton.addTarget(self, action: #selector(self.didTapMyScrapButton(_:)), for: .touchUpInside)
        self.myProfileMyAnswerButton.addTarget(self, action: #selector(self.didTapMyAnswerButton(_:)), for: .touchUpInside)
        self.myProfileFloatingButton.buttonColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.myProfileFloatingButton.plusColor = UIColor.white
        self.myProfileFloatingButton.selectedColor = UIColor.gray999
        self.myProfileFloatingButton.sticky = true
        self.myProfileFloatingButton.addItem("오늘의 질문", icon: UIImage(named: "Write.png")) { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeBeforeView = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeBeforeViewController
            guard let homeBeforeVC = homeBeforeView else { return }
            self.navigationController?.pushViewController(homeBeforeVC, animated: true)
        }
        self.myProfileFloatingButton.addItem("자문 자답", icon: UIImage(named: "SelfQuestion.png")) { item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let advisoryAnswerView = storyboard.instantiateViewController(withIdentifier: "AdvisoryAnswerVC") as? AdvisoryAnswerViewController
            guard let advisoryAnswerVC = advisoryAnswerView else { return }
            self.navigationController?.pushViewController(advisoryAnswerVC, animated: true)
        }
        self.myProfileFloatingButton.addItem("내 피드", icon: UIImage(named: "icoFeed.png")) { _ in
            let moreVC = SocialMoreContentViewController(nibName: "SocialMoreContentViewController", bundle: nil)
            moreVC.state = .none
            self.navigationController?.pushViewController(moreVC, animated: true)
        }
        if UIScreen.main.bounds.size.width >= 428 {
            self.myProfileBottomLineViewLeadingConstraint = self.myProfileBottomLineView.leadingAnchor.constraint(equalTo: self.myProfileContentContainerView.leadingAnchor, constant: 55)
            self.myProfileBottomLineViewLeadingConstraint.isActive = true
        } else if UIScreen.main.bounds.size.width >= 414 {
            self.myProfileBottomLineViewLeadingConstraint = self.myProfileBottomLineView.leadingAnchor.constraint(equalTo: self.myProfileContentContainerView.leadingAnchor, constant: 50)
            self.myProfileBottomLineViewLeadingConstraint.isActive = true
        } else {
            self.myProfileBottomLineViewLeadingConstraint = self.myProfileBottomLineView.leadingAnchor.constraint(equalTo: self.myProfileContentContainerView.leadingAnchor, constant: 45)
            self.myProfileBottomLineViewLeadingConstraint.isActive = true
        }
    }
    
    private func setProfileServerProcessDidFinsh() {
        if self.myProfileData?.color == "red" {
            self.myProfileNickNameLabel.text = "\(self.myProfileData!.nickName)"
            self.myProfileCharacterContentLabel.text = "\(self.myProfileData!.introduce)"
            self.myProfileCharacterNameLabel.text = "\(self.myProfileData!.color_tag)"
            self.myProfileImageView.image = UIImage(named: "CharacterRed")
            self.myProfileBackgroundImageView.image = UIImage(named: "imgBackgroundRed")
            self.myProfileFirstTagLabel.text = "#열정"
            self.myProfileSecondTagLabel.text = "#진로"
            self.myProfileThirdTagLabel.text = "#미래"
        } else if self.myProfileData?.color == "yellow" {
            self.myProfileNickNameLabel.text = "\(self.myProfileData!.nickName)"
            self.myProfileCharacterContentLabel.text = "\(self.myProfileData!.introduce)"
            self.myProfileCharacterNameLabel.text = "\(self.myProfileData!.color_tag)"
            self.myProfileImageView.image = UIImage(named: "characterYellow")
            self.myProfileBackgroundImageView.image = UIImage(named: "imgBackgroundYellow")
            self.myProfileFirstTagLabel.text = "#일상"
            self.myProfileSecondTagLabel.text = "#추억"
            self.myProfileThirdTagLabel.text = "#취향"
        } else if self.myProfileData?.color == "green" {
            self.myProfileNickNameLabel.text = "\(self.myProfileData!.nickName)"
            self.myProfileCharacterContentLabel.text = "\(self.myProfileData!.introduce)"
            self.myProfileCharacterNameLabel.text = "\(self.myProfileData!.color_tag)"
            self.myProfileImageView.image = UIImage(named: "CharacterGreen")
            self.myProfileBackgroundImageView.image = UIImage(named: "imgBackgroundGreen")
            self.myProfileFirstTagLabel.text = "#힐링"
            self.myProfileSecondTagLabel.text = "#치유"
            self.myProfileThirdTagLabel.text = "#위로"
        } else if self.myProfileData?.color == "pink" {
            self.myProfileNickNameLabel.text = "\(self.myProfileData!.nickName)"
            self.myProfileCharacterContentLabel.text = "\(self.myProfileData!.introduce)"
            self.myProfileCharacterNameLabel.text = "\(self.myProfileData!.color_tag)"
            self.myProfileImageView.image = UIImage(named: "CharacterPink")
            self.myProfileBackgroundImageView.image = UIImage(named: "imgBackgroundPink")
            self.myProfileFirstTagLabel.text = "#연애"
            self.myProfileSecondTagLabel.text = "#사랑"
            self.myProfileThirdTagLabel.text = "#가치관"
        } else {
            self.myProfileNickNameLabel.text = "\(self.myProfileData!.nickName)"
            self.myProfileCharacterContentLabel.text = "\(self.myProfileData!.introduce)"
            self.myProfileCharacterNameLabel.text = "\(self.myProfileData!.color_tag)"
            self.myProfileImageView.image = UIImage(named: "CharacterVilolet")
            self.myProfileBackgroundImageView.image = UIImage(named: "imgBackgroundViolet")
            self.myProfileFirstTagLabel.text = "#만약에"
            self.myProfileSecondTagLabel.text = "#상상"
            self.myProfileThirdTagLabel.text = "희망"
        }
    }
    
    private func getMyProfileList() {

        let Parameter = [
            "color": self.myProfileColor
        ]
        self.myProfileFlag = "answer"
        if self.myProfileTagIndex == 0 && self.myProfileColor == "" {
            ProfileServerApi.getMyProfilePage(userId: USER_ID, colorParameter:nil ) { result in
                if case let .success(data) = result, let list = data {
                    DispatchQueue.main.async {
                        self.myProfileData = list
                        self.myProfileSubData = list.postList
                        self.setProfileServerProcessDidFinsh()
                        self.myProfileCollectionView.reloadData()
                        print("Answer All Data: [\(self.myProfileData)]")
                    }
                }
            }
        } else {
            ProfileServerApi.getMyProfilePage(userId: USER_ID, colorParameter:Parameter ) { result in
                if case let .success(data) = result, let list = data {
                    DispatchQueue.main.async {
                        self.myProfileData = list
                        self.myProfileSubData = list.postList
                        self.setProfileServerProcessDidFinsh()
                        self.myProfileCollectionView.reloadData()
                        print("Answer Sub Data : [\(self.myProfileSubData)]")
                    }
                }
            }
        }
    }
    
    private func getMyLikeList() {
        let likeParameter = [
            "color" : self.myProfileColor
        ]
        self.myProfileFlag = "likes"
        if self.myProfileTagIndex == 0 && self.myProfileColor == "" {
            ProfileServerApi.getMyProfileLikeList(userId: USER_ID, crush: self.myProfileFlag, crushParameter: nil) { result in
                if case let .success(data) = result, let list = data {
                    // TO DO 
                    DispatchQueue.main.async {
                        self.myProfileLikeScrapData = list
                        if list.postList[0].errorCode == "404" {
                            self.myProfileLikeScrapSubData = []
                        } else {
                            self.myProfileLikeScrapSubData = list.postList[0].body!
                            self.myProfileCollectionView.reloadData()
                        }
                        print("Like All Data : [\(self.myProfileLikeScrapData)]")
                    }
                }
            }
        } else {
            ProfileServerApi.getMyProfileLikeList(userId: USER_ID, crush: self.myProfileFlag, crushParameter: likeParameter) { result in
                if case let .success(data) = result, let list = data {
                    DispatchQueue.main.async {
                        print("Likes Sub Data :  {\(self.myProfileLikeScrapSubData)}")
                        self.myProfileLikeScrapData = list
                        if list.postList[0].errorCode == "404" {
                            self.myProfileLikeScrapSubData = []
                        } else {
                            self.myProfileLikeScrapSubData = list.postList[0].body!
                        }
                        self.myProfileCollectionView.reloadData()
                    }
                }
            }
        }
    }
    
    
    private func getMyScrapList() {
        let scrapParameter = [
            "color" : self.myProfileColor
        ]
        self.myProfileFlag = "scrap"
        if self.myProfileTagIndex == 0 && self.myProfileColor == "" {
            ProfileServerApi.getMyProfileLikeList(userId: USER_ID, crush: self.myProfileFlag, crushParameter: nil) { result in
                if case let .success(data) = result, let list = data {
                    DispatchQueue.main.async {
                        self.myProfileLikeScrapData = list
                        if list.postList[0].errorCode == "404" {
                            self.myProfileLikeScrapSubData = []
                        } else {
                            self.myProfileLikeScrapSubData = list.postList[0].body!
                        }
                        print("Scrap All Data : [\(self.myProfileLikeScrapSubData)]")
                        self.myProfileCollectionView.reloadData()
                    }
                }
            }
        } else {
            ProfileServerApi.getMyProfileLikeList(userId: USER_ID, crush: self.myProfileFlag, crushParameter: scrapParameter) { result in
                if case let .success(data) = result, let list = data {
                    DispatchQueue.main.async {
                        self.myProfileLikeScrapData = list
                        if list.postList[0].errorCode == "404" {
                            self.myProfileLikeScrapSubData = []
                        } else {
                            self.myProfileLikeScrapSubData = list.postList[0].body!
                        }
                        print("Scrap Sub Data : {\(self.myProfileLikeScrapSubData)}")
                        self.myProfileCollectionView.reloadData()
                    }
                }
            }
        }
        
    }
    
    private func containerViewUpAnimation(_ isActive: Bool) {
        UIView.animate(withDuration: 0.5, delay: 1.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            
            self.myProfileCharacterContentLabel.isHidden = true
            self.myprofileImageViewContainerHeightConstraint = self.myProfileImageViewContainer
                .heightAnchor
                .constraint(equalToConstant: 45)
                
            self.myprofileImageViewContainerHeightConstraint.isActive = true
            
            self.myProfileImageViewContainerWidthConstraint = self.myProfileImageViewContainer
                .widthAnchor
                .constraint(equalToConstant: 45)
                
            self.myProfileImageViewContainerWidthConstraint.isActive = true
            
            self.myprofileImageViewWidthConstraint = self.myProfileImageView
                .widthAnchor
                .constraint(equalToConstant: 25)
            self.myprofileImageViewWidthConstraint.isActive = true
            self.myprofileImageViewHeightConstraint = self.myProfileImageView
                .heightAnchor
                .constraint(equalToConstant: 25)
            self.myprofileImageViewHeightConstraint.isActive = true
            
            self.myprofileImageViewCenterXConstraint = self.myProfileImageView
                .centerXAnchor
                .constraint(equalTo: self.myProfileImageViewContainer.centerXAnchor)
            
            self.myprofileImageViewCenterXConstraint.isActive = true
            self.myprofileImageViewCenterYConstraint = self.myProfileImageView
                .centerYAnchor
                .constraint(equalTo: self.myProfileImageViewContainer.centerYAnchor)

            self.myprofileImageViewCenterYConstraint.isActive = true
            
            self.myProfileImageViewContainer
                .topAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20)
                .isActive = true
            
            self.myProfileCharacterNameLabel
                .topAnchor
                .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20)
                .isActive = true
            
            self.myprofileContentLabelBottomConstraint = self.myProfileCharacterContentLabel
                .bottomAnchor
                .constraint(equalTo: self.myProfileNickNameLabel.topAnchor, constant: 18)
                
            self.myprofileContentLabelBottomConstraint.isActive = true

            
            self.myProfileContentContainerView
                .topAnchor
                .constraint(equalTo: self.myProfileNickNameLabel.bottomAnchor, constant: 18)
                .isActive = true
            
            self.myProfileImageViewContainer.layer.cornerRadius = 45 / 2.0
            self.view.layoutIfNeeded()
        } completion: { success in
            if success {
                UIView.animate(withDuration: 0, delay: 0, options: .curveEaseInOut, animations: {
                    self.myProfileFirstTagLabel.isHidden = isActive
                    self.myProfileFirstTagContainerView.isHidden = isActive
                    self.myProfileSecondTagLabel.isHidden = isActive
                    self.myProfileSecondTagContainerView.isHidden = isActive
                    self.myProfileThirdTagLabel.isHidden = isActive
                    self.myProfileThirdTagContainerView.isHidden = isActive
                }, completion: nil)
            }
        }

    }
    
    private func containerViewDownAnimation(_ isActived: Bool) {
        UIView.animate(withDuration: 0.5, delay: 1.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            
            
            self.myProfileImageViewContainerWidthConstraint.isActive = false
            self.myprofileImageViewContainerHeightConstraint.isActive = false
            self.myprofileImageViewWidthConstraint.isActive = false
            self.myprofileImageViewHeightConstraint.isActive = false
            self.myprofileImageViewCenterXConstraint.isActive = false
            self.myprofileImageViewCenterYConstraint.isActive = false
            self.myprofileContentLabelBottomConstraint.isActive = false
            
            self.view.safeAreaLayoutGuide
                .topAnchor
                .constraint(equalTo: self.myProfileImageViewContainer.topAnchor, constant: -30)
                .isActive = true
            
            self.view.safeAreaLayoutGuide
                .topAnchor
                .constraint(equalTo: self.myProfileCharacterNameLabel.topAnchor, constant: -30)
                .isActive = true
            
            self.myProfileNickNameLabel
                .bottomAnchor
                .constraint(equalTo: self.myProfileContentContainerView.topAnchor, constant: -30)
                .isActive = true
    
            
            self.myProfileImageViewContainer.layer.cornerRadius = 60 / 2.0
            self.view.layoutIfNeeded()
            
        } completion: { success in
            if success {
                self.myProfileCharacterContentLabel.isHidden = isActived
                self.myProfileFirstTagLabel.isHidden = isActived
                self.myProfileFirstTagContainerView.isHidden = isActived
                self.myProfileSecondTagLabel.isHidden = isActived
                self.myProfileSecondTagContainerView.isHidden = isActived
                self.myProfileThirdTagLabel.isHidden = isActived
                self.myProfileThirdTagContainerView.isHidden = isActived
            }
        }

    }
    
    
    @objc
    public func didTapSideMenuButton() {
        self.present(sideMenu!, animated: true, completion: nil)
    }
    
    
    @objc
    private func didTapMyLikeButton(_ sender: UIButton) {
        self.myProfileTagIndex = 0
        self.myProfileColor = ""
        self.myProfileTagCollectionView.selectItem(at: IndexPath(item: self.myProfileTagIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        self.getMyLikeList()
        if self.myProfileMyScrapButton.isSelected == true {
            self.myProfileMyScrapButton.isSelected = false
        } else {
            self.myProfileMyAnswerButton.isSelected = false
            self.myProfileMyAnswerButton.titleLabel?.textColor = UIColor.gray555
        }
        UIView.animate(withDuration: 0.5, delay: 1.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveLinear) {
            if self.myProfileBottomLineView.frame.origin.x > self.myProfileMyLikeButton.frame.origin.x {
                self.myProfileBottomLineView.layoutIfNeeded()
                let transition = CATransition()
                transition.duration = 0.1
                transition.type = CATransitionType(rawValue: "push")
                transition.subtype = .fromRight
                self.myProfileBottomLineView.layer.add(transition, forKey: kCATransition)
                self.myProfileMyLikeButton.isSelected = true
                self.myProfileMyLikeButton.setTitleColor(UIColor.black, for: .selected)
                self.myProfileBottomLineViewLeadingConstraint.constant = self.myProfileMyLikeButton.center.x - 30
                self.myProfileBottomLineView.updateConstraints()
            } else {
                self.myProfileBottomLineView.layoutIfNeeded()
                let transition = CATransition()
                transition.duration = 0.1
                transition.type = CATransitionType(rawValue: "push")
                transition.subtype = .fromLeft
                self.myProfileMyLikeButton.isSelected = true
                self.myProfileMyAnswerButton.setTitleColor(.gray555, for: .normal)
                self.myProfileMyLikeButton.setTitleColor(UIColor.black, for: .selected)
                self.myProfileBottomLineView.layer.add(transition, forKey: kCATransition)
                self.myProfileBottomLineViewLeadingConstraint.constant = self.myProfileMyLikeButton.center.x - 30
                self.myProfileBottomLineView.updateConstraints()
            }
        } completion: { success in
            if success == true {
                self.myProfileBottomLineView.layer.removeAnimation(forKey: "push")
            }
        }
    }
    
    @objc
    private func didTapMyScrapButton(_ sender: UIButton) {
        self.myProfileTagIndex = 0
        self.myProfileColor = ""
        self.myProfileTagCollectionView.selectItem(at: IndexPath(item: self.myProfileTagIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        self.getMyScrapList()
        if self.myProfileMyLikeButton.isSelected == true {
            self.myProfileMyLikeButton.isSelected = false
        } else {
            self.myProfileMyAnswerButton.isSelected = false
            self.myProfileMyAnswerButton.setTitleColor(.gray555, for: .normal)
        }
        UIView.animate(withDuration: 0.5, delay: 1.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveLinear) {
            self.myProfileBottomLineView.layoutIfNeeded()
            let transition = CATransition()
            transition.duration = 0.1
            transition.type = CATransitionType(rawValue: "push")
            transition.subtype = .fromLeft
            self.myProfileMyScrapButton.isSelected = true
            self.myProfileMyScrapButton.setTitleColor(UIColor.black, for: .selected)
            self.myProfileBottomLineView.layer.add(transition, forKey: kCATransition)
            self.myProfileBottomLineViewLeadingConstraint.constant = self.myProfileMyScrapButton.center.x - 30
            self.myProfileBottomLineView.updateConstraints()
        } completion: { success in
            if success == true {
                self.myProfileBottomLineView.layer.removeAnimation(forKey: "push")
            }
        }
    }
    
    @objc
    private func didTapMyAnswerButton(_ sender: UIButton) {
        self.myProfileTagIndex = 0
        self.myProfileColor = ""
        self.myProfileTagCollectionView.selectItem(at: IndexPath(item: self.myProfileTagIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        self.getMyProfileList()
        if self.myProfileMyLikeButton.isSelected == true {
            self.myProfileMyLikeButton.isSelected = false
        } else {
            self.myProfileMyScrapButton.isSelected = false
        }
        UIView.animate(withDuration: 0.5, delay: 1.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveLinear) {
            if self.myProfileBottomLineView.frame.origin.x > self.myProfileMyAnswerButton.frame.origin.x {
                self.myProfileBottomLineView.layoutIfNeeded()
                let transition = CATransition()
                transition.duration = 0.1
                transition.type = CATransitionType(rawValue: "push")
                transition.subtype = .fromRight
                self.myProfileMyAnswerButton.isSelected = true
                self.myProfileMyAnswerButton.setTitleColor(UIColor.black, for: .selected)
                self.myProfileBottomLineView.layer.add(transition, forKey: kCATransition)
                if UIScreen.main.bounds.size.width >= 428 {
                    self.myProfileBottomLineViewLeadingConstraint.constant =
                        self.myProfileContentContainerView.frame.origin.x + 55
                } else if UIScreen.main.bounds.size.width >= 414 {
                    self.myProfileBottomLineViewLeadingConstraint.constant =
                        self.myProfileContentContainerView.frame.origin.x + 50
                } else {
                    self.myProfileBottomLineViewLeadingConstraint.constant = self.myProfileContentContainerView.frame.origin.x + 45
                }
                self.myProfileBottomLineView.updateConstraints()
            }
        } completion: { success in
            if success == true {
                self.myProfileBottomLineView.layer.removeAnimation(forKey: "push")
            }
        }
        
    }
    
    @objc
    public func didTapdetailPushButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileDetailView = storyboard.instantiateViewController(withIdentifier: "ProfileDetail") as? MyProfileDetailViewController
        guard let profileDetailVC = profileDetailView else { return }
        self.navigationController?.pushViewController(profileDetailVC, animated: true)
    }
    
    @objc
    private func didTapRaiseButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            self.containerViewDownAnimation(sender.isSelected)
            self.myProfileContentViewRaiseButton.setImage(UIImage(named: "VerticalArrow"), for: .normal)
        } else {
            sender.isSelected = true
            self.containerViewUpAnimation(sender.isSelected)
            self.myProfileContentViewRaiseButton.setImage(UIImage(named: "VerticaledArrow"), for: .selected)
        }
    }
}


extension MyProfileViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.myProfileCollectionView {
            switch self.myProfileFlag {
            case "answer":
                if self.myProfileSubData.count == 0 {
                    return 1
                } else {
                    return self.myProfileSubData.count
                }
            case "likes":
                if self.myProfileLikeScrapSubData.count == 0 {
                    return 1
                } else {
                    return self.myProfileLikeScrapSubData.count
                }
            case "scrap":
                if self.myProfileLikeScrapSubData.count == 0 {
                    return 1
                } else {
                    return self.myProfileLikeScrapSubData.count
                }
            default:
                break
            }
            return self.myProfileSubData.count
        } else {
            return self.tagNameList.count
        }
    }
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        self.sideMenu?.setSideMenuNavigation(viewcontroller: self)
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        self.sideMenu?.deleteEffectViewNavigation(viewcontroller: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.myProfileCollectionView {
            let myProfileCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileCell", for: indexPath) as? MyProfileCollectionViewCell
            switch self.myProfileFlag {
            case "answer":
                if self.myProfileSubData.count == 0 {
                    let myProfileEmptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileEmptyCell", for: indexPath) as? MyProfileEmptyCollectionViewCell
                    return myProfileEmptyCell!
                } else {
                    myProfileCell?.selectIndex = indexPath.item
                    myProfileCell?.CategoryFlag = self.myProfileFlag
                    if self.myProfileSubData[indexPath.item].color == "red" {
                        myProfileCell?.myProfileContentTitleLabel.text = "# 열정충만"
                        myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 244/255, green: 82/255, blue: 82/255, alpha: 1.0)
                    } else if self.myProfileSubData[indexPath.item].color == "yellow" {
                        myProfileCell?.myProfileContentTitleLabel.text = "# 소소한 일상"
                        myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 220/255, green: 174/255, blue: 9/255, alpha: 1.0)
                    } else if self.myProfileSubData[indexPath.item].color == "pink" {
                        myProfileCell?.myProfileContentTitleLabel.text = "# 관계의 미학"
                        myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0)
                    } else if self.myProfileSubData[indexPath.item].color == "green" {
                        myProfileCell?.myProfileContentTitleLabel.text = "# 기억상자"
                        myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 42/255, green: 212/255, blue: 141/255, alpha: 1.0)
                    } else {
                        myProfileCell?.myProfileContentTitleLabel.text = "# 상상플러스"
                        myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0)
                    }
                    var isFlag = self.myProfileSubData[indexPath.item].shareYN
                    if isFlag == true {
                        myProfileCell?.myProfileContentButton.setImage(UIImage(named: "Lock.png"), for: .normal)
                    } else {
                        myProfileCell?.myProfileContentButton.setImage(UIImage(named: "UnLock.png"), for: .normal)
                    }
                    myProfileCell?.myProfileQuestionTitleLabel.text = "\(self.myProfileSubData[indexPath.item].question)"
                    myProfileCell?.myProfileContentDateLabel.text = self.myProfileSubData[indexPath.item].writtenDate
                    myProfileCell?.myProfileAnswerTitleLabel.text = self.myProfileSubData[indexPath.item].answer
                    myProfileCell?.shareButtonClouser = {
                        ProfileServerApi.putMyProfileShareProgress(cardSeq: self.myProfileSubData[indexPath.item].answerId, level: self.myProfileSubData[indexPath.item].level) { result in
                            if case let .success(data) = result, let _ = data {
                                isFlag = !isFlag
                                    myProfileCell?.myProfileContentButton.setImage(isFlag ? UIImage(named: "Lock.png") : UIImage(named: "UnLock.png"), for: .normal)
                                print("true check \(self.myProfileSubData[indexPath.item].shareYN)")
                                print("index did tap \(self.myProfileSubData[indexPath.item].answerId)")
                
                            }
                        }
                        
                    }
                    
                    return myProfileCell!
                }
            case "likes":
                if self.myProfileLikeScrapSubData.count == 0 {
                    let myProfileEmptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileEmptyCell", for: indexPath) as? MyProfileEmptyCollectionViewCell
                    return myProfileEmptyCell!
                } else {
                    myProfileCell?.selectIndex = indexPath.item
                    myProfileCell?.CategoryFlag = self.myProfileFlag
                    if self.myProfileLikeScrapSubData[indexPath.item].color == "red" {
                        myProfileCell?.myProfileContentTitleLabel.text = "# 열정충만"
                        myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 244/255, green: 82/255, blue: 82/255, alpha: 1.0)
                    } else if self.myProfileLikeScrapSubData[indexPath.item].color == "yellow" {
                        myProfileCell?.myProfileContentTitleLabel.text = "# 소소한 일상"
                        myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 220/255, green: 174/255, blue: 9/255, alpha: 1.0)
                    } else if self.myProfileLikeScrapSubData[indexPath.item].color == "pink" {
                        myProfileCell?.myProfileContentTitleLabel.text = "# 관계의 미학"
                        myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0)
                    } else if self.myProfileLikeScrapSubData[indexPath.item].color == "green" {
                        myProfileCell?.myProfileContentTitleLabel.text = "# 기억상자"
                        myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 42/255, green: 212/255, blue: 141/255, alpha: 1.0)
                    } else {
                        myProfileCell?.myProfileContentTitleLabel.text = "# 상상플러스"
                        myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0)
                    }
                    var isLiked = self.myProfileLikeScrapSubData[indexPath.item].hasLiked
                    
                    if isLiked == true {
                        myProfileCell?.myProfileContentButton.setImage(UIImage(named: "LikeOn.png"), for: .normal)
                    } else {
                        myProfileCell?.myProfileContentButton.setImage(UIImage(named: "LikeOff.png"), for: .normal)
                    }
                    myProfileCell?.myProfileQuestionTitleLabel.text = "\(self.myProfileLikeScrapSubData[indexPath.item].question)"
                    myProfileCell?.myProfileContentDateLabel.text = self.myProfileLikeScrapSubData[indexPath.item].updateDate
                    myProfileCell?.myProfileAnswerTitleLabel.text = self.myProfileLikeScrapSubData[indexPath.item].answer
                    myProfileCell?.likesButtonClouser = {
                        let parameter = LikeProgressParameter(userId: self.myProfileLikeScrapData!.user_id, questId: self.myProfileLikeScrapSubData[indexPath.item].boardSeq)
                        ProfileServerApi.postMyProfileLikeProgress(likesParameter: parameter) {  result in
                            if case let .success(data) = result, let list = data {
                                isLiked = !isLiked
                                myProfileCell?.myProfileContentButton.setImage(isLiked ? UIImage(named: "LikeOn.png") : UIImage(named: "LikeOff.png"), for: .normal)
                                print("did Tap like \(list)")
                                if list.code == 200 {
                                    DispatchQueue.main.async {
                                        self.myProfileLikeScrapSubData.remove(at: myProfileCell!.selectIndex)
                                        self.myProfileCollectionView.reloadData()
                                    }
                                }
                            }
                        }
                    }
                    return myProfileCell!
                }
            case "scrap":
                if self.myProfileLikeScrapSubData.count == 0 {
                    let myProfileEmptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileEmptyCell", for: indexPath) as? MyProfileEmptyCollectionViewCell
                    return myProfileEmptyCell!
                } else {
                    myProfileCell?.selectIndex = indexPath.item
                    myProfileCell?.CategoryFlag = self.myProfileFlag
                    if self.myProfileLikeScrapSubData[indexPath.item].color == "red" {
                        myProfileCell?.myProfileContentTitleLabel.text = "# 열정충만"
                        myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 244/255, green: 82/255, blue: 82/255, alpha: 1.0)
                    } else if self.myProfileLikeScrapSubData[indexPath.item].color == "yellow" {
                        myProfileCell?.myProfileContentTitleLabel.text = "# 소소한 일상"
                        myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 220/255, green: 174/255, blue: 9/255, alpha: 1.0)
                    } else if self.myProfileLikeScrapSubData[indexPath.item].color == "pink" {
                        myProfileCell?.myProfileContentTitleLabel.text = "# 관계의 미학"
                        myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0)
                    } else if self.myProfileLikeScrapSubData[indexPath.item].color == "green" {
                        myProfileCell?.myProfileContentTitleLabel.text = "# 기억상자"
                        myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 42/255, green: 212/255, blue: 141/255, alpha: 1.0)
                    } else {
                        myProfileCell?.myProfileContentTitleLabel.text = "# 상상플러스"
                        myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0)
                    }
                    var isScraped = self.myProfileLikeScrapSubData[indexPath.item].hasScraped
                    if isScraped == true {
                        myProfileCell?.myProfileContentButton.setImage(UIImage(named: "ScrapsOn.png"), for: .normal)
                    } else {
                        myProfileCell?.myProfileContentButton.setImage(UIImage(named: "ScrapsOff.png"), for: .normal)
                    }
                    myProfileCell?.myProfileQuestionTitleLabel.text = "\(self.myProfileLikeScrapSubData[indexPath.item].question)"
                    myProfileCell?.myProfileContentDateLabel.text = self.myProfileLikeScrapSubData[indexPath.item].updateDate
                    myProfileCell?.myProfileAnswerTitleLabel.text = self.myProfileLikeScrapSubData[indexPath.item].answer
                    myProfileCell?.scrapButtonClouser = {
                        let parameter = ScrapProgressParameter(userId: self.myProfileLikeScrapData!.user_id, questId: self.myProfileLikeScrapSubData[indexPath.item].boardSeq)
                        ProfileServerApi.postMyProfileScrapProgress(scrapParameter: parameter) { result in
                            if case let .success(data) = result, let list = data {
                                isScraped = !isScraped
                                myProfileCell?.myProfileContentButton.setImage(isScraped ? UIImage(named: "ScrapsOn.png") : UIImage(named: "ScrapsOff.png"), for: .normal)
                                if list.code == 200 {
                                    DispatchQueue.main.async {
                                        self.myProfileLikeScrapSubData.remove(at: myProfileCell!.selectIndex)
                                        self.myProfileCollectionView.reloadData()
                                    }
                                }
                                print("did Tap scrap \(list)")
                            }
                        }
                    }
                    return myProfileCell!
                }
            default:
                return UICollectionViewCell()
            }
        } else {
            let myProfileTagCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileTagCell", for: indexPath) as? MyProfileTagCollectionViewCell
            if indexPath.item == 0 && self.myProfileisFlag == true {
                myProfileTagCell?.isSelected = true
                collectionView.selectItem(at: [0,myProfileTagIndex], animated: false, scrollPosition: .init())
            }
            myProfileTagCell?.myProfileTagButton.setTitle(self.tagNameList[indexPath.item], for: .normal)
            return myProfileTagCell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.myProfileCollectionView {
            let myProfileCell = collectionView.cellForItem(at: indexPath) as? MyProfileCollectionViewCell
            myProfileCell?.selectIndex = indexPath.item
            if self.myProfileFlag == "answer" {
                let profileAnswerVC = SocialDetailViewController(nibName: "SocialDetailViewController", bundle: nil)
                profileAnswerVC.answerId = self.myProfileSubData[indexPath.item].answerId
                profileAnswerVC.title = self.myProfileData?.nickName
                profileAnswerVC.authorId = 1
                self.navigationController?.pushViewController(profileAnswerVC, animated: true)
            }
        } else {
            switch indexPath.item {
            case 0:
                if self.myProfileFlag == "answer" {
                    self.myProfileColor = ""
                    self.getMyProfileList()
                    self.myProfileisFlag = false
                } else if self.myProfileFlag == "likes" {
                    self.myProfileColor = ""
                    self.getMyLikeList()
                    self.myProfileisFlag = false
                } else {
                    self.myProfileColor = ""
                    self.getMyScrapList()
                    self.myProfileisFlag = false
                }
            case 1:
                if self.myProfileFlag == "answer" {
                    self.myProfileColor = "red"
                    self.getMyProfileList()
                    self.myProfileisFlag = false
                } else if self.myProfileFlag == "likes" {
                    self.myProfileColor = "red"
                    self.getMyLikeList()
                    self.myProfileisFlag = false
                } else {
                    self.myProfileColor = "red"
                    self.getMyScrapList()
                    self.myProfileisFlag = false
                }
            case 2:
                if self.myProfileFlag == "answer" {
                    self.myProfileColor = "yellow"
                    self.getMyProfileList()
                    self.myProfileisFlag = false
                } else if self.myProfileFlag == "likes" {
                    self.myProfileColor = "yellow"
                    self.getMyLikeList()
                    self.myProfileisFlag = false
                } else {
                    self.myProfileColor = "yellow"
                    self.getMyScrapList()
                    self.myProfileisFlag = false
                }
            case 3:
                if self.myProfileFlag == "answer" {
                    self.myProfileColor = "green"
                    self.getMyProfileList()
                    self.myProfileisFlag = false
                } else if self.myProfileFlag == "likes" {
                    self.myProfileColor = "green"
                    self.getMyLikeList()
                    self.myProfileisFlag = false
                } else {
                    self.myProfileColor = "green"
                    self.getMyScrapList()
                    self.myProfileisFlag = false
                }
            case 4:
                if self.myProfileFlag == "answer" {
                    self.myProfileColor = "pink"
                    self.getMyProfileList()
                    self.myProfileisFlag = false
                } else if self.myProfileFlag == "likes" {
                    self.myProfileColor = "pink"
                    self.getMyLikeList()
                    self.myProfileisFlag = false
                } else {
                    self.myProfileColor = "pink"
                    self.getMyScrapList()
                    self.myProfileisFlag = false
                }
            case 5:
                if self.myProfileFlag == "answer" {
                    self.myProfileColor = "purple"
                    self.getMyProfileList()
                    self.myProfileisFlag = false
                } else if self.myProfileFlag == "likes" {
                    self.myProfileColor = "purple"
                    self.getMyLikeList()
                    self.myProfileisFlag = false
                } else {
                    self.myProfileColor = "purple"
                    self.getMyScrapList()
                    self.myProfileisFlag = false
                }
            default:
                break
            }
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            self.myProfileCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.myProfileCollectionView {
            switch self.myProfileFlag {
            
            case "answer":
                if self.myProfileSubData.count == 0 {
                    return CGSize(width: self.myProfileCollectionView.frame.size.width, height: self.myProfileCollectionView.frame.size.height)
                } else {
                    return CGSize(width: UIScreen.main.bounds.size.width - 40, height: 100)
                }
                
            case "likes":
                if self.myProfileLikeScrapSubData.count == 0 {
                    return CGSize(width: self.myProfileCollectionView.frame.size.width, height: 150)
                } else {
                    return CGSize(width: UIScreen.main.bounds.size.width - 40, height: 100)
                }
                
            case "scrap":
                if self.myProfileLikeScrapSubData.count == 0 {
                    return CGSize(width: self.myProfileCollectionView.frame.size.width, height: 150)
                } else {
                    return CGSize(width: UIScreen.main.bounds.size.width - 40, height: 100)
                }
            default:
                return CGSize()
            }
        } else {
            let myTextCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileTagCell", for: indexPath) as? MyProfileTagCollectionViewCell
            return CGSize(width: (myTextCell?.myProfileTagButton.intrinsicContentSize.width)!, height: 30)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.myProfileCollectionView {
            switch self.myProfileFlag {
            
            case "answer":
                if self.myProfileSubData.count == 0 {
                    return UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
                } else {
                    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                }
                
            case "likes":
                if self.myProfileLikeScrapSubData.count == 0 {
                    return UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
                } else {
                    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                }
                
            case "scrap":
                if self.myProfileLikeScrapSubData.count == 0 {
                    return UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
                } else {
                    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                }
            default:
                return UIEdgeInsets()
            }
        } else {
            return UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 10)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == myProfileTagCollectionView {
            return 5
        } else {
            return 10
        }
    }
    
}
