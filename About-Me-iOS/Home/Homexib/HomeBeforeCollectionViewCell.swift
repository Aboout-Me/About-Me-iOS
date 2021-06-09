//
//  MainCollectionViewCell.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/08.
//

import UIKit
import Hero
class HomeBeforeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var homeBeforeContainerView: UIView!
    @IBOutlet weak var homeBeforeTitleLabel: UILabel!
    @IBOutlet weak var homeBeforeCharacterLabel: UILabel!
    @IBOutlet weak var homeBeforeCharacterTagFirstButton: UIButton!
    @IBOutlet weak var homeBeforeCharacterTagSecondButton: UIButton!
    @IBOutlet weak var homeBeforeCharacterTagThirdButton: UIButton!
    @IBOutlet weak var homeBeforeTitleLineView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setInitLayout()
    }
    
    public func setInitLayout() {
        self.homeBeforeTitleLineView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        self.homeBeforeContainerView.layer.borderColor = UIColor.clear.cgColor
        self.homeBeforeContainerView.layer.cornerRadius = 20
        self.homeBeforeContainerView.layer.masksToBounds = true
        self.homeBeforeContainerView.backgroundColor = UIColor.white
        self.homeBeforeTitleLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.homeBeforeTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 20)
        self.homeBeforeTitleLabel.numberOfLines = 0
        self.homeBeforeTitleLabel.textAlignment = .center
        self.homeBeforeTitleLabel.lineBreakMode = .byWordWrapping
        self.homeBeforeCharacterLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        self.homeBeforeCharacterLabel.textColor = UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0)
        self.homeBeforeCharacterLabel.textAlignment = .center
        self.homeBeforeCharacterTagFirstButton.layer.borderWidth = 1
        self.homeBeforeCharacterTagFirstButton.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        self.homeBeforeCharacterTagFirstButton.layer.cornerRadius = 3
        self.homeBeforeCharacterTagFirstButton.layer.masksToBounds = true
        self.homeBeforeCharacterTagFirstButton.setTitleColor(UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0), for: .normal)
        self.homeBeforeCharacterTagFirstButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        self.homeBeforeCharacterTagSecondButton.layer.borderWidth = 1
        self.homeBeforeCharacterTagSecondButton.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        self.homeBeforeCharacterTagSecondButton.layer.cornerRadius = 3
        self.homeBeforeCharacterTagSecondButton.layer.masksToBounds = true
        self.homeBeforeCharacterTagSecondButton.setTitleColor(UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0), for: .normal)
        self.homeBeforeCharacterTagSecondButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        self.homeBeforeCharacterTagThirdButton.layer.borderWidth = 1
        self.homeBeforeCharacterTagThirdButton.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        self.homeBeforeCharacterTagThirdButton.layer.cornerRadius = 3
        self.homeBeforeCharacterTagThirdButton.layer.masksToBounds = true
        self.homeBeforeCharacterTagThirdButton.setTitleColor(UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0), for: .normal)
        self.homeBeforeCharacterTagThirdButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
    }

}
