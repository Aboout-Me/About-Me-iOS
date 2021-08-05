//
//  PostBottomSheetView.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/06/29.
//

import UIKit


class PostBottomSheetView: UIView {
    
    @IBOutlet weak var postContainerView: UIView!
    @IBOutlet weak var postNavigationView: UIView!
    @IBOutlet weak var postNavigationTitleLabel: UILabel!
    @IBOutlet weak var postCancelButton: UIButton!
    @IBOutlet weak var postShareButton: UIButton!
    @IBOutlet weak var postConfirmButton: UIButton!
    @IBOutlet weak var postQuestionLabel: UILabel!
    @IBOutlet weak var postNumberLabel: UILabel!
    @IBOutlet weak var postAnswerTextView: UITextView!
    @IBOutlet weak var postLineView: UIView!
    @IBOutlet weak var postTextViewBottomConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
