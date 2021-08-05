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
        setLayoutInit()
    }

    private func setLayoutInit() {
        
        //MARK: - View
        answerContainerView.backgroundColor = .white
        answerContainerView.layer.cornerRadius = 15
        answerContainerView.layer.masksToBounds = true
        answerCharacterView.layer.masksToBounds = true
        answerCharacterView.layer.cornerRadius = 3
        answerRankView.layer.borderWidth = 1
        answerRankView.layer.borderColor = UIColor.gray555.cgColor
        answerRankView.layer.masksToBounds = true
        answerRankView.layer.cornerRadius = 5
        
        //MARK: - Label
        answerQuestionLabel.font = UIFont(name: "GmarketSansMedium", size: 16)
        answerQuestionLabel.textColor = UIColor.gray333
        answerQuestionLabel.textAlignment = .left
        answerQuestionLabel.lineBreakMode = .byTruncatingTail
        answerRankLabel.textColor = UIColor.gray333
        answerRankLabel.font = UIFont(name: "GmarketSansMedium", size: 11)
        answerCharacterLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
        answerContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        answerContentLabel.textColor = UIColor.gray333
        answerContentLabel.numberOfLines = 3
        answerContentLabel.textAlignment = .left
        answerContentLabel.lineBreakMode = .byTruncatingTail
        
        //MARK: - Button
        answerEditButton.addTarget(self, action: #selector(EditButtonDidTap(_:)), for: .touchUpInside)
        answerEditButton.setImage(UIImage(named: "Edit.png"), for: .normal)
    }
    
    //MARK: - Action
    @objc
    private func EditButtonDidTap(_ sender: UIButton) {
        editButtonClousr!()
    }
    
}
