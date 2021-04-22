//
//  AdvisoryQuestionViewController.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/04/07.
//

import UIKit

class CustomButton: UIButton {
    
    init(text: String) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        layer.cornerRadius = 5
        backgroundColor = .lightGray
        setTitle(text, for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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
    
    @IBOutlet weak var buttonView: UIView!
    
    var questionNumber = 1
    
    var advisoryTitle = ""
    var questionDictionary: [Int: String] = [:]
    var answerDictionary: [Int: String] = [:]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        self.navigationController?.isNavigationBarHidden = true
        
        self.levelLabel.text = "\(self.questionNumber)/10 단계"
        self.questionLabel.text = "질문 \(self.questionNumber)단계"
        
        self.answerTextView.delegate = self
        
        self.closeButton.addTarget(self, action: #selector(closeButtonDidTap(_:)),
                                   for: .touchUpInside)
        self.saveButton.addTarget(self, action: #selector(saveButtonDidTap(_:)),
                                  for: .touchUpInside)
        
        if self.advisoryTitle != "" {
            self.titleTextField.text = self.advisoryTitle
        }
        
        if let str = self.questionDictionary[self.questionNumber] {
            self.questionTextField.text = str
        }
        
        if let str = self.answerDictionary[self.questionNumber] {
            self.answerTextView.text = str
            self.limitLabel.text = "\(str.count)/500자"
        }
        
        for view in buttonView.subviews{
            view.removeFromSuperview()
        }
        
        if self.questionNumber == 1 {
            let nextButton = CustomButton(text: "다음")
            self.view.addSubview(nextButton)
            
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            nextButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor).isActive = true
            nextButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor).isActive = true
            
            nextButton.addTarget(self, action: #selector(nextButtonDidTap(_:)), for: .touchUpInside)
        } else if self.questionNumber == 10 {
            let previousButton = CustomButton(text: "이전")
            self.view.addSubview(previousButton)
            
            previousButton.translatesAutoresizingMaskIntoConstraints = false
            previousButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor).isActive = true
            previousButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor).isActive = true
            
            previousButton.addTarget(self, action: #selector(previousButtonDidTap(_:)), for: .touchUpInside)
        } else {
            let nextButton = CustomButton(text: "다음")
            self.view.addSubview(nextButton)
            
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            nextButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor, constant: 75).isActive = true
            nextButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor).isActive = true
            
            nextButton.addTarget(self, action: #selector(nextButtonDidTap(_:)), for: .touchUpInside)
            
            let previousButton = CustomButton(text: "이전")
            self.view.addSubview(previousButton)
            
            previousButton.translatesAutoresizingMaskIntoConstraints = false
            previousButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor, constant: -75).isActive = true
            previousButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor).isActive = true
            
            previousButton.addTarget(self, action: #selector(previousButtonDidTap(_:)), for: .touchUpInside)
        }
    }
    
    // MARK: - Selectors
    
    @objc
    private func closeButtonDidTap(_ sender: UIButton) {
        let alert = UIAlertController(title: "작성된 내용이 저장되지 않습니다.", message: "나가시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "머물러 있기", style: .default, handler: nil)
        
        let quitAction = UIAlertAction(title: "나가기", style: .destructive) { _ in
            self.closeViewControllers()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(quitAction)
        present(alert, animated: false, completion: nil)
    }
    
    @objc
    private func saveButtonDidTap(_ sender: UIButton) {
        
        // SAVE
        
        self.closeViewControllers()
    }
    
    @objc
    private func previousButtonDidTap(_ sender: UIButton) {
        tempDataWillSave()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let questionVC = storyboard.instantiateViewController(withIdentifier: "AdvisoryQuestionVC")
                as? AdvisoryQuestionViewController else { return }
                
        questionVC.questionNumber = self.questionNumber - 1
        questionVC.advisoryTitle = self.advisoryTitle
        questionVC.questionDictionary = self.questionDictionary
        questionVC.answerDictionary = self.answerDictionary
        self.navigationController?.pushViewController(questionVC, animated: false)
    }
    
    @objc
    private func nextButtonDidTap(_ sender: UIButton) {
        tempDataWillSave()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let questionVC = storyboard.instantiateViewController(withIdentifier: "AdvisoryQuestionVC")
                as? AdvisoryQuestionViewController else { return }
        
        questionVC.questionNumber = questionNumber + 1
        questionVC.advisoryTitle = self.advisoryTitle
        questionVC.questionDictionary = self.questionDictionary
        questionVC.answerDictionary = self.answerDictionary
        self.navigationController?.pushViewController(questionVC, animated: false)
    }
    
    // MARK: - Helpers
    
    private func tempDataWillSave() {
        self.advisoryTitle = self.titleTextField.text ?? ""
        
        guard let question = questionTextField.text else { return }
        questionDictionary[self.questionNumber] = question
        
        guard let answer = answerTextView.text else { return }
        answerDictionary[self.questionNumber] = answer
    }
    
    private func closeViewControllers() {
        self.navigationController?.isNavigationBarHidden = false
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        
        self.navigationController?.popToViewController(
            viewControllers[viewControllers.count - self.questionNumber - 1], animated: false)
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
