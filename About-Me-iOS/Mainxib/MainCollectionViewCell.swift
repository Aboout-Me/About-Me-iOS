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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setInitLayout()
    }
    
    public func setInitLayout() {
        
        self.mainContainerView.layer.borderColor = UIColor.clear.cgColor
        self.mainContainerView.layer.cornerRadius = 20
        self.mainContainerView.layer.masksToBounds = true
        self.mainContainerView.backgroundColor = UIColor.white
        self.mainTitleLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.mainTitleLabel.numberOfLines = 0
        self.mainTitleLabel.textAlignment = .center
        self.mainCharacterLabel.textColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1.0)
        self.mainCharacterLabel.textAlignment = .center
    }

}
