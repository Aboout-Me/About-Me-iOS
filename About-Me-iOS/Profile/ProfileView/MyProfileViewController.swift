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

class MyProfileViewController: UIViewController {
    @IBOutlet weak var detailPushButton: UIButton!
    @IBOutlet weak var myProfileBackgroundImageView: UIImageView!
    @IBOutlet weak var myProfileBoxView: UIView!
    @IBOutlet weak var myProfileCharacterNameLabel: UILabel!
    @IBOutlet weak var myProfileCharacterContentLabel: UILabel!
    @IBOutlet weak var myProfileNickNameLabel: UILabel!
    @IBOutlet weak var myProfileCharacterTagFirst: UIButton!
    @IBOutlet weak var myProfileCharacterTagSecond: UIButton!
    @IBOutlet weak var myProfileCharacterTagThird: UIButton!
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
    var myProfileBottomLineViewLeadingConstraint:NSLayoutConstraint!
    var myProfileBottomLineViewWidthConstraint: NSLayoutConstraint!
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
    public var isshareFlag = false
    public var islikeFlag = false
    public var isscrapFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMyProfileList()
        self.setMyProfileSideMenuLayout()
        self.setInitLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "프로필"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 18)!,NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    private func setMyProfileSideMenuLayout() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sideOnlyViewController: SideOnlyViewController = storyboard.instantiateViewController(withIdentifier: "SideOnlyViewController") as! SideOnlyViewController
        self.sideMenu = SideMenuNavigationController(rootViewController: sideOnlyViewController)
        self.sideMenu?.leftSide = true
    }
    
    
    private func setInitLayout() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu.png"), style: .plain, target: self, action: #selector(self.didTapSideMenuButton))
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 18)!,NSAttributedString.Key.foregroundColor : UIColor.white]
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
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        self.myProfileCharacterContentLabel.numberOfLines = 0
        self.myProfileCharacterContentLabel.textColor = .gray777
        self.myProfileCharacterContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        self.myProfileCharacterContentLabel.textAlignment = .left
        self.myProfileCharacterContentLabel.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        self.myProfileImageViewContainer.layer.masksToBounds = true
        self.myProfileImageViewContainer.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        self.myProfileImageViewContainer.layer.cornerRadius = self.myProfileImageViewContainer.frame.size.width / 2
        self.myProfileImageView.image = UIImage(named: "CharacterRed.png")
        self.myProfileNickNameLabel.textColor = .gray999
        self.myProfileNickNameLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 11)
        self.myProfileNickNameLabel.textAlignment = .center
        self.detailPushButton.setImage(UIImage(named: "Arrow.png"), for: .normal)
        self.detailPushButton.addTarget(self, action: #selector(self.didTapdetailPushButton), for: .touchUpInside)
        self.myProfileCharacterTagFirst.layer.borderColor =  UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        self.myProfileCharacterTagFirst.layer.borderWidth = 1
        self.myProfileCharacterTagFirst.layer.cornerRadius = 3
        self.myProfileCharacterTagFirst.layer.masksToBounds = true
        self.myProfileCharacterTagFirst.setTitle("#열정", for: .normal)
        self.myProfileCharacterTagFirst.setTitleColor(UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0), for: .normal)
        self.myProfileCharacterTagFirst.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        self.myProfileCharacterTagFirst.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        self.myProfileCharacterTagSecond.layer.borderColor =  UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        self.myProfileCharacterTagSecond.layer.borderWidth = 1
        self.myProfileCharacterTagSecond.layer.cornerRadius = 3
        self.myProfileCharacterTagSecond.layer.masksToBounds = true
        self.myProfileCharacterTagSecond.setTitle("#진로", for: .normal)
        self.myProfileCharacterTagSecond.setTitleColor(UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0), for: .normal)
        self.myProfileCharacterTagSecond.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        self.myProfileCharacterTagSecond.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        self.myProfileCharacterTagThird.layer.borderColor =  UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        self.myProfileCharacterTagThird.layer.borderWidth = 1
        self.myProfileCharacterTagThird.layer.cornerRadius = 3
        self.myProfileCharacterTagThird.layer.masksToBounds = true
        self.myProfileCharacterTagThird.setTitle("#미래", for: .normal)
        self.myProfileCharacterTagThird.setTitleColor(UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0), for: .normal)
        self.myProfileCharacterTagThird.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        self.myProfileCharacterTagThird.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        self.myProfileContentContainerView.layer.cornerRadius = 25
        self.myProfileContentContainerView.layer.masksToBounds = true
        self.myProfileContentContainerView.layer.maskedCorners =  [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        self.myProfileMyAnswerButton.isSelected = true
        self.myProfileMyAnswerButton.setTitle("내가 한 답", for: .normal)
        self.myProfileMyAnswerButton.titleLabel?.font = UIFont(name: "GmarketSans-Medium", size: 14)
        self.myProfileMyAnswerButton.titleLabel?.textAlignment = .center
        self.myProfileMyAnswerButton.setTitleColor(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0), for: .selected)
        self.myProfileMyLikeButton.setTitle("좋아요", for: .normal)
        self.myProfileMyLikeButton.titleLabel?.font = UIFont(name: "GmarketSans-Medium", size: 14)
        self.myProfileMyLikeButton.titleLabel?.textAlignment = .center
        self.myProfileMyLikeButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.myProfileMyScrapButton.setTitle("스크랩", for: .normal)
        self.myProfileMyScrapButton.titleLabel?.font = UIFont(name: "GmarketSans-Medium", size: 14)
        self.myProfileMyScrapButton.titleLabel?.textAlignment = .center
        self.myProfileMyScrapButton.setTitleColor(UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0), for: .normal)
        self.myProfileButtonBottomView.backgroundColor = UIColor.lineEee
        self.myProfileBottomLineView.translatesAutoresizingMaskIntoConstraints = false
        self.myProfileBottomLineView.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.myProfileBottomLineViewWidthConstraint = self.myProfileBottomLineView.widthAnchor.constraint(equalToConstant: 62)
        self.myProfileBottomLineViewWidthConstraint.isActive = true
        self.myProfileBottomLineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        self.myProfileBottomLineViewLeadingConstraint = self.myProfileBottomLineView.leadingAnchor.constraint(equalTo: self.myProfileMyAnswerButton.leadingAnchor, constant: 25)
        self.myProfileBottomLineViewLeadingConstraint.isActive = true
        self.myProfileBottomLineView.bottomAnchor.constraint(equalTo: self.myProfileMyAnswerButton.bottomAnchor).isActive = true
        self.myProfileMyLikeButton.addTarget(self, action: #selector(self.didTapMyLikeButton(_:)), for: .touchUpInside)
        self.myProfileMyScrapButton.addTarget(self, action: #selector(self.didTapMyScrapButton(_:)), for: .touchUpInside)
        self.myProfileMyAnswerButton.addTarget(self, action: #selector(self.didTapMyAnswerButton(_:)), for: .touchUpInside)
        self.myProfileFloatingButton.buttonColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.myProfileFloatingButton.plusColor = UIColor.white
        self.myProfileFloatingButton.addItem("내 피드", icon: UIImage(named: "Write.png"))
        self.myProfileFloatingButton.addItem("자문 자답", icon: UIImage(named: "SelfQuestion.png")) { item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let advisoryAnswerView = storyboard.instantiateViewController(withIdentifier: "AdvisoryAnswerVC") as? AdvisoryAnswerViewController
            guard let advisoryAnswerVC = advisoryAnswerView else { return }
            self.navigationController?.pushViewController(advisoryAnswerVC, animated: true)
        }
        self.myProfileFloatingButton.addItem("내 피드", icon: UIImage(named: "Write.png"))
        
    }
    
    private func setProfileServerProcessDidFinsh() {
        if self.myProfileData?.color == "red" {
            self.myProfileNickNameLabel.text = "\(self.myProfileData!.nickName)"
            self.myProfileCharacterContentLabel.text = "\(self.myProfileData!.introduce)"
            self.myProfileCharacterNameLabel.text = "\(self.myProfileData!.color_tag)"
            self.myProfileImageView.image = UIImage(named: "CharacterRed")
            self.myProfileBackgroundImageView.image = UIImage(named: "imgBackgroundRed")
            self.myProfileCharacterTagFirst.setTitle("#열정", for: .normal)
            self.myProfileCharacterTagSecond.setTitle("#진로", for: .normal)
            self.myProfileCharacterTagThird.setTitle("#미래", for: .normal)
            self.myProfileCharacterTagFirst.setTitleColor(UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0), for: .normal)
            self.myProfileCharacterTagSecond.setTitleColor(UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0), for: .normal)
            self.myProfileCharacterTagThird.setTitleColor(UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0), for: .normal)
        } else if self.myProfileData?.color == "yellow" {
            self.myProfileNickNameLabel.text = "\(self.myProfileData!.nickName)"
            self.myProfileCharacterContentLabel.text = "\(self.myProfileData!.introduce)"
            self.myProfileCharacterNameLabel.text = "\(self.myProfileData!.color_tag)"
            self.myProfileImageView.image = UIImage(named: "characterYellow")
            self.myProfileBackgroundImageView.image = UIImage(named: "imgBackgroundYellow")
            self.myProfileCharacterTagFirst.setTitle("#일상", for: .normal)
            self.myProfileCharacterTagSecond.setTitle("#추억", for: .normal)
            self.myProfileCharacterTagThird.setTitle("#취향", for: .normal)
            self.myProfileCharacterTagFirst.setTitleColor(UIColor(red: 220/255, green: 174/255, blue: 9/255, alpha: 1.0), for: .normal)
            self.myProfileCharacterTagSecond.setTitleColor(UIColor(red: 220/255, green: 174/255, blue: 9/255, alpha: 1.0), for: .normal)
            self.myProfileCharacterTagThird.setTitleColor(UIColor(red: 220/255, green: 174/255, blue: 9/255, alpha: 1.0), for: .normal)
        } else if self.myProfileData?.color == "green" {
            self.myProfileNickNameLabel.text = "\(self.myProfileData!.nickName)"
            self.myProfileCharacterContentLabel.text = "\(self.myProfileData!.introduce)"
            self.myProfileCharacterNameLabel.text = "\(self.myProfileData!.color_tag)"
            self.myProfileImageView.image = UIImage(named: "CharacterGreen")
            self.myProfileBackgroundImageView.image = UIImage(named: "imgBackgroundGreen")
            self.myProfileCharacterTagFirst.setTitle("#힐링", for: .normal)
            self.myProfileCharacterTagSecond.setTitle("#치유", for: .normal)
            self.myProfileCharacterTagThird.setTitle("#위로", for: .normal)
            self.myProfileCharacterTagFirst.setTitleColor(UIColor(red: 31/255, green: 176/255, blue: 115/255, alpha: 1.0), for: .normal)
            self.myProfileCharacterTagSecond.setTitleColor(UIColor(red: 31/255, green: 176/255, blue: 115/255, alpha: 1.0), for: .normal)
            self.myProfileCharacterTagThird.setTitleColor(UIColor(red: 31/255, green: 176/255, blue: 115/255, alpha: 1.0), for: .normal)
        } else if self.myProfileData?.color == "pink" {
            self.myProfileNickNameLabel.text = "\(self.myProfileData!.nickName)"
            self.myProfileCharacterContentLabel.text = "\(self.myProfileData!.introduce)"
            self.myProfileCharacterNameLabel.text = "\(self.myProfileData!.color_tag)"
            self.myProfileImageView.image = UIImage(named: "CharacterPink")
            self.myProfileBackgroundImageView.image = UIImage(named: "imgBackgroundPink")
            self.myProfileCharacterTagFirst.setTitle("#연애", for: .normal)
            self.myProfileCharacterTagSecond.setTitle("#사랑", for: .normal)
            self.myProfileCharacterTagThird.setTitle("#가치관", for: .normal)
            self.myProfileCharacterTagFirst.setTitleColor(UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0), for: .normal)
            self.myProfileCharacterTagSecond.setTitleColor(UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0), for: .normal)
            self.myProfileCharacterTagThird.setTitleColor(UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0), for: .normal)
        } else {
            self.myProfileNickNameLabel.text = "\(self.myProfileData!.nickName)"
            self.myProfileCharacterContentLabel.text = "\(self.myProfileData!.introduce)"
            self.myProfileCharacterNameLabel.text = "\(self.myProfileData!.color_tag)"
            self.myProfileImageView.image = UIImage(named: "CharacterVilolet")
            self.myProfileBackgroundImageView.image = UIImage(named: "imgBackgroundViolet")
            self.myProfileCharacterTagFirst.setTitle("#만약에", for: .normal)
            self.myProfileCharacterTagSecond.setTitle("#상상", for: .normal)
            self.myProfileCharacterTagThird.setTitle("#희망", for: .normal)
            self.myProfileCharacterTagFirst.setTitleColor(UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0), for: .normal)
            self.myProfileCharacterTagSecond.setTitleColor(UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0), for: .normal)
            self.myProfileCharacterTagThird.setTitleColor(UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0), for: .normal)
        }
    }
    
    private func getMyProfileList() {

        let Parameter = [
            "color": self.myProfileColor
        ]
        self.myProfileFlag = "answer"
        if self.myProfileTagIndex == 0 && self.myProfileColor == "" {
            ProfileServerApi.getMyProfilePage(userId: 1, colorParameter:nil ) { result in
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
            ProfileServerApi.getMyProfilePage(userId: 1, colorParameter:Parameter ) { result in
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
            ProfileServerApi.getMyProfileLikeList(userId: 1, crush: self.myProfileFlag, crushParameter: nil) { result in
                if case let .success(data) = result, let list = data {
                    DispatchQueue.main.async {
                        self.myProfileLikeScrapData = list
                        self.myProfileLikeScrapSubData = list.postList[0].body
                        print("Like All Data : [\(self.myProfileLikeScrapData)]")
                        self.myProfileCollectionView.reloadData()
                    }
                }
            }
        } else {
            ProfileServerApi.getMyProfileLikeList(userId: 1, crush: self.myProfileFlag, crushParameter: likeParameter) { result in
                if case let .success(data) = result, let list = data {
                    DispatchQueue.main.async {
                        print("Likes Sub Data :  {\(self.myProfileLikeScrapSubData)}")
                        self.myProfileLikeScrapData = list
                        self.myProfileLikeScrapSubData = list.postList[0].body
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
            ProfileServerApi.getMyProfileLikeList(userId: 1, crush: self.myProfileFlag, crushParameter: nil) { result in
                if case let .success(data) = result, let list = data {
                    DispatchQueue.main.async {
                        self.myProfileLikeScrapData = list
                        self.myProfileLikeScrapSubData = list.postList[0].body
                        print("Scrap All Data : [\(self.myProfileLikeScrapSubData)]")
                        self.myProfileCollectionView.reloadData()
                    }
                }
            }
        } else {
            ProfileServerApi.getMyProfileLikeList(userId: 1, crush: self.myProfileFlag, crushParameter: scrapParameter) { result in
                if case let .success(data) = result, let list = data {
                    DispatchQueue.main.async {
                        self.myProfileLikeScrapData = list
                        self.myProfileLikeScrapSubData = list.postList[0].body
                        print("Scrap Sub Data : {\(self.myProfileLikeScrapSubData)}")
                        self.myProfileCollectionView.reloadData()
                    }
                }
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
                self.myProfileBottomLineViewLeadingConstraint.constant = self.myProfileMyLikeButton.frame.minX - 15
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
                self.myProfileBottomLineViewLeadingConstraint.constant = self.myProfileMyLikeButton.frame.minX - 15
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
            self.myProfileBottomLineViewLeadingConstraint.constant = self.myProfileMyScrapButton.frame.minX - 15
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
                self.myProfileBottomLineViewLeadingConstraint.constant = self.myProfileMyAnswerButton.frame.minX - 15
                self.myProfileBottomLineView.updateConstraints()
            } else {
                self.myProfileBottomLineView.layoutIfNeeded()
                let transition = CATransition()
                transition.duration = 0.1
                transition.type = CATransitionType(rawValue: "push")
                transition.subtype = .fromLeft
                self.myProfileMyAnswerButton.isSelected = true
                self.myProfileMyAnswerButton.setTitleColor(UIColor.black, for: .selected)
                self.myProfileBottomLineView.layer.add(transition, forKey: kCATransition)
                self.myProfileBottomLineViewLeadingConstraint.constant = self.myProfileMyAnswerButton.frame.minX - 15
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
                    if self.myProfileSubData[indexPath.item].shareYN == "Y" {
                        myProfileCell?.myProfileContentButton.setBackgroundImage(UIImage(named: "Lock.png"), for: .normal)
                    } else {
                        myProfileCell?.myProfileContentButton.setBackgroundImage(UIImage(named: "UnLock.png"), for: .normal)
                    }
                    myProfileCell?.myProfileQuestionTitleLabel.text = "\(self.myProfileSubData[indexPath.item].question)"
                    myProfileCell?.myProfileContentDateLabel.text = self.myProfileSubData[indexPath.item].writtenDate
                    myProfileCell?.myProfileAnswerTitleLabel.text = self.myProfileSubData[indexPath.item].answer
                    myProfileCell?.shareButtonClouser = {
                        ProfileServerApi.putMyProfileShareProgress(cardSeq: self.myProfileSubData[indexPath.item].answerId, level: self.myProfileSubData[indexPath.item].level) { result in
                            if case let .success(data) = result, let list = data {
                                self.isshareFlag = !self.isshareFlag
                                let isFlag = self.myProfileSubData[indexPath.item].shareYN
                                if isFlag == "Y" {
                                    myProfileCell?.myProfileContentButton.setBackgroundImage(self.isshareFlag ? UIImage(named: "UnLock.png") : UIImage(named: "Lock.png"), for: .normal)
                                } else {
                                    myProfileCell?.myProfileContentButton.setBackgroundImage(self.isshareFlag ? UIImage(named: "Lock.png") : UIImage(named: "UnLock.png"), for: .normal)
                                }
                                print("true check \(self.myProfileSubData[indexPath.item].shareYN)")
                                print("index did tap \(self.myProfileSubData[indexPath.item].answerId)")
                                print("did tap data \(list)")
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
                    if self.myProfileLikeScrapSubData[indexPath.item].likes == 1 {
                        myProfileCell?.myProfileContentButton.setBackgroundImage(UIImage(named: "LikeOn.png"), for: .normal)
                    } else {
                        myProfileCell?.myProfileContentButton.setBackgroundImage(UIImage(named: "LikeOff.png"), for: .normal)
                    }
                    myProfileCell?.myProfileQuestionTitleLabel.text = "\(self.myProfileLikeScrapSubData[indexPath.item].question)"
                    myProfileCell?.myProfileContentDateLabel.text = self.myProfileLikeScrapSubData[indexPath.item].updateDate
                    myProfileCell?.myProfileAnswerTitleLabel.text = self.myProfileLikeScrapSubData[indexPath.item].answer
                    myProfileCell?.likesButtonClouser = {
                        let parameter = LikeProgressParameter(userId: self.myProfileLikeScrapData!.user_id, questId: self.myProfileLikeScrapSubData[indexPath.item].boardSeq)
                        ProfileServerApi.postMyProfileLikeProgress(likesParameter: parameter) {  result in
                            if case let .success(data) = result, let list = data {
                                print("did Tap like \(list)")
                                self.islikeFlag = !self.islikeFlag
                                let likeCount = self.myProfileLikeScrapSubData[indexPath.item].likes
                                if likeCount > 1 {
                                    myProfileCell?.myProfileContentButton.setBackgroundImage(self.islikeFlag ? UIImage(named: "LikeOff.png") : UIImage(named: "LikeOn.png"), for: .normal)
                                } else {
                                    myProfileCell?.myProfileContentButton.setBackgroundImage(self.islikeFlag ? UIImage(named: "LikeOn.png") : UIImage(named: "LikeOff.png"), for: .normal)
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
                    if self.myProfileLikeScrapSubData[indexPath.item].scraps == 1 {
                        myProfileCell?.myProfileContentButton.setBackgroundImage(UIImage(named: "ScrapsOn.png"), for: .normal)
                    } else {
                        myProfileCell?.myProfileContentButton.setBackgroundImage(UIImage(named: "ScrapsOff.png"), for: .normal)
                    }
                    myProfileCell?.myProfileQuestionTitleLabel.text = "\(self.myProfileLikeScrapSubData[indexPath.item].question)"
                    myProfileCell?.myProfileContentDateLabel.text = self.myProfileLikeScrapSubData[indexPath.item].updateDate
                    myProfileCell?.myProfileAnswerTitleLabel.text = self.myProfileLikeScrapSubData[indexPath.item].answer
                    myProfileCell?.scrapButtonClouser = {
                        let parameter = ScrapProgressParameter(userId: self.myProfileLikeScrapData!.user_id, questId: self.myProfileLikeScrapSubData[indexPath.item].boardSeq)
                        ProfileServerApi.postMyProfileScrapProgress(scrapParameter: parameter) { result in
                            if case let .success(data) = result, let _ = data {
                                self.isscrapFlag = !self.isscrapFlag
                                let scrpaFlag = self.myProfileLikeScrapSubData[indexPath.item].scraps
                                
                                if scrpaFlag == 1 {
                                    myProfileCell?.myProfileContentButton.setBackgroundImage(self.isscrapFlag ? UIImage(named: "ScrapsOn.png") : UIImage(named: "ScrapsOff.png"), for: .normal)
                                } else {
                                    myProfileCell?.myProfileContentButton.setBackgroundImage(self.isscrapFlag ? UIImage(named: "ScrapsOff.png") : UIImage(named: "ScrapsOn.png"), for: .normal)
                                }
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
            // TO-DO
            let myProfileCell = collectionView.cellForItem(at: indexPath) as? MyProfileCollectionViewCell
            myProfileCell?.selectIndex = indexPath.item
            
        } else {
            let myProfileTagCell = collectionView.cellForItem(at: indexPath) as? MyProfileTagCollectionViewCell
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
            return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 10)
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




