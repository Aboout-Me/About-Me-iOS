//
//  AdvisoryWriteAnswerViewController.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/04/07.
//

import UIKit

class AdvisoryWriteAnswerViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var questionNumber = 1
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        self.questionLabel.text = "\(self.questionNumber)단계 질문..!"
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = self.doneButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -50)
        let rightConstraint = self.doneButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 50)
        
        if self.questionNumber == 10 {
            self.nextButton.isHidden = true
            leftConstraint.isActive = false
            rightConstraint.isActive = true
        } else {
            rightConstraint.isActive = false
            leftConstraint.isActive = true
            
            self.nextButton.isHidden = false
            self.nextButton.addTarget(self, action: #selector(self.nextButtonDidTap(_:)),
                                      for: .touchUpInside)
        }
    }
    
    // MARK: - Selectors
    
    @objc
    private func nextButtonDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let questionVC = storyboard.instantiateViewController(withIdentifier: "AdvisoryQuestionVC")
                as? AdvisoryQuestionViewController else { return }
        questionVC.questionNumber = self.questionNumber + 1
//        self.present(questionVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(questionVC, animated: true)
    }

}
