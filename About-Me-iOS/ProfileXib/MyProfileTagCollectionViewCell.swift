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
                self.myProfileTagButton.setTitleColor(UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0), for: .selected)
                self.myProfileTagButton.backgroundColor = UIColor.white
            } else {
                self.myProfileTagButton.isSelected = false
                self.myProfileTagButton.setTitleColor(UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.0), for: .normal)
            }
            self.myProfileTagButton.layer.borderColor = isSelected ? UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0).cgColor :  UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
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
        self.myProfileTagButton.layer.cornerRadius = 10
        self.myProfileTagButton.setTitleColor( UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.0), for: .normal)
        self.myProfileTagButton.layer.masksToBounds = true
        self.contentView.isUserInteractionEnabled = false
    }

}
