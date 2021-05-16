//
//  MyProfileViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/01.
//

import UIKit
import Floaty

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
    @IBOutlet weak var myProfileMyAnswerButton: UIButton!
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
        let nib = UINib(nibName: "MyProfileCollectionViewCell", bundle: nil)
        let nib2 = UINib(nibName: "MyProfileTagCollectionViewCell", bundle: nil)
        self.myProfileCollectionView.register(nib, forCellWithReuseIdentifier: "MyProfileCell")
        self.myProfileTagCollectionView.register(nib2, forCellWithReuseIdentifier: "MyProfileTagCell")
        self.myProfileCollectionView.delegate = self
        self.myProfileCollectionView.dataSource = self
        self.myProfileTagCollectionView.delegate = self
        self.myProfileTagCollectionView.dataSource = self
        self.myProfileTagCollectionView.showsHorizontalScrollIndicator = false
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
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        self.myProfileCharacterContentLabel.numberOfLines = 0
        self.myProfileCharacterContentLabel.textColor = UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.0)
        self.myProfileCharacterContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        self.myProfileCharacterContentLabel.textAlignment = .left
        self.myProfileCharacterContentLabel.attributedText = NSAttributedString(string: "안녕하세요. 저는 다양한 분야에 관심이 많고,  경험하는 것을 좋아하는 프로 열정러입니다!", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        self.myProfileImageViewContainer.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        self.myProfileImageViewContainer.layer.cornerRadius = self.myProfileImageViewContainer.frame.size.width / 2
        self.myProfileImageViewContainer.layer.masksToBounds = true
        self.myProfileImageView.image = UIImage(named: "CharacterRed.png")
        self.myProfileNickNameLabel.text = "@ dohyun"
        self.myProfileNickNameLabel.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        self.myProfileNickNameLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        self.myProfileNickNameLabel.textAlignment = .left
        self.detailPushButton.setImage(UIImage(named: "Arrow.png"), for: .normal)
        self.detailPushButton.addTarget(self, action: #selector(self.didTapdetailPushButton), for: .touchUpInside)
        self.myProfileCharacterTagFirst.layer.borderColor =  UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        self.myProfileCharacterTagFirst.layer.borderWidth = 1
        self.myProfileCharacterTagFirst.layer.cornerRadius = 3
        self.myProfileCharacterTagFirst.layer.masksToBounds = true
        self.myProfileCharacterTagFirst.setTitle("#열정", for: .normal)
        self.myProfileCharacterTagFirst.setTitleColor(UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0), for: .normal)
        self.myProfileCharacterTagFirst.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        self.myProfileCharacterTagSecond.layer.borderColor =  UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        self.myProfileCharacterTagSecond.layer.borderWidth = 1
        self.myProfileCharacterTagSecond.layer.cornerRadius = 3
        self.myProfileCharacterTagSecond.layer.masksToBounds = true
        self.myProfileCharacterTagSecond.setTitle("#진로", for: .normal)
        self.myProfileCharacterTagSecond.setTitleColor(UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0), for: .normal)
        self.myProfileCharacterTagSecond.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        self.myProfileCharacterTagThird.layer.borderColor =  UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        self.myProfileCharacterTagThird.layer.borderWidth = 1
        self.myProfileCharacterTagThird.layer.cornerRadius = 3
        self.myProfileCharacterTagThird.layer.masksToBounds = true
        self.myProfileCharacterTagThird.setTitle("#미래", for: .normal)
        self.myProfileCharacterTagThird.setTitleColor(UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0), for: .normal)
        self.myProfileCharacterTagThird.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        self.myProfileContentContainerView.layer.cornerRadius = 25
        self.myProfileContentContainerView.layer.masksToBounds = true
        self.myProfileMyAnswerButton.isSelected = true
        self.myProfileMyAnswerButton.setTitle("내가 한 답", for: .selected)
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
        self.myProfileFloatingButton.addItem("내 피드", icon: UIImage(named: "feed.png"))
        self.myProfileFloatingButton.addItem("자문 자답", icon: UIImage(named: "lock.png")) { item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let advisoryAnswerView = storyboard.instantiateViewController(withIdentifier: "AdvisoryAnswerVC") as? AdvisoryAnswerViewController
            guard let advisoryAnswerVC = advisoryAnswerView else { return }
            self.navigationController?.pushViewController(advisoryAnswerVC, animated: true)
        }
        self.myProfileFloatingButton.addItem("오늘의 질문", icon: UIImage(named: "heart.png"))
    }
    
    @objc
    private func didTapMyLikeButton(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5, delay: 1.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveLinear) {
            
            if self.myProfileBottomLineView.frame.origin.x > self.myProfileMyLikeButton.frame.origin.x {
                self.myProfileBottomLineView.layoutIfNeeded()
                let transition = CATransition()
                transition.duration = 0.1
                transition.type = CATransitionType(rawValue: "push")
                transition.subtype = .fromRight
                self.myProfileBottomLineView.layer.add(transition, forKey: kCATransition)
                self.myProfileBottomLineViewLeadingConstraint.constant = self.myProfileMyLikeButton.frame.minX - 15
                self.myProfileBottomLineView.updateConstraints()
            } else {
                self.myProfileBottomLineView.layoutIfNeeded()
                let transition = CATransition()
                transition.duration = 0.1
                transition.type = CATransitionType(rawValue: "push")
                transition.subtype = .fromLeft
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
        UIView.animate(withDuration: 0.5, delay: 1.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveLinear) {
            self.myProfileBottomLineView.layoutIfNeeded()
            let transition = CATransition()
            transition.duration = 0.1
            transition.type = CATransitionType(rawValue: "push")
            transition.subtype = .fromLeft
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
        UIView.animate(withDuration: 0.5, delay: 1.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveLinear) {
            if self.myProfileBottomLineView.frame.origin.x > self.myProfileMyAnswerButton.frame.origin.x {
                self.myProfileBottomLineView.layoutIfNeeded()
                let transition = CATransition()
                transition.duration = 0.1
                transition.type = CATransitionType(rawValue: "push")
                transition.subtype = .fromRight
                self.myProfileBottomLineView.layer.add(transition, forKey: kCATransition)
                self.myProfileBottomLineViewLeadingConstraint.constant = self.myProfileMyAnswerButton.frame.minX - 15
                self.myProfileBottomLineView.updateConstraints()
            } else {
                self.myProfileBottomLineView.layoutIfNeeded()
                let transition = CATransition()
                transition.duration = 0.1
                transition.type = CATransitionType(rawValue: "push")
                transition.subtype = .fromLeft
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
            return 5
        } else {
            return self.tagNameList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.myProfileCollectionView {
            let myProfileCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileCell", for: indexPath) as? MyProfileCollectionViewCell
            myProfileCell?.myProfileContentTitleLabel.text = "# 열정충만"
            myProfileCell?.myProfileQuestionTitleLabel.text = "Q. 당신에게 가족은 어떤 의미인가요?"
            myProfileCell?.myProfileContentDateLabel.text = "2021.03.19"
            myProfileCell?.myProfileContentImageView.image = UIImage(named: "Lock.png")
            
            return myProfileCell!
        } else {
            let myProfileTagCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileTagCell", for: indexPath) as? MyProfileTagCollectionViewCell
            if indexPath.item == 0 {
                myProfileTagCell?.myProfileTagButton.isSelected = true
                myProfileTagCell?.myProfileTagButton.layer.borderColor = UIColor.clear.cgColor
                myProfileTagCell?.myProfileTagButton.setTitleColor(.white, for: .selected)
                myProfileTagCell?.myProfileTagButton.backgroundColor =  UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            }
            myProfileTagCell?.myProfileTagButton.setTitle(self.tagNameList[indexPath.item], for: .normal)
            return myProfileTagCell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.myProfileCollectionView {
            // 추가 예정
            
        } else {
            let myProfileTagCell = collectionView.cellForItem(at: indexPath) as? MyProfileTagCollectionViewCell
            if indexPath.item != 0 {
                myProfileTagCell?.myProfileTagButton.isSelected = false
                myProfileTagCell?.myProfileTagButton.setTitleColor(UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.0), for: .normal)
                myProfileTagCell?.myProfileTagButton.backgroundColor = .white
            }
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .right)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.myProfileCollectionView {
            return CGSize(width: 335, height: 100)
        } else {
            let myTextCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileTagCell", for: indexPath) as? MyProfileTagCollectionViewCell
            return CGSize(width: (myTextCell?.myProfileTagButton.intrinsicContentSize.width)!, height: 30)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.myProfileCollectionView {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 10)
        }
    }
    
    
}
