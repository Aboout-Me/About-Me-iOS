//
//  ConciergeViewController.swift
//  About-Me-iOS
//
//  Created by Apple on 2021/04/07.
//

import UIKit

class ConciergeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        // 임시로 계속 false값 주기
        LandscapeManager.shared.isFirstLaunch = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if LandscapeManager.shared.isFirstLaunch {
            performSegue(withIdentifier: "toOnboarding", sender: nil)
            LandscapeManager.shared.isFirstLaunch = true
        } else {
            performSegue(withIdentifier: "toHome_temp", sender: nil)
        }
    }

    
    
}
