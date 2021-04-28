//
//  MyProfileViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/01.
//

import UIKit

class MyProfileViewController: UIViewController {
    
    @IBOutlet weak var detailPushButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 18)!]
        self.navigationItem.title = "MY"
        self.detailPushButton.addTarget(self, action: #selector(self.didTapdetailPushButton), for: .touchUpInside)
    }
    
    @objc
    public func didTapdetailPushButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileDetailView = storyboard.instantiateViewController(withIdentifier: "ProfileDetail") as? MyProfileDetailViewController
        guard let profileDetailVC = profileDetailView else { return }
        self.navigationController?.pushViewController(profileDetailVC, animated: true)
    }
}
