//
//  QuestionsViewController.swift
//  About-Me-iOS
//
//  Created by Apple on 2021/05/27.
//
import Alamofire
import UIKit

class QuestionsViewController: UIViewController {
    
    @IBOutlet weak var chooseQuestionsButton: UIButton!
    @IBOutlet weak var questionContents: UITextView!
    @IBOutlet weak var submissionButton: UIButton!
    @IBOutlet weak var chooseQuestionsLabel: UILabel!
    
    var flag: Int = 0
    
    var panGestureRecognizer: UIPanGestureRecognizer?
    var originalPosition: CGPoint?
    var currentPositionTouched: CGPoint?
    
    var questionFlag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        view.addGestureRecognizer(panGestureRecognizer!)
        
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ArrowLeft"), style: .plain, target: self, action: #selector(questionBackButtonDidTapped))
        let navigationApp = UINavigationBarAppearance()
        navigationApp.configureWithTransparentBackground()
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationController?.navigationBar.standardAppearance = navigationApp
        self.navigationItem.title = "문의하기"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18)!,NSAttributedString.Key.foregroundColor : UIColor.gray333]
        
        chooseQuestionsButton.layer.borderWidth = 0.25
        chooseQuestionsButton.layer.borderColor = UIColor.lightGray.cgColor
        chooseQuestionsButton.layer.cornerRadius = 5.0;
        chooseQuestionsButton.backgroundColor = UIColor.white
        
        submissionButton.layer.cornerRadius = 5.0
        
        questionContents.layer.borderWidth = 0.25
        questionContents.layer.borderColor = UIColor.lightGray.cgColor
        questionContents.layer.cornerRadius = 5.0;
        questionContents.backgroundColor = UIColor.white
        
        questionContents.delegate = self
        
        questionContentsSetupView()
        questionContentsIsEmpty()
        submissionButtonisEnabled()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }

    
    @IBAction func chooseQuestionsButtonDidTapped(_ sender: Any) {
        let questionsListVC = QuestionsListViewController(nibName: "QuestionsListViewController", bundle: nil)
        questionsListVC.modalPresentationStyle = .overCurrentContext
        
        questionsListVC.closeClosure = { number in
            if number == 0 {
                self.chooseQuestionsLabel.text = "서비스 관련 문의"
                self.flag = 0
            }
            else if number == 1 {
                self.chooseQuestionsLabel.text = "신고 관련 문의"
                self.flag = 1
            }
            else if number == 2 {
                self.chooseQuestionsLabel.text = "광고 제휴 문의"
                self.flag = 2
            }
            else {
                self.chooseQuestionsLabel.text = "기타"
                self.flag = 3
            }
        }
        questionsListVC.flag = self.flag
        self.present(questionsListVC, animated: true, completion: nil)
    }
    
    @IBAction func submissionButtonDidTapped(_ sender: Any) {
        let paramters: Parameters = [ //Parameter : ServerAPI Request Param
            "message" : "\(questionContents.text!)",
            "reasonNum" : 7 + flag,
            "userId" : USER_ID
        ]
        SettingApiService.postSendInquire(parameter: paramters) { result in
            if case let .success(data) = result, let list = data {
                print(list.reasonNum)
                print(list.message)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: view)
        
        if panGesture.state == .began {
            originalPosition = view.center
            currentPositionTouched = panGesture.location(in: view)
        } else if panGesture.state == .changed {
            view.frame.origin = CGPoint(
                x: view.frame.origin.x,
                y: view.frame.origin.y > translation.y ? view.frame.origin.y : translation.y
            )
        } else if panGesture.state == .ended {
            let velocity = panGesture.velocity(in: view)
            
            if velocity.y >= 1500 {
                UIView.animate(withDuration: 0.2
                               , animations: {
                                self.view.frame.origin = CGPoint(
                                    x: self.view.frame.origin.x,
                                    y: self.view.frame.size.height
                                )
                               }, completion: { (isCompleted) in
                                if isCompleted {
                                    self.dismiss(animated: false, completion: nil)
                                }
                               })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.center = self.originalPosition!
                })
            }
        }
    }
    
    @objc
    func questionBackButtonDidTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func questionContentsIsEmpty() {
        if questionContents.text == "  요청 내용을 입력해주세요" {
            questionFlag = false
        } else {
            questionFlag = true
        }
    }
    
    func questionContentsSetupView() {
        if questionContents.text == "  요청 내용을 입력해주세요" {
            questionContents.text = ""
            questionContents.textColor = UIColor.black
            questionContents.alpha = 0.7
        } else if questionContents.text == "" {
            questionContents.text = "  요청 내용을 입력해주세요"
            questionContents.textColor = UIColor.lightGray
            questionContents.alpha = 0.7
        }
    }
    
    func submissionButtonisEnabled() {
        if questionFlag {
            submissionButton.backgroundColor = UIColor.black
            submissionButton.setTitleColor(UIColor.white, for: .normal)
            submissionButton.isEnabled = true
        } else {
            submissionButton.backgroundColor = UIColor(red: (238/255.0), green: (238/255.0), blue: (238/255.0), alpha: 1.0)
            submissionButton.setTitleColor(UIColor(red: (206/255.0), green: (206/255.0), blue: (206/255.0), alpha: 1.0), for: .normal)
            submissionButton.isEnabled = false
        }
    }
}

extension QuestionsViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        questionContentsSetupView()
        questionContents.layer.borderColor = UIColor(red: (34/255.0), green: (34/255.0), blue: (34/255.0), alpha: 1.0).cgColor
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        questionContents.layer.borderColor = UIColor(red: (238/255.0), green: (238/255.0), blue: (238/255.0), alpha: 1.0).cgColor
    }
    func textViewDidChange(_ textView: UITextView) {
        questionContentsSetupView()
        questionContentsIsEmpty()
        submissionButtonisEnabled()
    }
}

// UIAlertController의 preferredStyle: .actionSheet
