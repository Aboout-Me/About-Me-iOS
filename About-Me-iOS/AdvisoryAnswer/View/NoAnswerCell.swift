//
//  NoAnswerCell.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/04/29.
//

import UIKit

class NoAnswerCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var exclamationImage: UIImageView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.exclamationImage.tintColor = .gray999
        self.explanationLabel.textColor = .gray777
        self.explanationLabel.font = UIFont(name: "GmarketSansMedium", size: 15)
    }
    
}
