//
//  SocialSearchResponseCell.swift
//  오늘의 나
//
//  Created by Hyeyeon Lee on 2021/07/01.
//

import UIKit

class SocialSearchResponseCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var backRoundView: UIView!
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backRoundView.layer.cornerRadius = 10
        self.backRoundView.layer.borderWidth = 1
        self.backRoundView.layer.borderColor = UIColor.lineEee.cgColor
        self.tagView.layer.cornerRadius = 3
    }
    
}
