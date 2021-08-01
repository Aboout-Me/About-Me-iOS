//
//  HomeAfterCollectionViewCell.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/19.
//

import UIKit

class HomeAfterCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var homeAfterTagButton: UIButton!
    @IBOutlet weak var homeAfterContainerView: UIView!
    @IBOutlet weak var homeAfterTitleLabel: UILabel!
    @IBOutlet weak var homeAfterSubjectLabel: UILabel!
    @IBOutlet weak var homeAfterEditButton: UIButton!
    @IBOutlet weak var homeAfterTitleLineView: UIView!
    @IBOutlet weak var homeAfterLevelView: UIView!
    @IBOutlet weak var homeAfterLevelLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setLayoutInit()
    }
    private func setLayoutInit() {
        
        //MARK: -SuperView
        self.contentView.isUserInteractionEnabled = true
        
        //MARK: - View
        homeAfterContainerView.layer.borderColor = UIColor.clear.cgColor
        homeAfterContainerView.layer.cornerRadius = 10
        homeAfterContainerView.clipsToBounds = true
        homeAfterContainerView.backgroundColor = UIColor.white
        homeAfterContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        homeAfterContainerView.layer.shadowColor = UIColor.black10.cgColor
        homeAfterContainerView.layer.shadowRadius = 5
        homeAfterTitleLineView.backgroundColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        homeAfterLevelView.layer.borderWidth = 1
        homeAfterLevelView.layer.borderColor = UIColor.gray555.cgColor
        homeAfterLevelView.layer.cornerRadius = 3
        
        //MARK: - Label
        homeAfterTitleLabel.numberOfLines = 0
        homeAfterTitleLabel.textAlignment = .left
        homeAfterTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 20)
        homeAfterTitleLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        homeAfterSubjectLabel.numberOfLines = 0
        homeAfterSubjectLabel.textAlignment = .left
        homeAfterSubjectLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        homeAfterSubjectLabel.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        homeAfterSubjectLabel.lineBreakMode = .byTruncatingTail
        homeAfterLevelLabel.textColor = .gray333
        homeAfterLevelLabel.font = UIFont(name: "GmarketSansMedium", size: 11)
        homeAfterLevelLabel.textAlignment = .left

        //MARK: - Button
        homeAfterTagButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
        homeAfterTagButton.titleLabel?.textAlignment = .center
        homeAfterTagButton.setTitleColor(.white, for: .normal)
        homeAfterTagButton.layer.masksToBounds = true
        homeAfterTagButton.layer.cornerRadius = 3
        homeAfterTagButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        homeAfterTagButton.isEnabled = false
    }
}
