//
//  MainCollectionViewCell.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/08.
//

import UIKit
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
    @IBOutlet weak var homeBeforeLevelBoxView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setInitLayout()
    }
    
    public func setInitLayout() {
        
        //MARK: - View
        homeBeforeTitleLineView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        homeBeforeContainerView.layer.borderColor = UIColor.clear.cgColor
        homeBeforeContainerView.layer.cornerRadius = 10
        homeBeforeContainerView.layer.masksToBounds = false
        homeBeforeContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        homeBeforeContainerView.layer.shadowColor = UIColor.black10.cgColor
        homeBeforeContainerView.layer.shadowRadius = 5
        homeBeforeContainerView.backgroundColor = UIColor.white
        homeBeforeFirstTagView.layer.borderWidth = 1
        homeBeforeFirstTagView.layer.borderColor = UIColor.lineEee.cgColor
        homeBeforeFirstTagView.layer.masksToBounds = true
        homeBeforeFirstTagView.layer.cornerRadius = 3
        homeBeforeSecondTagView.layer.borderWidth = 1
        homeBeforeSecondTagView.layer.borderColor = UIColor.lineEee.cgColor
        homeBeforeSecondTagView.layer.masksToBounds = true
        homeBeforeSecondTagView.layer.cornerRadius = 3
        homeBeforeThirdTagView.layer.borderWidth = 1
        homeBeforeThirdTagView.layer.borderColor = UIColor.lineEee.cgColor
        homeBeforeThirdTagView.layer.masksToBounds = true
        homeBeforeThirdTagView.layer.cornerRadius = 3
        
        //MARK: - Label
        homeBeforeFirstTagLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        homeBeforeSecondTagLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        homeBeforeThirdTagLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        homeBeforeLevelLabel.textAlignment = .center
        homeBeforeTitleLabel.textColor = .gray333
        homeBeforeTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 20)
        homeBeforeTitleLabel.numberOfLines = 0
        homeBeforeTitleLabel.textAlignment = .center
        homeBeforeTitleLabel.lineBreakMode = .byWordWrapping
        homeBeforeCharacterLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        homeBeforeCharacterLabel.textColor = UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0)
        homeBeforeCharacterLabel.textAlignment = .center
    }

}
