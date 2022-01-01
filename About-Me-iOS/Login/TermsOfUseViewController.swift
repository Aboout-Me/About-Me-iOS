//
//  TermsOfUseViewController.swift
//  오늘의 나
//
//  Created by Apple on 2021/12/30.
//

import UIKit

class TermsOfUseViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var agreementButton: UIButton!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var agreementCheckMark: UIImageView!
    @IBOutlet weak var firstCheckMark: UIImageView!
    @IBOutlet weak var secondCheckMark: UIImageView!
    @IBOutlet weak var thirdCheckMark: UIImageView!
    
    var agreementFlag = false
    var firstButtonFlag = false
    var secondButtonFlag = false
    var thirdButtonFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 10
        topView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        confirmButton.layer.cornerRadius = 5
        
        agreementCheckMark.image = UIImage(named: "icoCommon24CompleteOff")
        firstCheckMark.image = UIImage(named: "icoCommon24CheckedOff")
        secondCheckMark.image = UIImage(named: "icoCommon24CheckedOff")
        thirdCheckMark.image = UIImage(named: "icoCommon24CheckedOff")
    }
    
    @IBAction func agreementButtonDidTapped(_ sender: Any) {
        if firstButtonFlag && secondButtonFlag && thirdButtonFlag {
            firstButtonFlag = false
            secondButtonFlag = false
            thirdButtonFlag = false
            
            agreementCheckMark.image = UIImage(named: "icoCommon24CompleteOff")
            firstCheckMark.image = UIImage(named: "icoCommon24CheckedOff")
            secondCheckMark.image = UIImage(named: "icoCommon24CheckedOff")
            thirdCheckMark.image = UIImage(named: "icoCommon24CheckedOff")
        }
        else {
            firstButtonFlag = true
            secondButtonFlag = true
            thirdButtonFlag = true
            
            agreementCheckMark.image = UIImage(named: "icoCommon24CompleteOn")
            firstCheckMark.image = UIImage(named: "icoCommon24CheckedOn")
            secondCheckMark.image = UIImage(named: "icoCommon24CheckedOn")
            thirdCheckMark.image = UIImage(named: "icoCommon24CheckedOn")
        }
    }
    @IBAction func firstButtonDidTapped(_ sender: UIButton) {
        if firstButtonFlag == false{
            firstButtonFlag = true
            firstCheckMark.image = UIImage(named: "icoCommon24CheckedOn")
            
            if firstButtonFlag && secondButtonFlag && thirdButtonFlag {
                agreementCheckMark.image = UIImage(named: "icoCommon24CompleteOn")
            }
        }
        else{
            firstButtonFlag = false
            firstCheckMark.image = UIImage(named: "icoCommon24CheckedOff")
            
            agreementCheckMark.image = UIImage(named: "icoCommon24CompleteOff")
        }
    }
    @IBAction func secondButtonDidTapped(_ sender: UIButton) {
        if secondButtonFlag == false{
            secondButtonFlag = true
            secondCheckMark.image = UIImage(named: "icoCommon24CheckedOn")
            
            if firstButtonFlag && secondButtonFlag && thirdButtonFlag {
                agreementCheckMark.image = UIImage(named: "icoCommon24CompleteOn")
            }
        }
        else{
            secondButtonFlag = false
            secondCheckMark.image = UIImage(named: "icoCommon24CheckedOff")
            
            agreementCheckMark.image = UIImage(named: "icoCommon24CompleteOff")
        }
    }
    @IBAction func thirdButtonDidTapped(_ sender: Any) {
        if thirdButtonFlag == false{
            thirdButtonFlag = true
            thirdCheckMark.image = UIImage(named: "icoCommon24CheckedOn")
            
            if firstButtonFlag && secondButtonFlag && thirdButtonFlag {
                agreementCheckMark.image = UIImage(named: "icoCommon24CompleteOn")
            }
        }
        else{
            thirdButtonFlag = false
            thirdCheckMark.image = UIImage(named: "icoCommon24CheckedOff")
            
            agreementCheckMark.image = UIImage(named: "icoCommon24CompleteOff")
        }
    }
    
    func confirmButtonIsEnabled() {
        if firstButtonFlag && secondButtonFlag && thirdButtonFlag {
            confirmButton.backgroundColor = UIColor(red: (34/255.0), green: (34/255.0), blue: (34/255.0), alpha: 1.0)
            confirmButton.setTitleColor(UIColor(red: (255/255.0), green: (255/255.0), blue: (255/255.0), alpha: 1.0), for: .normal)
            confirmButton.isEnabled = true
        }
        else {
            confirmButton.backgroundColor = UIColor(red: (238/255.0), green: (238/255.0), blue: (238/255.0), alpha: 1.0)
            confirmButton.setTitleColor(UIColor(red: (204/255.0), green: (204/255.0), blue: (204/255.0), alpha: 1.0), for: .normal)
            confirmButton.isEnabled = false
        }
    }
    @IBAction func confirmButtonDidTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

