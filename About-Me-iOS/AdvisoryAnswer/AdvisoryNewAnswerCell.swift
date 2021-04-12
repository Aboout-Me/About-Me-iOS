//
//  AdvisoryNewAnswerCell.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/04/12.
//

import UIKit

class AdvisoryNewAnswerCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var backView: UIView!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Helpers
    
    private func configure() {
        backView.layer.cornerRadius = 10
    }
    
}
