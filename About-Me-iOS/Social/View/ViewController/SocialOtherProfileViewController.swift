//
//  SocialOtherProfileViewController.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/07/03.
//

enum SocialRequestType {
    case Single
    case All
}

import UIKit

class SocialOtherProfileViewController: UIViewController {
    

    @IBOutlet weak var socialDetailPushButton: UIButton!
    @IBOutlet weak var socialCharacterNicknameLabel: UILabel!
    @IBOutlet weak var socialCharacterImageView: UIImageView!
    @IBOutlet weak var socialCharacterImageContentView: UIView!
    @IBOutlet weak var socialUserNicknameLabel: UILabel!
    @IBOutlet weak var socialBackgroundImageView: UIImageView!
    @IBOutlet weak var socialContentView: UIView!
    @IBOutlet weak var socialFirstTagView: UIView!
    @IBOutlet weak var socialSecondTagView: UIView!
    @IBOutlet weak var socialThirdTagView: UIView!
    @IBOutlet weak var socialFirstTagLabel: UILabel!
    @IBOutlet weak var socialSecondTagLabel: UILabel!
    @IBOutlet weak var socialThirdTagLabel: UILabel!
    @IBOutlet weak var socialUserContentLabel: UILabel!
    @IBOutlet weak var socialUserNicknameContentLabel: UILabel!
    @IBOutlet weak var socialProfileTagCollectionView: UICollectionView!
    @IBOutlet weak var socialProfileMainCollectionView: UICollectionView!
    public var otherId: Int?
    public var userId: Int?
    public var color: String?
    private var socialProfileData: OtherProfilePage? = nil
    private var socialProfileModelList = [OtherProfilePageModel]()
    private var socialRequestType = SocialRequestType.All
    private var socialTagNameList = ["전체","열정충만","소소한 일상","기억상자","관계의미학","상상플러스"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitLayout()
    }
    
    private func setInitLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.socialProfileTagCollectionView.collectionViewLayout = layout
        self.socialProfileTagCollectionView.delegate = self
        self.socialProfileTagCollectionView.dataSource = self
        self.socialProfileTagCollectionView.showsHorizontalScrollIndicator = false
        self.socialProfileTagCollectionView.allowsMultipleSelection = false
        let nib = UINib(nibName: "MyProfileTagCollectionViewCell", bundle: nil)
        self.socialProfileTagCollectionView.register(nib, forCellWithReuseIdentifier: "MyProfileTagCell")
        self.socialContentView.clipsToBounds = true
        self.socialContentView.layer.cornerRadius = 25
        self.socialCharacterImageContentView.clipsToBounds = true
        self.socialCharacterImageContentView.layer.cornerRadius = self.socialCharacterImageContentView.frame.width / 2
        self.socialCharacterImageContentView.backgroundColor = .whiteTwo
        self.socialCharacterNicknameLabel.font = UIFont(name: "GmarketSansMedium", size: 16)
        self.socialCharacterNicknameLabel.textColor = .white
        self.socialCharacterNicknameLabel.textAlignment = .left
        self.socialUserContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        self.socialUserContentLabel.textColor = .white
        self.socialUserContentLabel.textAlignment = .left
        self.socialUserNicknameContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 11)
        self.socialUserNicknameContentLabel.textColor = UIColor(white: 255/255, alpha: 0.8)
        self.socialUserNicknameContentLabel.textAlignment = .left
        self.socialFirstTagView.backgroundColor = .clear
        self.socialFirstTagView.layer.borderWidth = 1
        self.socialFirstTagView.layer.borderColor = UIColor(white: 255/255, alpha: 0.4).cgColor
        self.socialSecondTagView.backgroundColor = .clear
        self.socialSecondTagView.layer.borderWidth = 1
        self.socialSecondTagView.layer.borderColor = UIColor(white: 255/255, alpha: 0.4).cgColor
        self.socialThirdTagView.backgroundColor = .clear
        self.socialThirdTagView.layer.borderWidth = 1
        self.socialThirdTagView.layer.borderColor = UIColor(white: 255/255, alpha: 0.4).cgColor
        
        self.socialFirstTagLabel.textColor = .white
        self.socialFirstTagLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 9)
        self.socialFirstTagLabel.textAlignment = .left
        self.socialSecondTagLabel.textColor = .white
        self.socialSecondTagLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 9)
        self.socialSecondTagLabel.textAlignment = .left
        self.socialThirdTagLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 9)
        self.socialThirdTagLabel.textColor = .white
        self.socialThirdTagLabel.textAlignment = .left
        self.socialUserNicknameLabel.textColor = .gray555
        self.socialUserNicknameLabel.font = UIFont(name: "GmarketSansMedium", size: 14)
        self.socialUserNicknameLabel.textAlignment = .center
        
    }
    
    private func setCharacterColor() {
        if self.socialProfileData?.color == "red" {
            self.socialBackgroundImageView.image = UIImage(named: "imgBackgroundRed")
            self.socialCharacterImageView.image = UIImage(named: "CharacterRed")
            self.socialCharacterNicknameLabel.text = "\(self.socialProfileData!.color_tag)"
            self.socialUserContentLabel.text = "\(self.socialProfileData!.introduce)"
            self.socialUserNicknameContentLabel.text = "\(self.socialProfileData!.nickName)"
            self.socialUserNicknameLabel.text = "\(self.socialProfileData!.nickName)님의 응답"
            self.socialFirstTagLabel.text = "#열정"
            self.socialSecondTagLabel.text = "#진로"
            self.socialThirdTagLabel.text = "#미래"
        } else if self.socialProfileData?.color == "yellow" {
            self.socialBackgroundImageView.image = UIImage(named: "imgBackgroundYellow")
            self.socialCharacterImageView.image = UIImage(named: "characterYellow")
            self.socialCharacterNicknameLabel.text = "\(self.socialProfileData!.color_tag)"
            self.socialUserContentLabel.text = "\(self.socialProfileData!.introduce)"
            self.socialUserNicknameContentLabel.text = "\(self.socialProfileData!.nickName)"
            self.socialUserNicknameLabel.text = "\(self.socialProfileData!.nickName)님의 응답"
            self.socialFirstTagLabel.text = "#일상"
            self.socialSecondTagLabel.text = "#추억"
            self.socialThirdTagLabel.text = "#취향"
        } else if self.socialProfileData?.color == "green" {
            self.socialBackgroundImageView.image = UIImage(named: "imgBackgroundGreen")
            self.socialCharacterImageView.image = UIImage(named: "CharacterGreen")
            self.socialCharacterNicknameLabel.text = "\(self.socialProfileData!.color_tag)"
            self.socialUserContentLabel.text = "\(self.socialProfileData!.introduce)"
            self.socialUserNicknameContentLabel.text = "\(self.socialProfileData!.nickName)"
            self.socialUserNicknameLabel.text = "\(self.socialProfileData!.nickName)님의 응답"
            self.socialFirstTagLabel.text = "#힐링"
            self.socialSecondTagLabel.text = "#치유"
            self.socialThirdTagLabel.text = "#위로"
        } else if self.socialProfileData?.color == "pink" {
            self.socialBackgroundImageView.image = UIImage(named: "imgBackgroundPink")
            self.socialCharacterImageView.image = UIImage(named: "CharacterPink")
            self.socialCharacterNicknameLabel.text = "\(self.socialProfileData!.color_tag)"
            self.socialUserContentLabel.text = "\(self.socialProfileData!.introduce)"
            self.socialUserNicknameContentLabel.text = "\(self.socialProfileData!.nickName)"
            self.socialUserNicknameLabel.text = "\(self.socialProfileData!.nickName)님의 응답"
            self.socialFirstTagLabel.text = "#연애"
            self.socialSecondTagLabel.text = "#사랑"
            self.socialThirdTagLabel.text = "#가치관"
        } else {
            self.socialBackgroundImageView.image = UIImage(named: "imgBackgroundViolet")
            self.socialCharacterImageView.image = UIImage(named: "CharacterVilolet")
            self.socialCharacterNicknameLabel.text = "\(self.socialProfileData!.color_tag)"
            self.socialUserContentLabel.text = "\(self.socialProfileData!.introduce)"
            self.socialUserNicknameContentLabel.text = "\(self.socialProfileData!.nickName)"
            self.socialUserNicknameLabel.text = "\(self.socialProfileData!.nickName)님의 응답"
            self.socialFirstTagLabel.text = "#만약에"
            self.socialSecondTagLabel.text = "#상상"
            self.socialThirdTagLabel.text = "#희망"
        }
    }
    
    
    private func getOtherProfile() {
        let parameter = [
            "color": color!
        ]
        
        switch socialRequestType {
        case .All:
            ProfileServerApi.getSocialProfileUserProgress(userId: userId!, otherId: otherId!, parameter: nil) { result in
                if case let  .success(data) = result, let list = data  {
                    self.socialProfileData = list
                    self.socialProfileModelList = list.postList
                    DispatchQueue.main.async {
                        self.setCharacterColor()
                    }
                    print("social Profile All Data \(self.socialProfileData)")
                    print("social Profile All Model Data \(self.socialProfileModelList)")
                }
            }
        case .Single:
            ProfileServerApi.getSocialProfileUserProgress(userId: userId!, otherId: otherId!, parameter: parameter) { result in
                if case let .success(data) = result, let list = data {
                    self.socialProfileData = list
                    self.socialProfileModelList = list.postList
                    DispatchQueue.main.async {
                        self.setCharacterColor()
                    }
                    print("social Profile Single Data \(self.socialProfileData)")
                    print("socail Profile Single Model Data \(self.socialProfileModelList)")
                }
            }
            
        }
    }
    
}

// TO DO : CollectionView Delegate

extension SocialOtherProfileViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.socialTagNameList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileTagCell", for: indexPath) as? MyProfileTagCollectionViewCell
        tagCell!.myProfileTagButton.setTitle(self.socialTagNameList[indexPath.item], for: .normal)
        
        return tagCell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tagLabel = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileTagCell", for: indexPath) as? MyProfileTagCollectionViewCell
        print("tagLabel Size test \(tagLabel?.myProfileTagButton.intrinsicContentSize.width)")
        
        return CGSize(width: 100, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5
    }


}
