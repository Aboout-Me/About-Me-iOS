//
//  AdvisoryEditViewController.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/04/08.
//

import UIKit

class AdvisoryEditViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    var questionNumber = 1
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        questionNumberLabel.text = "EDIT \(self.questionNumber)"
        
        self.cancelButton.addTarget(self, action: #selector(self.cancelButtonDidTap(_:)), for: .touchUpInside)
        self.doneButton.addTarget(self, action: #selector(self.doneButtonDidTap(_:)), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    
    @objc
    private func cancelButtonDidTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func doneButtonDidTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
