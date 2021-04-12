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
        self.nextButton.addTarget(self, action: #selector(self.nextButtonDidTap(_:)),
                                              for: .touchUpInside)
    }
    
    // MARK: - Selectors
    
    @objc
    private func nextButtonDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let questionVC = storyboard.instantiateViewController(withIdentifier: "AdvisoryQuestionVC")
                as? AdvisoryQuestionViewController else { return }
        questionVC.questionNumber = self.questionNumber + 1
        self.navigationController?.pushViewController(questionVC, animated: true)
    }

}
