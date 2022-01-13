import UIKit

class AdditionalProfileViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var nicknameTextfield: UITextField!
//    @IBOutlet weak var dateTextfield: UITextField!
//    @IBOutlet weak var manButton: UIButton!
//    @IBOutlet weak var womanButton: UIButton!
    @IBOutlet weak var introduceTextView: UITextView!
    @IBOutlet weak var limitNum: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    

    var emailFlag: Bool = false
    var nicknameFlag: Bool = false
//    var dateFlag: Bool = false
//    var genderFlag: Bool = false
    var introduceFlag: Bool = false
    
//    var gender: String = "none"
//    var birthday: Date = Date()
//    var birthday: String = ""
    var userEmail: String = "none"
    var userId: Int = -1
      
//    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "추가정보입력"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        emailTextfield.delegate = self
        nicknameTextfield.delegate = self
//        dateTextfield.delegate = self
        introduceTextView.delegate = self
        
        nextButton.layer.cornerRadius = 5.0
        
        emailTextFieldIsEmpty()
        nicknameTextFieldIsEmpty()
//        dateTextFieldIsEmpty()
        introduceTextViewIsEmpty()
        
        nextButtonisEnalbed()
        introduceTextViewSetupView()
        nextButton.addTarget(self, action: #selector(nextButtonDidTap(_:)), for: .touchUpInside)
        
        // gender button 설정
//        manButton.layer.borderWidth = 0.25
//        manButton.layer.borderColor = UIColor.lightGray.cgColor
//        manButton.layer.cornerRadius = 5.0;
//        manButton.backgroundColor = UIColor.white
//        manButton.setTitleColor(UIColor.lightGray, for: .normal)
//
//        womanButton.layer.borderWidth = 0.25
//        womanButton.layer.borderColor = UIColor.lightGray.cgColor
//        womanButton.layer.cornerRadius = 5.0;
//        womanButton.backgroundColor = UIColor.white
//        womanButton.setTitleColor(UIColor.lightGray, for: .normal)
        
        // textView 설정
        introduceTextView.layer.borderWidth = 0.25
        introduceTextView.layer.borderColor = UIColor.lightGray.cgColor
        introduceTextView.layer.cornerRadius = 5.0;
        introduceTextView.backgroundColor = UIColor.white
        
        // datePicker 설정
//        datePicker = UIDatePicker()
//        datePicker?.preferredDatePickerStyle = .wheels
//        datePicker?.datePickerMode = .date
//        datePicker?.addTarget(self, action: #selector(AdditionalProfileViewController.dateChanged(datePicker:)), for: .valueChanged)
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AdditionalProfileViewController.viewTapped(gestureRecognizer:)))
//
//        view.addGestureRecognizer(tapGesture)
//
//        dateTextfield.inputView = datePicker
        
        // LoginVC에서 email값 가져오기
        emailTextfield.text = userEmail
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // 프로필 데이터 전송 API 호출
        print("**Add.profile** user Id : \(self.userId)")
        LoginApiService.putProfileForSignUp(email: userEmail, nickName: nicknameTextfield.text!, introduce: introduceTextView.text!, userId: userId)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
//    @objc func dateChanged(datePicker: UIDatePicker){
//        var dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
//        dateTextfield.text = dateFormatter.string(from: datePicker.date)
//
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let temp = dateFormatter.string(from: datePicker.date)
//        self.birthday = temp
//
//        view.endEditing(true)
//    }
    
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
    
    func introduceTextViewIsEmpty() {
        if introduceTextView.text == "짧은 글을 추가하여 회원님을 소개해 주세요" || introduceTextView.text == ""{
            introduceFlag = false
        } else {
            introduceFlag = true
        }
    }
    
    func emailTextFieldIsEmpty() {
        if emailTextfield.text?.isEmpty ?? true {
            emailFlag = false
        } else {
            emailFlag = true
        }
    }
    
    func nicknameTextFieldIsEmpty() {
        let minLimit = nicknameTextfield.text!.count
        if nicknameTextfield.text?.isEmpty ?? true || minLimit <= 1 {
            nicknameFlag = false
        } else {
            nicknameFlag = true
        }
    }
    
//    func dateTextFieldIsEmpty() {
//        if dateTextfield.text?.isEmpty ?? true {
//            dateFlag = false
//        } else {
//            dateFlag = true
//        }
//    }
        
    @objc
    private func nextButtonDidTap(_ sender: UIButton) {
        let termsOfUseVC = TermsOfUseViewController(nibName: "TermsOfUseViewController", bundle: nil)
        termsOfUseVC.modalPresentationStyle = .overCurrentContext
        self.present(termsOfUseVC, animated: true, completion: nil)
    }
    
    func nextButtonisEnalbed() {
        if emailFlag && nicknameFlag && introduceFlag {
            nextButton.backgroundColor = UIColor.black
            nextButton.setTitleColor(UIColor.white, for: .normal)
            nextButton.isEnabled = true
        } else {
            nextButton.backgroundColor = UIColor(red: (238/255.0), green: (238/255.0), blue: (238/255.0), alpha: 1.0)
            nextButton.setTitleColor(UIColor(red: (206/255.0), green: (206/255.0), blue: (206/255.0), alpha: 1.0), for: .normal)
            nextButton.isEnabled = false
        }
    }
    @IBAction func nextButtonDidTapped(_ sender: Any) {
        USER_NICKNAME = nicknameTextfield.text
        UserDefaults.standard.setValue(nicknameTextfield.text, forKey: "USER_NICKNAME")
    }
    
//    @IBAction func manButtonDidTapped(_ sender: UIButton) {
//        manButton.layer.borderColor = UIColor.black.cgColor
//        manButton.setTitleColor(UIColor.black, for: .normal)
//        manButton.layer.borderWidth = 1
//
//        womanButton.layer.borderColor = UIColor.lightGray.cgColor
//        womanButton.setTitleColor(UIColor.lightGray, for: .normal)
//        womanButton.layer.borderWidth = 0.25
//
//        gender = "man"
//        genderFlag = true
//        nextButtonisEnalbed()
//    }
//
//    @IBAction func womanButtonDidTapped(_ sender: UIButton) {
//        womanButton.layer.borderColor = UIColor.black.cgColor
//        womanButton.setTitleColor(UIColor.black, for: .normal)
//        womanButton.layer.borderWidth = 1
//
//        manButton.layer.borderColor = UIColor.lightGray.cgColor
//        manButton.setTitleColor(UIColor.lightGray, for: .normal)
//        manButton.layer.borderWidth = 0.25
//
//        gender = "woman"
//        genderFlag = true
//        nextButtonisEnalbed()
//    }
}

extension AdditionalProfileViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        introduceTextViewSetupView()
    }
    func textViewDidChange(_ textView: UITextView) {
        introduceTextViewSetupView()
        introduceTextViewIsEmpty()
        nextButtonisEnalbed()
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

extension AdditionalProfileViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        emailTextFieldIsEmpty()
        nicknameTextFieldIsEmpty()
//        dateTextFieldIsEmpty()
        nextButtonisEnalbed()
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



