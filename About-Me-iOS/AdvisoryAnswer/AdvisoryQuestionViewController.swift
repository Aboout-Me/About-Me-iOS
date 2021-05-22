//
//  AdvisoryQuestionViewController.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/04/07.
//

import UIKit

class CustomButton: UIButton {
    
    enum ButtonType {
        case black
        case white
    }
    
    init(text: String, type: ButtonType) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        layer.cornerRadius = 5
        setTitle(text, for: .normal)
        layer.cornerRadius = 5
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        if type == .black {
            setTitleColor(.white, for: .normal)
            backgroundColor = .black
        } else {
            setTitleColor(.black, for: .normal)
            backgroundColor = .white
            layer.borderWidth = 1
            layer.borderColor = UIColor.black.cgColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol AdvisoryDelegate: AnyObject {
    func saveButtonDidTap(completion: @escaping () -> Void)
    func closeViewControllersDelegate()
}

class AdvisoryQuestionViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var navigationView: UIView!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var limitLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var answerPlaceholderLabel: UILabel!
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var questionNumber = 1
    
    var advisoryBeforeTitle = ""
    var advisoryTitle = ""
    var questionDictionary: [Int: String] = [:]
    var answerDictionary: [Int: String] = [:]
    

    enum Mode {
        case new
        case ongoing
    }
    
    var mode: Mode = .new
    var editList: [Int] = []
    var stage: Int = 0
    var stackNumber = 1
    

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
        
        self.titleTextField.delegate = self
        self.questionTextField.delegate = self
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
            self.answerTextView.textColor = .black
            let attributedString = NSMutableAttributedString()
            attributedString.append(NSAttributedString(string: "\(str.count)",
                                                       attributes: [.foregroundColor: UIColor.black]))
            attributedString.append(NSAttributedString(string: "/500",
                                                       attributes: [.foregroundColor: UIColor.lightGray]))
            self.limitLabel.attributedText = attributedString
        }
        
        for view in buttonView.subviews{
            view.removeFromSuperview()
        }
        
        if self.questionNumber == 1 {
            let nextButton = CustomButton(text: "다음", type: .black)
            self.view.addSubview(nextButton)
            
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            nextButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 20).isActive = true
            nextButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -20).isActive = true
            nextButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor).isActive = true
            
            nextButton.addTarget(self, action: #selector(nextButtonDidTap(_:)), for: .touchUpInside)
        } else if self.questionNumber == 10 {
            let previousButton = CustomButton(text: "이전", type: .white)
            self.view.addSubview(previousButton)
            
            previousButton.translatesAutoresizingMaskIntoConstraints = false
            previousButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor, constant: 20).isActive = true
            previousButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor, constant: -20).isActive = true
            previousButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor).isActive = true
            
            previousButton.addTarget(self, action: #selector(previousButtonDidTap(_:)), for: .touchUpInside)
        } else {
            let nextButton = CustomButton(text: "다음", type: .black)
            self.view.addSubview(nextButton)
            
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            nextButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor).isActive = true
            
            nextButton.addTarget(self, action: #selector(nextButtonDidTap(_:)), for: .touchUpInside)
            
            let previousButton = CustomButton(text: "이전", type: .white)
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
        let bottomSheet = BottomSheetView(nibName: "BottomSheetView", bundle: nil)
        bottomSheet.modalPresentationStyle = .overCurrentContext
        bottomSheet.mode = .saveAdvisory
        bottomSheet.delegate = self
        
        self.present(bottomSheet, animated: true, completion: nil)
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
        questionVC.stackNumber = self.stackNumber + 1
        questionVC.advisoryBeforeTitle = self.advisoryBeforeTitle
        questionVC.mode = self.mode
        questionVC.stage = self.stage
        questionVC.editList = self.editList
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
        questionVC.stackNumber = self.stackNumber + 1
        questionVC.advisoryBeforeTitle = self.advisoryBeforeTitle
        questionVC.mode = self.mode
        questionVC.stage = self.stage
        questionVC.editList = self.editList
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
        self.advisoryTitle = self.titleTextField.text ?? ""
        
        if limitLabel.text != "0/500" {
            guard let question = self.questionTextField.text else { return }
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
            if value != "", let answer = answerDictionary[key], answer != "", !self.editList.contains(key) {
                answerLists.append(AnswerList(level: key, question: value, answer: answer))
            }
        }
        
        return AdvisoryPostList(user: 1, stage: 1, theme: advisoryTitle, answerLists: answerLists)
    }
    
    private func makeUpdateTemplate(level: Int) -> AdvisoryUpdateList {
        let answerList = AnswerList(level: level, question: questionDictionary[level]!, answer: answerDictionary[level]!)
        return AdvisoryUpdateList(user: 1, stage: self.stage, theme: advisoryBeforeTitle, theme_new: advisoryTitle, answerLists: [answerList])
    }
    
}

extension AdvisoryQuestionViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let attributedString = NSMutableAttributedString()
        
        if textView.text.count == 0 {
            self.answerPlaceholderLabel.isHidden = false
            attributedString.append(NSAttributedString(string: "0/500",
                                                       attributes: [.foregroundColor: UIColor.lightGray]))
        } else {
            self.answerPlaceholderLabel.isHidden = true
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
}

extension AdvisoryQuestionViewController: UITextFieldDelegate {
    
}

extension AdvisoryQuestionViewController: AdvisoryDelegate {
    func saveButtonDidTap(completion: @escaping () -> Void) {
        let answerList = self.makeAnswerTemplate()
        AdvisoryApiService.saveAdvisoryAnswerList(answerList: answerList) {
            completion()
        self.tempDataWillSave()
        
        if self.mode == .ongoing {
            for level in editList {
                print("======\(level)=======")
                let template = self.makeUpdateTemplate(level: level)
                
                print(template)
                AdvisoryApiService.updateOneAdvisoryAnswer(answerList: template) {
//                    completion()
                }
            }
            
            let answerList = self.makeAnswerTemplate()
            print(answerList)
            AdvisoryApiService.saveAdvisoryAnswerList(answerList: answerList) {
                completion()
            }
        } else {
            let answerList = self.makeAnswerTemplate()
            print(answerList)
            
            AdvisoryApiService.saveAdvisoryAnswerList(answerList: answerList) {
                completion()
            }

        }
    }
    
    func closeViewControllersDelegate() {
        self.closeViewControllers()
    }
}
