//
//  SocialCommentCell.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/06/02.
//

import UIKit

class SocialCommentCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.roundView.layer.cornerRadius = 25
    }
    
    // MARK: - Selectors
    
    @IBAction func moreButtonDidTap(_ sender: Any) {
        print("tap")
    }
    
}
