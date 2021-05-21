import UIKit

class AdditionalProfileViewController: UIViewController {


    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var nicknameTextfield: UITextField!
    @IBOutlet weak var dateTextfield: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    private var datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "추가정보입력"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        // textView 설정
        textViewSetupView()
        textView.delegate = self
        textView.layer.borderWidth = 0.25
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 5.0;
        
        // datePicker 설정
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(AdditionalProfileViewController.dateChanged(datePicker:)), for: .valueChanged)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AdditionalProfileViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
//        self.view.addSubview(datePicker)
        dateTextfield.inputView = datePicker
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        dateTextfield.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    func textViewSetupView() {
        if textView.text == "짧은 글을 추가하여 회원님을 소개해 주세요" {
            textView.text = ""
            textView.textColor = UIColor.black
        } else if textView.text == "" {
            textView.text = "짧은 글을 추가하여 회원님을 소개해 주세요"
            textView.textColor = UIColor.lightGray
        }
    }
}

extension AdditionalProfileViewController: UITextViewDelegate {
    
    // 편집이 시작될 때
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewSetupView()
    }
    
    // 편집이 종료될 때
    func textViewDidEndEditing(_ textView: UITextView) {
        textViewSetupView()
    }
    
    // 텍스트가 입력될 때
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 개행 시 최초 응답자 제거
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
}
