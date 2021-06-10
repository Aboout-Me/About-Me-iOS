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
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    var bookmarkButtonTapClosure: (() -> Void)?
    var likeButtonTapClosure: (() -> Void)?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backRoundView.layer.cornerRadius = 10
        tagView.layer.cornerRadius = 3
    }
    
    // MARK: - Selectors

    @IBAction func likeButtonDidTap(_ sender: Any) {
        likeButtonTapClosure!()
    }
    
    @IBAction func scrapButtonDidTap(_ sender: Any) {
        bookmarkButtonTapClosure!()
    }
    
}
