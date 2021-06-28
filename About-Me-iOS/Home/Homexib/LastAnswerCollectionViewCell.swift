//
//  LastAnswerCollectionViewCell.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/05/06.
//

import UIKit

class LastAnswerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var answerContainerView: UIView!
    @IBOutlet weak var answerCharacterView: UIView!
    @IBOutlet weak var answerRankView: UIView!
    @IBOutlet weak var answerCharacterLabel: UILabel!
    @IBOutlet weak var answerMoreView: UIView!
    @IBOutlet weak var answerRankLabel: UILabel!
    @IBOutlet weak var answerContentLabel: UILabel!
    @IBOutlet weak var answerQuestionLabel: UILabel!
    @IBOutlet weak var answerEditButton: UIButton!
    public var editButtonClousr: (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setLayoutInit()
    }

    private func setLayoutInit() {
        self.answerContainerView.backgroundColor = .white
        self.answerContainerView.layer.cornerRadius = 15
        self.answerContainerView.layer.masksToBounds = true
        self.answerQuestionLabel.font = UIFont(name: "GmarketSansMedium", size: 16)
        self.answerQuestionLabel.textColor = UIColor.gray333
        self.answerQuestionLabel.textAlignment = .left
        self.answerQuestionLabel.lineBreakMode = .byTruncatingTail
        self.answerRankLabel.textColor = UIColor.gray333
        self.answerRankLabel.font = UIFont(name: "GmarketSansMedium", size: 11)
        self.answerCharacterLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
        self.answerEditButton.setImage(UIImage(named: "Edit.png"), for: .normal)
        self.answerCharacterView.layer.masksToBounds = true
        self.answerCharacterView.layer.cornerRadius = 3
        self.answerRankView.layer.borderWidth = 1
        self.answerRankView.layer.borderColor = UIColor.gray555.cgColor
        self.answerRankView.layer.masksToBounds = true
        self.answerRankView.layer.cornerRadius = 5
        self.answerContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        self.answerContentLabel.textColor = UIColor.gray333
        self.answerContentLabel.numberOfLines = 3
        self.answerContentLabel.textAlignment = .left
        self.answerContentLabel.lineBreakMode = .byTruncatingTail
        self.answerEditButton.addTarget(self, action: #selector(EditButtonDidTap(_:)), for: .touchUpInside)
    }
    
    @objc
    private func EditButtonDidTap(_ sender: UIButton) {
        editButtonClousr!()
    }
    
}
