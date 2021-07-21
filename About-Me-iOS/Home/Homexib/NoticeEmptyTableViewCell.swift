//
//  NoticeEmptyTableViewCell.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/07/21.
//

import UIKit

class NoticeEmptyTableViewCell: UITableViewCell {
    @IBOutlet weak var noticeEmptyImage: UIImageView!
    @IBOutlet weak var noticeEmptyContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setInitLayout()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setInitLayout() {
        self.noticeEmptyContent.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        self.noticeEmptyContent.textColor = .gray777
        self.noticeEmptyContent.textAlignment = .center
        self.noticeEmptyContent.text = "알림 내역이 없습니다."
    }
    
}
