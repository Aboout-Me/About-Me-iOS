//
//  AdvisoryQuestionViewController.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/04/07.
//

import UIKit

class AdvisoryQuestionViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var limitLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextTwoButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var questionNumber = 1
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        self.levelLabel.text = "\(self.questionNumber)/10 단계"
        self.questionLabel.text = "질문 \(self.questionNumber)단계"
        
        self.answerTextView.delegate = self
        
        self.closeButton.addTarget(self, action: #selector(closeButtonDidTap(_:)),
                                   for: .touchUpInside)
        self.saveButton.addTarget(self, action: #selector(saveButtonDidTap(_:)),
                                  for: .touchUpInside)
        self.previousButton.addTarget(self, action: #selector(self.previousButtonDidTap(_:)),
                                      for: .touchUpInside)
        self.nextButton.addTarget(self, action: #selector(self.nextButtonDidTap(_:)),
                                  for: .touchUpInside)
        self.nextTwoButton.addTarget(self, action: #selector(self.nextButtonDidTap(_:)),
                                     for: .touchUpInside)
        
        if self.questionNumber == 1 {
            nextButton.isHidden = false
            previousButton.isHidden = true
            nextTwoButton.isHidden = true
        } else if self.questionNumber == 10 {
            nextButton.isHidden = true
            previousButton.isHidden = true
            nextTwoButton.isHidden = true
        } else {
            nextButton.isHidden = true
            previousButton.isHidden = false
            nextTwoButton.isHidden = false
        }
    }
    
    // MARK: - Selectors
    
    @objc
    private func closeButtonDidTap(_ sender: UIButton) {
        
    }
    
    @objc
    private func saveButtonDidTap(_ sender: UIButton) {
        
    }
    
    @objc
    private func previousButtonDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let questionVC = storyboard.instantiateViewController(withIdentifier: "AdvisoryQuestionVC")
                as? AdvisoryQuestionViewController else { return }
        //        self.navigationController?.pushViewController(questionVC, animated: true)
        questionVC.modalPresentationStyle = .fullScreen
        questionVC.questionNumber = questionNumber - 1
        self.present(questionVC, animated: false, completion: nil)
    }
    
    @objc
    private func nextButtonDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let questionVC = storyboard.instantiateViewController(withIdentifier: "AdvisoryQuestionVC")
                as? AdvisoryQuestionViewController else { return }
        //        self.navigationController?.pushViewController(questionVC, animated: true)
        questionVC.modalPresentationStyle = .fullScreen
        questionVC.questionNumber = questionNumber + 1
        self.present(questionVC, animated: false, completion: nil)
    }
    
}

extension AdvisoryQuestionViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.limitLabel.text = "\(textView.text.count)/500자"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let str = textView.text else { return true }
        let newLength = str.count + text.count - range.length
        return newLength <= 500
    }
}
