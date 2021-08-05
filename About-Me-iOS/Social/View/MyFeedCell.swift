//
//  MyFeedCell.swift
//  오늘의 나
//
//  Created by Hyeyeon Lee on 2021/07/07.
//

import UIKit

class MyFeedCell: UICollectionViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var levelView: UIView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    var closure: (() -> Void)?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10
        levelView.layer.borderWidth = 1
        levelView.layer.borderColor = UIColor.gray555.cgColor
        levelView.layer.cornerRadius = 3
        tagView.layer.cornerRadius = 3
    }

    // MARK: - Selectors
    
    @IBAction func moreButtonDidTap(_ sender: Any) {
        self.closure?()
    }
    
}
