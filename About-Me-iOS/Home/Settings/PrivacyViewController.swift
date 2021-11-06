//
//  PrivacyViewController.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/11/06.
//

import UIKit


class PrivacyViewController: UIViewController {
    
    @IBOutlet weak var privacyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayoutInit()
    }
    
    public func setLayoutInit() {
        privacyTextView.font = UIFont(name: "AppleSDGothicNeoI-Regular", size: 16)
        privacyTextView.textColor = .black
        privacyTextView.isEditable = false
        privacyTextView.isSelectable = false
    }
        
}
