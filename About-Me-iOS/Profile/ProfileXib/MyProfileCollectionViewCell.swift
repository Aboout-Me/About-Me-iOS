//
//  MyProfileCollectionViewCell.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/05/01.
//

import UIKit

class MyProfileCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var myProfileListContentView: UIView!
    @IBOutlet weak var myProfileContentTitleLabel: UILabel!
    @IBOutlet weak var myProfileContentDateLabel: UILabel!
    @IBOutlet weak var myProfileContentImageView: UIImageView!
    @IBOutlet weak var myProfileQuestionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setInitLayout()
    }

    private func setInitLayout() {
        self.myProfileListContentView.layer.borderWidth = 1
        self.myProfileListContentView.layer.borderColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1.0).cgColor
        self.myProfileListContentView.layer.cornerRadius = 8
        self.myProfileListContentView.layer.masksToBounds = true
        self.myProfileQuestionTitleLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.myProfileQuestionTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        self.myProfileQuestionTitleLabel.textAlignment = .left
        self.myProfileQuestionTitleLabel.numberOfLines = 0
        self.myProfileContentDateLabel.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        self.myProfileContentDateLabel.textAlignment = .left
        self.myProfileContentDateLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        self.myProfileContentTitleLabel.textColor = UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0)
        self.myProfileContentTitleLabel.textAlignment = .left
        self.myProfileContentTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
    }
}
