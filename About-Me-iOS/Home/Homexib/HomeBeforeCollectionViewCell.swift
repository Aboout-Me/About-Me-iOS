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
    @IBOutlet weak var homeBeforeTitleLineView: UIView!
    @IBOutlet weak var homeBeforeFirstTagView: UIView!
    @IBOutlet weak var homeBeforeSecondTagView: UIView!
    @IBOutlet weak var homeBeforeThirdTagView: UIView!
    @IBOutlet weak var homeBeforeFirstTagLabel: UILabel!
    @IBOutlet weak var homeBeforeSecondTagLabel: UILabel!
    @IBOutlet weak var homeBeforeThirdTagLabel: UILabel!
    @IBOutlet weak var homeBeforeLevelLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setInitLayout()
    }
    
    public func setInitLayout() {
        self.homeBeforeTitleLineView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        self.homeBeforeContainerView.layer.borderColor = UIColor.clear.cgColor
        self.homeBeforeContainerView.layer.cornerRadius = 10
        self.homeBeforeContainerView.layer.masksToBounds = false
        self.homeBeforeContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.homeBeforeContainerView.layer.shadowColor = UIColor.black10.cgColor
        self.homeBeforeContainerView.layer.shadowRadius = 5
        self.homeBeforeContainerView.backgroundColor = UIColor.white
        self.homeBeforeTitleLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.homeBeforeTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 20)
        self.homeBeforeTitleLabel.numberOfLines = 0
        self.homeBeforeTitleLabel.textAlignment = .center
        self.homeBeforeTitleLabel.lineBreakMode = .byWordWrapping
        self.homeBeforeCharacterLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        self.homeBeforeCharacterLabel.textColor = UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0)
        self.homeBeforeCharacterLabel.textAlignment = .center
        self.homeBeforeFirstTagView.layer.borderWidth = 1
        self.homeBeforeFirstTagView.layer.borderColor = UIColor.lineEee.cgColor
        self.homeBeforeFirstTagView.layer.masksToBounds = true
        self.homeBeforeFirstTagView.layer.cornerRadius = 3
        self.homeBeforeSecondTagView.layer.borderWidth = 1
        self.homeBeforeSecondTagView.layer.borderColor = UIColor.lineEee.cgColor
        self.homeBeforeSecondTagView.layer.masksToBounds = true
        self.homeBeforeSecondTagView.layer.cornerRadius = 3
        self.homeBeforeThirdTagView.layer.borderWidth = 1
        self.homeBeforeThirdTagView.layer.borderColor = UIColor.lineEee.cgColor
        self.homeBeforeThirdTagView.layer.masksToBounds = true
        self.homeBeforeThirdTagView.layer.cornerRadius = 3
        self.homeBeforeFirstTagLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        self.homeBeforeSecondTagLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        self.homeBeforeThirdTagLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        
    }

}
