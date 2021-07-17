//
//  AdvisoryStageCell.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/17.
//

import UIKit

class AdvisoryStageCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var ongoingView: UIView!
    @IBOutlet weak var stageLabel: UILabel!
    @IBOutlet weak var answerContentView: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    var answer: AdvisoryAnswerList?
    var totalCount: Int?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configure()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        self.backgroundColor = .solidF9F9F9
        self.answerContentView.layer.cornerRadius = 10
        self.answerContentView.layer.borderColor = UIColor.lineEee.cgColor
        self.answerContentView.layer.borderWidth = 1
        self.shadowView.layer.shadowOffset = CGSize(width: 3, height: 0.5)
        self.shadowView.layer.shadowRadius = 10
        self.shadowView.layer.shadowOpacity = 0.2
    }
    
    func setValues(answer: AdvisoryAnswerList, totalCount: Int) {
        self.answer = answer
        self.totalCount = totalCount
        
        let nowLevel = answer.levels.dropLast(2)
        if Int(String(nowLevel))! == 10 {
            checkImageView.image = UIImage(named: "checked_solid.png")
            ongoingView.backgroundColor = .clear
        }
        else if Int(String(nowLevel))! == totalCount {
            checkImageView.image = UIImage(named: "confirm.png")
            ongoingView.backgroundColor = .clear
        } else {
            checkImageView.image = UIImage(named: "checked_solid.png")
            ongoingView.backgroundColor = .lineCcc
        }
        
        self.stageLabel.text = answer.levels
        self.stageLabel.font = UIFont(name: "GmarketSansMedium", size: 14)
        self.stageLabel.textColor = .gray333
        
        self.questionLabel.text = answer.question
        self.answerLabel.text = answer.answer
    }
}
