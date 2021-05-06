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
        
        self.exclamationImage.tintColor = UIColor(white: 153.0 / 255.0, alpha: 1.0)
        self.explanationLabel.textColor = UIColor(white: 119.0 / 255.0, alpha: 1.0)
    }
    
}
