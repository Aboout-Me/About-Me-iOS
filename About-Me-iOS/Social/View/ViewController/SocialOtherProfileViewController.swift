//
//  SocialOtherProfileViewController.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/07/03.
//

import UIKit

class SocialOtherProfileViewController: UIViewController {
    

    @IBOutlet weak var socialDetailPushButton: UIButton!
    @IBOutlet weak var socialCharacterNicknameLabel: UILabel!
    @IBOutlet weak var socialCharacterImageView: UIImageView!
    @IBOutlet weak var socialCharacterImageContentView: UIView!
    @IBOutlet weak var socialUserNicknameLabel: UILabel!
    @IBOutlet weak var socialBackgroundImageView: UIImageView!
    @IBOutlet weak var socialContentView: UIView!
    @IBOutlet weak var socialFirstTagView: UIView!
    @IBOutlet weak var socialSecondTagView: UIView!
    @IBOutlet weak var socialThirdTagView: UIView!
    @IBOutlet weak var socialFirstTagLabel: UILabel!
    @IBOutlet weak var socialSecondTagLabel: UILabel!
    @IBOutlet weak var socialThirdTagLabel: UILabel!
    @IBOutlet weak var socialUserContentLabel: UILabel!
    @IBOutlet weak var socialUserNicknameContentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitLayout()
    }
    
    private func setInitLayout() {
        self.socialContentView.layer.cornerRadius = 25
        self.socialContentView.clipsToBounds = true
    }
}
