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
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
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
    
    @IBOutlet weak var roundView: UIView!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleTextView: UITextView!
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var limitLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
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
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.roundView.roundCorners([.topLeft, .topRight], radius: 20)
        self.navigationController?.isNavigationBarHidden = true
        
        self.levelLabel.text = "\(self.questionNumber)/10 단계"
        
        self.titleTextView.delegate = self
        self.questionTextView.delegate = self
        self.answerTextView.delegate = self
        
        self.closeButton.addTarget(self, action: #selector(closeButtonDidTap(_:)),
                                   for: .touchUpInside)
        self.saveButton.addTarget(self, action: #selector(saveButtonDidTap(_:)),
                                  for: .touchUpInside)
        
        self.titleTextView.centerVertically()
        self.questionTextView.centerVertically()
        
        if self.advisoryTitle != "" {
            self.titleTextView.text = self.advisoryTitle
        }
        
        if let str = self.questionDictionary[self.questionNumber] {
            self.questionTextView.text = str
        }
        
        if let str = self.answerDictionary[self.questionNumber] {
            self.answerTextView.text = str
            self.answerTextView.textColor = .black
            let attributedString = NSMutableAttributedString()
            attributedString.append(NSAttributedString(string: "\(str.count)",
                                                       attributes: [.foregroundColor: UIColor.black]))
            attributedString.append(NSAttributedString(string: "/500",
                                                       attributes: [.foregroundColor: UIColor.lightGray]))
            self.limitLabel.attributedText = attributedString
        } else {
            self.answerTextView.text = "답변을 적어주세요 :)"
            self.answerTextView.textColor = .systemGray3
        }
        
        for view in buttonView.subviews{
            view.removeFromSuperview()
        }
        
        if self.questionNumber == 1 {
            let nextButton = CustomButton(text: "다음")
            self.view.addSubview(nextButton)
            
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            nextButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 20).isActive = true
            nextButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -20).isActive = true
            nextButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor).isActive = true
            
            nextButton.addTarget(self, action: #selector(nextButtonDidTap(_:)), for: .touchUpInside)
        } else if self.questionNumber == 10 {
            let previousButton = CustomButton(text: "이전")
            self.view.addSubview(previousButton)
            
            previousButton.translatesAutoresizingMaskIntoConstraints = false
            previousButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 20).isActive = true
            previousButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -20).isActive = true
            previousButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor).isActive = true
            
            previousButton.addTarget(self, action: #selector(previousButtonDidTap(_:)), for: .touchUpInside)
        } else {
            let nextButton = CustomButton(text: "다음")
            self.view.addSubview(nextButton)
            
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            nextButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor).isActive = true
            
            nextButton.addTarget(self, action: #selector(nextButtonDidTap(_:)), for: .touchUpInside)
            
            let previousButton = CustomButton(text: "이전")
            self.view.addSubview(previousButton)
            
            previousButton.translatesAutoresizingMaskIntoConstraints = false
            previousButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor).isActive = true
            
            previousButton.addTarget(self, action: #selector(previousButtonDidTap(_:)), for: .touchUpInside)
            
            nextButton.widthAnchor.constraint(equalTo: previousButton.widthAnchor).isActive = true
            previousButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 20).isActive = true
            nextButton.leadingAnchor.constraint(equalTo: previousButton.trailingAnchor, constant: 20).isActive = true
            nextButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -20).isActive = true
        }
    }
    
    // MARK: - Selectors
    
    @objc
    private func closeButtonDidTap(_ sender: UIButton) {
        let alert = UIAlertController(title: "작성중인 내용을\n완료하지 않고 나가시겠습니까?", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "아니오", style: .default, handler: nil)
        
        let quitAction = UIAlertAction(title: "네", style: .destructive) { _ in
            self.closeViewControllers()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(quitAction)
        present(alert, animated: false, completion: nil)
    }
    
    @objc
    private func saveButtonDidTap(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "글을 저장하시겠어요?", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "아니오", style: .default, handler: nil)
        
        let quitAction = UIAlertAction(title: "네", style: .destructive) { _ in
            let answerList = self.makeAnswerTemplate()
            AdvisoryApiService.saveAdvisoryAnswerList(answerList: answerList) {
                self.closeViewControllers()
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(quitAction)
        present(alert, animated: false, completion: nil)
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
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            
            self.bottomConstraint.constant = keyboardHeight
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        self.bottomConstraint.constant = 0
        self.view.layoutIfNeeded()
    }
    
    // MARK: - Helpers
    
    private func tempDataWillSave() {
        self.advisoryTitle = self.titleTextView.text ?? ""
        
        if limitLabel.text != "0/500" {
            guard let question = self.questionTextView.text else { return }
            questionDictionary[self.questionNumber] = question
            
            guard let answer = answerTextView.text else { return }
            answerDictionary[self.questionNumber] = answer
        }
    }
    
    private func closeViewControllers() {
        self.navigationController?.isNavigationBarHidden = false
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        
        self.navigationController?.popToViewController(
            viewControllers[viewControllers.count - self.questionNumber - 1], animated: false)
    }
    
    private func makeAnswerTemplate() -> AdvisoryPostList {
        var answerLists: [AnswerList] = []
        
        for (key, value) in questionDictionary {
            if value != "", let answer = answerDictionary[key], answer != "" {
                answerLists.append(AnswerList(level: key, question: value, answer: answer))
            }
        }
        
        return AdvisoryPostList(user: 1, stage: 1, theme: advisoryTitle, answerLists: answerLists)
    }
    
}

extension AdvisoryQuestionViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let attributedString = NSMutableAttributedString()
        
        if textView.text.count == 0 {
            attributedString.append(NSAttributedString(string: "0/500",
                                                       attributes: [.foregroundColor: UIColor.lightGray]))
        } else {
            attributedString.append(NSAttributedString(string: "\(textView.text.count)",
                                                       attributes: [.foregroundColor: UIColor.black]))
            attributedString.append(NSAttributedString(string: "/500",
                                                       attributes: [.foregroundColor: UIColor.lightGray]))
        }
        
        self.limitLabel.attributedText = attributedString
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let str = textView.text else { return true }
        let newLength = str.count + text.count - range.length
        return newLength <= 500
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.systemGray3 {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "답변을 적어주세요 :)"
            textView.textColor = UIColor.systemGray3
        }
    }
}

extension UITextView {
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}
