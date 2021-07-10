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
    
        questionContentsIsEmpty()
        questionContentsSetupView()
        submissionButtonisEnabled()
//        let bottomSheet = BottomSheetView(nibName: "BottomSheetView", bundle: nil)
//        bottomSheet.modalPresentationStyle = .overCurrentContext
//        self.present(bottomSheet, animated: true, completion: nil)
    }
    
    @IBAction func chooseQuestionsButtonDidTapped () {
        
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
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        // 개행 시 최초 응답자 제거
//        if text == "\n" {
//            textView.resignFirstResponder()
//        }
//        guard let str = textView.text else { return true }
//        let newLength = str.count + text.count - range.length
//        return newLength <= 41
//    }
}
