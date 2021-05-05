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
    @IBOutlet weak var myProfileMyAnswerButton: UIButton!
    @IBOutlet weak var myProfileMyLikeButton: UIButton!
    @IBOutlet weak var myProfileMyScrapButton: UIButton!
    @IBOutlet weak var myProfileBottomLineView: UIView!
    @IBOutlet weak var myProfileCollectionView: UICollectionView!
    @IBOutlet weak var myProfileImageViewContainer: UIView!
    @IBOutlet weak var myProfileImageView: UIImageView!
    var myProfileBottomLineViewLeadingConstraint:NSLayoutConstraint!
    var myProfileBottomLineViewWidthConstraint: NSLayoutConstraint!
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
        self.myProfileCollectionView.register(nib, forCellWithReuseIdentifier: "MyProfileCell")
        self.myProfileCollectionView.delegate = self
        self.myProfileCollectionView.dataSource = self
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
        self.myProfileImageViewContainer.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        self.myProfileImageViewContainer.layer.cornerRadius = self.myProfileImageViewContainer.frame.size.width / 2
        self.myProfileImageViewContainer.layer.masksToBounds = true
        self.myProfileImageView.image = UIImage(named: "CharacterRed.png")
        self.myProfileCharacterContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        self.myProfileCharacterContentLabel.textAlignment = .left
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
        self.myProfileCharacterTagSecond.layer.borderColor =  UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        self.myProfileCharacterTagSecond.layer.borderWidth = 1
        self.myProfileCharacterTagSecond.layer.cornerRadius = 3
        self.myProfileCharacterTagSecond.layer.masksToBounds = true
        self.myProfileCharacterTagSecond.setTitle("#진로", for: .normal)
        self.myProfileCharacterTagSecond.setTitleColor(UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0), for: .normal)
        self.myProfileCharacterTagThird.layer.borderColor =  UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        self.myProfileCharacterTagThird.layer.borderWidth = 1
        self.myProfileCharacterTagThird.layer.cornerRadius = 3
        self.myProfileCharacterTagThird.layer.masksToBounds = true
        self.myProfileCharacterTagThird.setTitle("#미래", for: .normal)
        self.myProfileCharacterTagThird.setTitleColor(UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0), for: .normal)
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myProfileCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileCell", for: indexPath) as? MyProfileCollectionViewCell
        myProfileCell?.myProfileContentTitleLabel.text = "# 열정충만"
        myProfileCell?.myProfileQuestionTitleLabel.text = "Q. 당신에게 가족은 어떤 의미인가요?"
        myProfileCell?.myProfileContentDateLabel.text = "2021.03.19"
        
        return myProfileCell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 335, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
}
