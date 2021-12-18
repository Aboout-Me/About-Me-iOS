//
//  AdminBlockViewController.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/12/18.
//

import UIKit

class AdminBlockViewController: UIViewController {
    
    @IBOutlet weak var adminBackgroundImageView: UIImageView!
    @IBOutlet weak var adminContainerView: UIView!
    @IBOutlet weak var adminBlockContentTitle: UILabel!
    @IBOutlet weak var adminBlockTagView: UIView!
    @IBOutlet weak var adminBlockTagTitle: UILabel!
    @IBOutlet weak var adminBlockLineView: UIView!
    @IBOutlet weak var adminBlockTextView: UITextView!
    @IBOutlet weak var adminRejectButton: UIButton!
    @IBOutlet weak var adminConfirmButton: UIButton!
    var adminDetailInfo:AdminBlockModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayoutInit()
    }
    
    
    func setLayoutInit() {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationItem.backButtonTitle = ""
        adminContainerView.layer.cornerRadius = 10
        adminBlockContentTitle.text = adminDetailInfo?.title ?? "신고신고신고신고신고신고신고신고"
        adminBlockContentTitle.font = UIFont(name: "GmarketSansMedium", size: 20)
        adminBlockTagTitle.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
        adminBlockTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        adminBlockTextView.textAlignment = .left
        adminBlockTagView.layer.cornerRadius = 3
        adminRejectButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        adminRejectButton.layer.borderColor = UIColor.black.cgColor
        adminRejectButton.layer.borderWidth = 1
        adminRejectButton.layer.cornerRadius = 5
        adminConfirmButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        adminConfirmButton.layer.cornerRadius = 5
        adminConfirmButton.backgroundColor = .gray333
        adminBlockTextView.isEditable = false
        adminBlockTextView.isSelectable = false
        if adminDetailInfo?.color == "red" {
            adminBackgroundImageView.image = UIImage(named: "img_background_red")
            adminBlockTagView.backgroundColor = .primaryRed
            adminBlockTagTitle.text = "열정충만"
        } else if adminDetailInfo?.color == "yellow" {
            adminBackgroundImageView.image = UIImage(named: "img_background_yellow")
            adminBlockTagView.backgroundColor = .primaryYellow
            adminBlockTagTitle.text = "소소한일상"
        } else if adminDetailInfo?.color == "green" {
            adminBackgroundImageView.image = UIImage(named: "img_background_green")
            adminBlockTagView.backgroundColor = .primaryGreen
            adminBlockTagTitle.text = "기억상자"
        } else if adminDetailInfo?.color == "pink" {
            adminBackgroundImageView.image = UIImage(named: "img_background_pink")
            adminBlockTagView.backgroundColor = .primaryPink
            adminBlockTagTitle.text = "관계의미학"
        } else {
            adminBackgroundImageView.image = UIImage(named: "img_background_purple")
            adminBlockTagView.backgroundColor = .primaryPurple
            adminBlockTagTitle.text = "상상플러스"
        }
    }
    
    
}
