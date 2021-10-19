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

        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ArrowLeft"), style: .plain, target: self, action: #selector(alertBackButtonDidTapped))
        let navigationApp = UINavigationBarAppearance()
        navigationApp.configureWithTransparentBackground()
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationController?.navigationBar.standardAppearance = navigationApp
        self.navigationItem.title = "알림설정"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18)!,NSAttributedString.Key.foregroundColor : UIColor.gray333]
        
        alertAgreementSwitch.onTintColor = .black
        alertAgreementSwitch.tintColor = .lightGray
        
        if let state = UserDefaults.standard.string(forKey: "alertState") {
            if state.isEmpty || state == "Y" {
                alertAgreementSwitch.isOn = true
            } else  {
                alertAgreementSwitch.isOn = false
            }
        }
        
        if UserDefaults.standard.bool(forKey: "questionalertState") == true {
            questionsAlertSwitch.isOn = true
        } else {
            questionsAlertSwitch.isOn = false
        }
        
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
    
    @objc
    func alertBackButtonDidTapped() {
        self.navigationController?.popViewController(animated: true)
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
                UserDefaults.standard.set(body, forKey: "alertState")
                print("알림 : \(self.body)")
            }
        }
        else {
            SettingApiService.postAlertSetting(userId: UserDefaults.standard.integer(forKey: "USER_ID")) { (body) -> () in
                self.body = body
                UserDefaults.standard.set(body, forKey: "alertState")
                print("알림 : \(self.body)")
            }
        }
    }
    
    @IBAction func questionSwitchDidTapped(_ sender: Any) {
        if questionsAlertSwitch.isOn {
            Messaging.messaging().subscribe(toTopic: "notice") { error in
              print("질문알림 On")
                UserDefaults.standard.setValue(self.questionsAlertSwitch.isOn, forKey: "questionalertState")
            }
        }
        else {
            Messaging.messaging().unsubscribe(fromTopic: "notice") { error in
              print("질문알림 Off")
                UserDefaults.standard.setValue(self.questionsAlertSwitch.isOn, forKey: "questionalertState")
            }
        }
    }
    
}
