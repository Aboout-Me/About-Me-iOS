//
//  MainCollectionViewCell.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/08.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setInitLayout()
    }
    
    public func setInitLayout() {
        self.mainContainerView.layer.borderColor = UIColor.clear.cgColor
        self.mainContainerView.layer.cornerRadius = 20
        self.mainContainerView.layer.masksToBounds = true
        self.mainContainerView.backgroundColor = UIColor(red: 255/255, green: 118/255, blue: 99/255, alpha: 1.0)
        self.mainTitleLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    }

}
