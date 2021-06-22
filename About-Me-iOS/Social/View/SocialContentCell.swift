//
//  SocialContentCell.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/25.
//

import UIKit

class SocialContentCell: UICollectionViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var bookmarkButtonTapClosure: (() -> Void)?
    var likeButtonTapClosure: (() -> Void)?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Selectors
    
    @IBAction func bookmarkButtonDidTap(_ sender: Any) {
        bookmarkButtonTapClosure!()
    }
    
    @IBAction func likeButtonDidTap(_ sender: Any) {
        likeButtonTapClosure!()
    }
    
}
