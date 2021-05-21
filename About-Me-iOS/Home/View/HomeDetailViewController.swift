//
//  HomeDetailViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/14.
//

import UIKit
import Hero


class HomeDetailViewController: UIViewController {
    
    @IBOutlet weak var detailTitleLabel: UILabel!
    public var questionTitle: String = ""
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setLayoutInit()
    }
    
    private func setLayoutInit() {
        self.detailTitleLabel.font = UIFont(name: "Roboto-Regular", size: 16)
        self.detailTitleLabel.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.detailTitleLabel.text = "Q. \(self.questionTitle)"
    }
}
