//
//  SocialMoreContentCell.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/30.
//

import UIKit

class SocialMoreContentCell: UICollectionViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var backRoundView: UIView!
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var bookmarkImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backRoundView.layer.cornerRadius = 10
        tagView.layer.cornerRadius = 3
    }

}
