//
//  MyProfileCollectionViewCell.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/05/01.
//

import UIKit

class MyProfileCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var myProfileQuestionLabel: UILabel!
    @IBOutlet weak var myProfileListContentView: UIView!
    @IBOutlet weak var myProfileContentTitleLabel: UILabel!
    @IBOutlet weak var myProfileContentDateLabel: UILabel!
    @IBOutlet weak var myProfileContentButton: UIButton!
    @IBOutlet weak var myProfileQuestionTitleLabel: UILabel!
    @IBOutlet weak var myProfileAnswerTitleLabel: UILabel!
    @IBOutlet weak var myProfileAnswerImageView: UIImageView!
    public var shareButtonClouser: (() -> ())?
    public var likesButtonClouser: (() -> ())?
    public var scrapButtonClouser: (() -> ())?
    public var selectIndex = 0
    public var CategoryFlag = ""
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
        self.myProfileQuestionLabel.text = "Q. "
        self.myProfileQuestionLabel.numberOfLines = 0
        self.myProfileQuestionLabel.sizeToFit()
        self.myProfileQuestionLabel.textColor = UIColor.gray333
        self.myProfileQuestionLabel.textAlignment = .left
        self.myProfileQuestionLabel.font = UIFont(name: "GmarketSansMedium", size: 13)
        self.myProfileQuestionTitleLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.myProfileQuestionTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        self.myProfileQuestionTitleLabel.textAlignment = .left
        self.myProfileQuestionTitleLabel.numberOfLines = 0
        self.myProfileAnswerTitleLabel.textColor = UIColor.gray777
        self.myProfileAnswerTitleLabel.textAlignment = .left
        self.myProfileAnswerTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        self.myProfileAnswerTitleLabel.numberOfLines = 2
        self.myProfileAnswerTitleLabel.lineBreakMode = .byTruncatingTail
        self.myProfileAnswerTitleLabel.sizeToFit()
        self.myProfileContentDateLabel.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        self.myProfileContentDateLabel.textAlignment = .left
        self.myProfileContentDateLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        self.myProfileContentTitleLabel.textColor = UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0)
        self.myProfileContentTitleLabel.textAlignment = .left
        self.myProfileContentTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        self.myProfileAnswerImageView.image = UIImage(named: "slice")
        self.myProfileAnswerImageView.contentMode = .scaleToFill
        self.myProfileContentButton.addTarget(self, action: #selector(didTapMyProfileShareButton(_:)), for: .touchUpInside)
        
    }
    
    
    @objc
    public func didTapMyProfileShareButton(_ sender: UIButton) {
        switch self.CategoryFlag {
        case "answer":
            shareButtonClouser!()
        case "likes":
            likesButtonClouser!()
        case "scrap":
            scrapButtonClouser!()
        default:
            break
        }
    }
}
