//
//  SocialViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/01.
//

import UIKit
import SideMenu

class SocialViewController: UIViewController {
    
    // MARK: - Properties
    
    public var sideMenu: SideMenuNavigationController?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
        self.setSideMenuLayoutInit()
    }
    
    // MARK: - Selectors
    
    @objc
    public func menuIconDidTap() {
        self.present(sideMenu!, animated: true, completion: nil)
    }
    
    @objc
    private func searchIconDidTap(_ sender: UIBarButtonItem) {
        print("@@@@")
    }
    
    // MARK: - Helpers
    
    private func configure() {
        view.backgroundColor = .whiteTwo
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu.png"), style: .plain, target: self, action: #selector(menuIconDidTap))
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchIconDidTap))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationController?.navigationBar.tintColor = .black
        
        self.title = "공감하는 이야기"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 18)]
    }
    
    private func setSideMenuLayoutInit() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sideOnlyViewController: SideOnlyViewController = storyboard.instantiateViewController(withIdentifier: "SideOnlyViewController") as! SideOnlyViewController
        self.sideMenu = SideMenuNavigationController(rootViewController: sideOnlyViewController)
        self.sideMenu?.leftSide = true
    }
}
