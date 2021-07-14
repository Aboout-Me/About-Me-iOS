//
//  SocialOtherProfileViewController.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/07/03.
//

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitLayout()
    }
    
    private func setInitLayout() {
//        self.socialProfileTagCollectionView.delegate = self
//        self.socialProfileTagCollectionView.dataSource = self
        
        self.socialContentView.clipsToBounds = true
        self.socialContentView.layer.cornerRadius = 25
        self.socialCharacterImageContentView.clipsToBounds = true
        self.socialCharacterImageContentView.layer.cornerRadius = self.socialCharacterImageContentView.frame.width / 2
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
    
// TO DO : GET API Request
    
//    private func getOtherProfile() {
//        let parameter = [
//            "color": color
//        ]
//        ProfileServerApi.getSocialProfileUserProgress(userId: userId, otherId: otherId, parameter: parameter) { <#ProfileServerApi.Result<OtherProfilePage>#> in
//            <#code#>
//        }
//
//    }
    
}

// TO DO : CollectionView Delegate

//extension SocialOtherProfileViewController: UICollectionViewDelegate,UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
    
    
//}
