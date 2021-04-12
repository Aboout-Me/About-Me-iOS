//
//  AdvisoryQuestionViewController.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/04/07.
//

import UIKit

class AdvisoryQuestionViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var editQuestionButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var questionNumber = 1
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        self.questionNumberLabel.text = "Q\(self.questionNumber)"
        self.editQuestionButton.addTarget(self, action: #selector(self.editQuestionButtonDidTap(_:)),
                                          for: .touchUpInside)
        self.nextButton.addTarget(self, action: #selector(self.nextButtonDidTap(_:)),
                                  for: .touchUpInside)
    }
    
    // MARK: - Selectors
    
    @objc
    private func editQuestionButtonDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let editVC = storyboard.instantiateViewController(withIdentifier: "AdvisoryEditVC")
                as? AdvisoryEditViewController else { return }
        editVC.questionNumber = self.questionNumber
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    @objc
    private func nextButtonDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let writeAnswerVC = storyboard.instantiateViewController(withIdentifier: "AdvisoryWriteAnswerVC")
                as? AdvisoryWriteAnswerViewController else { return }
        writeAnswerVC.questionNumber = self.questionNumber
        self.navigationController?.pushViewController(writeAnswerVC, animated: true)
    }
}
