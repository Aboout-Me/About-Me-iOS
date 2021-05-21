//
//  SettingsViewController.swift
//  About-Me-iOS
//
//  Created by Apple on 2021/05/06.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var editprofileButton: UIButton!
    @IBOutlet weak var alaramsettingsButton: UIButton!
    @IBOutlet weak var quetstionsButton: UIButton!
    @IBOutlet weak var noticesButton: UIButton!
    @IBOutlet weak var versioninfoButton: UIButton!
    lazy var buttonArray = [editprofileButton,
                       alaramsettingsButton,
                       quetstionsButton,
                       noticesButton,
                       versioninfoButton ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = UIViewController()
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency self.present(vc, animated: true, completion: nil)

        
        // 네비게이션바 설정
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.title = "설정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]

        addTopAndBottomBorders()
    }
    
    func addTopAndBottomBorders() {
        for i in 0..<buttonArray.count {
            let thickness: CGFloat = 0.25
            let bottomBorder = CALayer()
            bottomBorder.frame = CGRect(x:0, y: self.editprofileButton.frame.size.height - thickness, width: self.editprofileButton.frame.size.width, height:thickness)
            bottomBorder.backgroundColor = UIColor.lightGray.cgColor
        
            buttonArray[i]?.layer.addSublayer(bottomBorder)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
