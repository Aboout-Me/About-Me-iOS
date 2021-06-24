//
//  MyProfileAnswerDetailViewController.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/06/23.
//

import UIKit

class MyProfileAnswerDetailViewController: UIViewController {
    @IBOutlet weak var myProfileAnswerBackgroundImageView: UIImageView!
    @IBOutlet weak var myProfileAnswerContentBoxView: UIView!
    @IBOutlet weak var myProfileAnswerTagView: UIView!
    @IBOutlet weak var myProfileAnswerTagTitleLabel: UILabel!
    @IBOutlet weak var myProfileAnswerTitleLabel: UILabel!
    @IBOutlet weak var myProfileAnswerEditButton: UIButton!
    @IBOutlet weak var myProfileAnswerMoreView: UIView!
    @IBOutlet weak var myProfileAnswerTextView: UITextView!
    @IBOutlet weak var myProfileAnswerPageLabel: UILabel!
    @IBOutlet var myProfileBottomSheetView: MyProfileAnswerEditView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitLayout()
    }
    
    private func setInitLayout() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow-left.png"), style: .plain, target: self, action: #selector(didTapBackButton))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateString = dateFormatter.string(from: date)
        self.navigationItem.title = dateString
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18),.foregroundColor: UIColor.white]
        self.myProfileAnswerContentBoxView.layer.masksToBounds = true
        self.myProfileAnswerContentBoxView.layer.cornerRadius = 10
        self.myProfileAnswerTagView.layer.masksToBounds = true
        self.myProfileAnswerTagView.layer.cornerRadius = 3
        self.myProfileAnswerTagTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
        self.myProfileAnswerTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 20)
        let attributedString = NSMutableAttributedString(string: "1/3", attributes: [
          .font: UIFont(name: "AppleSDGothicNeo-Regular", size: 14.0)!,
          .foregroundColor: UIColor.gray999])
        attributedString.addAttributes([
          .font: UIFont(name: "AppleSDGothicNeo-Bold", size: 14.0)!,
          .foregroundColor: UIColor.gray333
        ], range: NSRange(location: 0, length: 1))
        self.myProfileAnswerPageLabel.attributedText = attributedString
        self.myProfileAnswerTextView.textAlignment = .left
        self.myProfileAnswerTextView.isScrollEnabled = false
        self.myProfileAnswerTextView.isEditable = false
        self.myProfileAnswerTextView.isSelectable = false
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        self.myProfileAnswerTextView.attributedText = NSAttributedString(string: "testtest", attributes: [.paragraphStyle: paragraphStyle,.font:UIFont(name: "AppleSDGothicNeo-Regular", size: 16),.foregroundColor:UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)])
        self.myProfileAnswerEditButton.addTarget(self, action: #selector(didTapEditButton(_:)), for: .touchUpInside)
        
    }
    
    private func setLayoutBottomSheetView() {
        let bottomSheetFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 24)
        self.myProfileBottomSheetView.cancelButton.titleLabel?.font = bottomSheetFont
        self.myProfileBottomSheetView.deleteButton.titleLabel?.font = bottomSheetFont
        self.myProfileBottomSheetView.editButton.titleLabel?.font = bottomSheetFont
        self.myProfileBottomSheetView.panGestureView.layer.masksToBounds = true
        self.myProfileBottomSheetView.panGestureView.layer.cornerRadius = 10
        
    }
    
    @objc
    private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapEditButton(_ sender: UIButton) {
        
    }
}



class MyProfileAnswerEditView: UIView {
    @IBOutlet weak var panGestureView: UIView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
