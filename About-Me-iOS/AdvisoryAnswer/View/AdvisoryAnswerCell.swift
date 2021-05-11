//
//  AdvisoryAnswerCell.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/04/29.
//

import UIKit

class AdvisoryAnswerCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var finishView: UIImageView!
    @IBOutlet weak var stageLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var borderView: UIView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLabel.textColor = UIColor(white: 34.0 / 255.0, alpha: 1.0)
        self.titleLabel.font = UIFont(name: "GmarketSansMedium", size: 18)
        self.finishView.tintColor = UIColor(white: 34.0 / 255.0, alpha: 1.0)
        self.stageLabel.textColor = UIColor(white: 34.0 / 255.0, alpha: 1.0)
        self.stageLabel.font = UIFont(name: "GmarketSansMedium", size: 15)
        self.createdLabel.textColor = UIColor(white: 153.0 / 255.0, alpha: 1.0)
        self.createdLabel.font = UIFont(name: "GmarketSansMedium", size: 13)
        
        self.borderView.layer.borderWidth = 0.5
        self.borderView.layer.borderColor = UIColor(white: 221.0 / 255.0, alpha: 1.0).cgColor
        self.borderView.layer.cornerRadius = 5
    }
    
}
