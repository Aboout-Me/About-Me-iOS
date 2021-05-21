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
        
        self.titleLabel.textColor = .gray333
        self.titleLabel.font = UIFont(name: "GmarketSansMedium", size: 18)
        self.finishView.tintColor = .gray333
        self.stageLabel.textColor = .gray333
        self.stageLabel.font = UIFont(name: "GmarketSansMedium", size: 15)
        self.createdLabel.textColor = .gray999
        self.createdLabel.font = UIFont(name: "GmarketSansMedium", size: 13)
        
        self.borderView.layer.borderWidth = 0.5
        self.borderView.layer.borderColor = UIColor.lineDdd.cgColor
        self.borderView.layer.cornerRadius = 5
    }
    
}
