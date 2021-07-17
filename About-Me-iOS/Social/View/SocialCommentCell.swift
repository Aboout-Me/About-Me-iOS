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
    var buttonClosure: (() -> Void)?
    var color: String? {
        didSet {
            if color == "red" {
                self.iconImageView.image = UIImage(named: "CharacterRed")
            }
            else if color == "yellow" {
                self.iconImageView.image = UIImage(named: "characterYellow")
            }
            else if color == "pink" {
                self.iconImageView.image = UIImage(named: "CharacterPink")
            }
            else if color == "green" {
                self.iconImageView.image = UIImage(named: "CharacterGreen")
            }
            else if color == "violet" {
                self.iconImageView.image = UIImage(named: "CharacterVilolet")
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.roundView.layer.cornerRadius = 25
    }
    
    // MARK: - Selectors
    
    @IBAction func moreButtonDidTap(_ sender: Any) {
        buttonClosure!()
    }
    
}
