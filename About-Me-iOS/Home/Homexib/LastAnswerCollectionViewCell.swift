//
//  LastAnswerCollectionViewCell.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/05/06.
//

import UIKit

class LastAnswerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var answerContainerView: UIView!
    @IBOutlet weak var answerCharacterLabel: UILabel!
    @IBOutlet weak var answerRankLabel: UILabel!
    @IBOutlet weak var answerQuestionLabel: UILabel!
    @IBOutlet weak var answerEditButton: UIButton!
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
        self.answerQuestionLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.answerQuestionLabel.textAlignment = .left
        self.answerRankLabel.layer.borderWidth = 1
        self.answerRankLabel.layer.borderColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1.0).cgColor
        self.answerRankLabel.layer.cornerRadius = 3
        self.answerRankLabel.layer.masksToBounds = true
        self.answerRankLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.answerRankLabel.font = UIFont(name: "GmarketSansMedium", size: 11)
        self.answerCharacterLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
        self.answerRankLabel.textAlignment = .center
        self.answerEditButton.setImage(UIImage(named: "Edit.png"), for: .normal)
    }
}
