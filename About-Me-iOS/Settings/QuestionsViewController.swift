//
//  QuestionsViewController.swift
//  About-Me-iOS
//
//  Created by Apple on 2021/05/27.
//

import UIKit

class QuestionsViewController: UIViewController {

    @IBOutlet weak var chooseQuestionsButton: UIButton!
    @IBOutlet weak var questionContents: UITextView!
    @IBOutlet weak var submissionButton: UIButton!
    
    var questionFlag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .black
        self.title = "문의하기"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
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
    
    @IBAction func chooseQuestionsButtonDidTapped () {
        let bottomSheetVC = BottomSheetViewController()
         // 1
         bottomSheetVC.modalPresentationStyle = .overFullScreen
         // 2
         self.present(bottomSheetVC, animated: false, completion: nil)
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
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        questionContentsSetupView()
        questionContentsIsEmpty()
        submissionButtonisEnabled()
    }
}
