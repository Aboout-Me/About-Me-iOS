//
//  MainCollectionViewCell.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/08.
//

import UIKit
import Hero
class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainContainerView: UIView! {
        didSet {
            self.mainContainerView.heroID = "mainContainerView"
        }
    }
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var mainCharacterLabel: UILabel!
    @IBOutlet weak var mainCharacterTagFirstButton: UIButton!
    @IBOutlet weak var mainCharacterTagSecondButton: UIButton!
    @IBOutlet weak var mainCharacterTagThirdButton: UIButton!
    @IBOutlet weak var mainTitleLineView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setInitLayout()
    }
    
    public func setInitLayout() {
        
        let ParagraphStyle = NSMutableParagraphStyle()
        ParagraphStyle.lineSpacing = 2
        self.mainTitleLineView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        self.mainContainerView.layer.borderColor = UIColor.clear.cgColor
        self.mainContainerView.layer.cornerRadius = 20
        self.mainContainerView.layer.masksToBounds = true
        self.mainContainerView.backgroundColor = UIColor.white
        self.mainTitleLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.mainTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 20)
        self.mainTitleLabel.numberOfLines = 0
        self.mainTitleLabel.textAlignment = .center
        self.mainTitleLabel.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle: ParagraphStyle])
        self.mainCharacterLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        self.mainCharacterLabel.textColor = UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0)
        self.mainCharacterLabel.textAlignment = .center
        self.mainCharacterTagFirstButton.layer.borderWidth = 1
        self.mainCharacterTagFirstButton.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        self.mainCharacterTagFirstButton.layer.cornerRadius = 3
        self.mainCharacterTagFirstButton.layer.masksToBounds = true
        self.mainCharacterTagFirstButton.setTitleColor(UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0), for: .normal)
        self.mainCharacterTagFirstButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        self.mainCharacterTagSecondButton.layer.borderWidth = 1
        self.mainCharacterTagSecondButton.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        self.mainCharacterTagSecondButton.layer.cornerRadius = 3
        self.mainCharacterTagSecondButton.layer.masksToBounds = true
        self.mainCharacterTagSecondButton.setTitleColor(UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0), for: .normal)
        self.mainCharacterTagSecondButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        self.mainCharacterTagThirdButton.layer.borderWidth = 1
        self.mainCharacterTagThirdButton.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        self.mainCharacterTagThirdButton.layer.cornerRadius = 3
        self.mainCharacterTagThirdButton.layer.masksToBounds = true
        self.mainCharacterTagThirdButton.setTitleColor(UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0), for: .normal)
        self.mainCharacterTagThirdButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
    }

}
