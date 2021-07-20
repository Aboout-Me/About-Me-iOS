//
//  NoticeTableViewCell.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/07/20.
//

import UIKit

class NoticeTableViewCell: UITableViewCell {

    @IBOutlet weak var noticeCotainerView: UIView!
    @IBOutlet weak var noticeImageView: UIImageView!
    @IBOutlet weak var noticeContentLabel: UILabel!
    @IBOutlet weak var noticeDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setInitLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setInitLayout() {
        self.noticeCotainerView.clipsToBounds = true
        self.noticeCotainerView.layer.cornerRadius = self.noticeCotainerView.frame.width / 2
        self.noticeContentLabel.textColor = .gray333
        self.noticeContentLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        self.noticeContentLabel.textAlignment = .left
        self.noticeContentLabel.numberOfLines = 2
        self.noticeDateLabel.textColor = .gray999
        self.noticeDateLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        self.noticeDateLabel.textAlignment = .left
    }
    
}
