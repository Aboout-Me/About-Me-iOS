//
//  AlertSettingsViewController.swift
//  About-Me-iOS
//
//  Created by Apple on 2021/05/27.
//

import UIKit
import Firebase

class AlertSettingsViewController: UIViewController {

    @IBOutlet weak var alertAgreement: UILabel!
    @IBOutlet weak var questionsAlert: UILabel!
    lazy var labelArray = [alertAgreement,
                           questionsAlert]
    @IBOutlet weak var alertAgreementSwitch: UISwitch!
    @IBOutlet weak var questionsAlertSwitch: UISwitch!
    
    var body: String = "" // 알림허용 여부(Y or N)
    
    var descs = ["    알림 허용\n    전체 알림 설정",
                 "    질문 알림\n    매일 오전 9시에 질문 알림"]
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .black
        self.title = "알림 설정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        alertAgreementSwitch.onTintColor = .black
        alertAgreementSwitch.tintColor = .lightGray
        
        questionsAlertSwitch.onTintColor = .black
        questionsAlertSwitch.tintColor = .lightGray
        
        for index in 0..<labelArray.count {
            let description = labelArray[index]
            description?.numberOfLines = 2
            description?.text = descs[index]
            
            let attrString = NSMutableAttributedString(string: descs[index])
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
            
            let fontSize = UIFont.boldSystemFont(ofSize: 13)

            if index == 0{
                attrString.addAttribute(.foregroundColor, value: UIColor(red: (164/255.0), green: (164/255.0), blue: (164/255.0), alpha: 1.0), range: (descs[index] as NSString).range(of:"전체 알림 설정"))
                attrString.addAttribute(.font, value: fontSize, range: (descs[index] as NSString).range(of: "전체 알림 설정"))
            }
            else if index == 1{
                attrString.addAttribute(.foregroundColor, value: UIColor(red: (164/255.0), green: (164/255.0), blue: (164/255.0), alpha: 1.0), range: (descs[index]  as NSString).range(of:"매일 오전 9시에 질문 알림"))
                attrString.addAttribute(.font, value: fontSize, range: (descs[index] as NSString).range(of: "매일 오전 9시에 질문 알림"))
            }
            description?.attributedText = attrString
        }
        
        
        addTopAndBottomBorders()
    }
    
    func addTopAndBottomBorders() {
        for i in 0..<labelArray.count {
            let thickness: CGFloat = 0.25
            let bottomBorder = CALayer()
            bottomBorder.frame = CGRect(x:0, y: self.alertAgreement.frame.size.height - thickness, width: self.alertAgreement.frame.size.width, height:thickness)
            bottomBorder.backgroundColor = UIColor.lightGray.cgColor
        
            labelArray[i]?.layer.addSublayer(bottomBorder)
        }
    }

    @IBAction func alertSwitchDidTapped(_ sender: Any) {
        if alertAgreementSwitch.isOn {
            SettingApiService.postAlertSetting(userId: UserDefaults.standard.integer(forKey: "USER_ID")) { (body) -> () in
                self.body = body
                print("알림 : \(self.body)")
            }
        }
        else {
            SettingApiService.postAlertSetting(userId: UserDefaults.standard.integer(forKey: "USER_ID")) { (body) -> () in
                self.body = body
                print("알림 : \(self.body)")
            }
        }
    }
    
    @IBAction func questionSwitchDidTapped(_ sender: Any) {
        if questionsAlertSwitch.isOn {
            Messaging.messaging().subscribe(toTopic: "notice") { error in
              print("질문알림 On")
            }
        }
        else {
            Messaging.messaging().unsubscribe(fromTopic: "notice") { error in
              print("질문알림 Off")
            }
        }
    }
    
}
