//
//  MyProfileTagCollectionViewCell.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/05/05.
//

import UIKit

class MyProfileTagCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var myProfileTagButton: UIButton!
    
    override var isSelected: Bool {
        didSet {
            if isSelected == true {
                self.myProfileTagButton.isSelected = true
                self.myProfileTagButton.setTitleColor(UIColor.white, for: .selected)
                self.myProfileTagButton.backgroundColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
            } else {
                self.myProfileTagButton.isSelected = false
                self.myProfileTagButton.setTitleColor(.gray777, for: .normal)
                self.myProfileTagButton.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
                self.myProfileTagButton.backgroundColor = UIColor.white
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setLayoutInit()
    }
    
    private func setLayoutInit() {
        self.myProfileTagButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        self.myProfileTagButton.titleLabel?.textAlignment = .left
        self.myProfileTagButton.layer.borderWidth = 1
        self.myProfileTagButton.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
        self.myProfileTagButton.layer.cornerRadius = 14
        self.myProfileTagButton.setTitleColor( UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.0), for: .normal)
        self.myProfileTagButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 15, bottom: 6, right: 15)
        self.myProfileTagButton.setContentHuggingPriority(.defaultLow, for: .horizontal)
        self.myProfileTagButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        self.myProfileTagButton.layer.masksToBounds = true
        self.contentView.isUserInteractionEnabled = false
    }

}
