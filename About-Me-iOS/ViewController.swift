//
//  ViewController.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/03/25.
//

import UIKit
import SideMenu

class ViewController: UIViewController {
    var sideMenu: SideMenuNavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayoutInit()
        self.setSideMenuLayoutInit()
    }
    
    
    private func setSideMenuLayoutInit() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sideOnlyViewController: SideOnlyViewController = storyboard.instantiateViewController(withIdentifier: "SideOnlyViewController") as! SideOnlyViewController
        self.sideMenu = SideMenuNavigationController(rootViewController: sideOnlyViewController)
        self.sideMenu?.leftSide = true
    }
    
    private func setLayoutInit() {
        let leftBarButtonItem = UIBarButtonItem(title: "Test", style: .plain, target: self, action: #selector(self.showSideButtonDidTap))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc
    public func showSideButtonDidTap() {
        self.present(sideMenu!, animated: true, completion: nil)
    }
    
    
}
