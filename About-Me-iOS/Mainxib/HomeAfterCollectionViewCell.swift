//
//  HomeAfterCollectionViewCell.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/19.
//

import UIKit

class HomeAfterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var homeAfterContainerView: UIView!
    @IBOutlet weak var homeAfterTitleLabel: UILabel!
    @IBOutlet weak var homeAfterSubjectLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setLayoutInit()
    }
    private func setLayoutInit() {
        self.homeAfterContainerView.layer.borderColor = UIColor.clear.cgColor
        self.homeAfterContainerView.layer.cornerRadius = 20
        self.homeAfterContainerView.layer.masksToBounds = true
        self.homeAfterContainerView.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.homeAfterTitleLabel.numberOfLines = 0
        self.homeAfterTitleLabel.textAlignment = .center
        self.homeAfterTitleLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.homeAfterSubjectLabel.numberOfLines = 0
        self.homeAfterSubjectLabel.textAlignment = .center
        self.homeAfterSubjectLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.homeAfterSubjectLabel.lineBreakMode = .byCharWrapping
    }
}
