//
//  MyProfileEmptyCollectionViewCell.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/06/03.
//

import UIKit

class MyProfileEmptyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var myProfileEmptyImageView: UIImageView!
    @IBOutlet weak var myProfileEmptyTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setLayoutInit()
    }
    
    
    private func setLayoutInit() {
        self.myProfileEmptyTitleLabel.textColor = .gray777
        self.myProfileEmptyTitleLabel.textAlignment = .center
        self.myProfileEmptyTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
    }
    
    

}
