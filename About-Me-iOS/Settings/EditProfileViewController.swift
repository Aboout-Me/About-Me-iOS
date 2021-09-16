//
//  EditProfileViewController.swift
//  About-Me-iOS
//
//  Created by Apple on 2021/05/27.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var nicknameTextfield: UITextField!
    @IBOutlet weak var introduceTextView: UITextView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var limitNum: UILabel!
    
    var nicknameFlag: Bool = false
    var introduceFlag: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .black
        self.title = "프로필 편집"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        nicknameTextfield.delegate = self
        introduceTextView.delegate = self
        
        introduceTextView.layer.borderWidth = 0.25
        introduceTextView.layer.borderColor = UIColor.lightGray.cgColor
        introduceTextView.layer.cornerRadius = 5.0;
        introduceTextView.backgroundColor = UIColor.white
        
        confirmButton.layer.cornerRadius = 5.0
        
        nicknameTextFieldIsEmpty()
        introduceTextViewIsEmpty()
        
        confirmButtonisEnabled()
        introduceTextViewSetupView()
    }
    
    func nicknameTextFieldIsEmpty() {
        let minLimit = nicknameTextfield.text!.count
        if nicknameTextfield.text?.isEmpty ?? true || minLimit <= 1 {
            nicknameFlag = false
        } else {
            nicknameFlag = true
        }
    }
    
    func introduceTextViewIsEmpty() {
        if introduceTextView.text == "짧은 글을 추가하여 회원님을 소개해 주세요" {
            introduceFlag = false
        } else {
            introduceFlag = true
        }
    }
    
    func introduceTextViewSetupView() {
        if introduceTextView.text == "짧은 글을 추가하여 회원님을 소개해 주세요" {
            introduceTextView.text = ""
            introduceTextView.textColor = UIColor.black
            introduceTextView.alpha = 0.7
            
            limitNum.text = ""
        } else if introduceTextView.text == "" {
            introduceTextView.text = "짧은 글을 추가하여 회원님을 소개해 주세요"
            introduceTextView.textColor = UIColor.lightGray
            introduceTextView.alpha = 0.7
            
            limitNum.text = "0 / 40"
            limitNum.textColor = UIColor.lightGray
            limitNum.alpha = 0.7
        }
    }
    
    func confirmButtonisEnabled() {
        if nicknameFlag && introduceFlag {
            confirmButton.backgroundColor = UIColor.black
            confirmButton.setTitleColor(UIColor.white, for: .normal)
            confirmButton.isEnabled = true
        } else {
            confirmButton.backgroundColor = UIColor(red: (238/255.0), green: (238/255.0), blue: (238/255.0), alpha: 1.0)
            confirmButton.setTitleColor(UIColor(red: (206/255.0), green: (206/255.0), blue: (206/255.0), alpha: 1.0), for: .normal)
            confirmButton.isEnabled = false
        }
    }

    @IBAction func confirmButtonDidTapped(_ sender: UIButton) {
        if confirmButton.isEnabled {
            LoginApiService.putProfileForEditing(nickName: nicknameTextfield.text!, introduce: introduceTextView.text!, userId: UserDefaults.standard.integer(forKey: "USER_ID"))
        }
    }
}

extension EditProfileViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        introduceTextViewSetupView()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        introduceTextViewSetupView()
        introduceTextViewIsEmpty()
        confirmButtonisEnabled()
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 개행 시 최초 응답자 제거
        if text == "\n" {
            textView.resignFirstResponder()
        }
        guard let str = textView.text else { return true }
        let newLength = str.count + text.count - range.length
        return newLength <= 41
    }
}

extension EditProfileViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        nicknameTextFieldIsEmpty()
        confirmButtonisEnabled()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nicknameTextfield{
          guard let text = textField.text else { return true }
          let newLength = text.count + string.count - range.length
          return newLength <= 11
        }
        else{
            return true
        }
    }
}
