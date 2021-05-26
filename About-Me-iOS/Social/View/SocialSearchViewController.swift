//
//  SocialSearchViewController.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/27.
//

import UIKit

class SocialSearchViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var searchInputView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
    }
    
    // MARK: - Selectors
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    private func configure() {
        self.searchTextField.delegate = self
        self.searchTableView.dataSource = self
        self.searchTableView.delegate = self
        
        self.searchInputView.layer.cornerRadius = 20
        self.searchInputView.layer.borderWidth = 1
        self.searchInputView.layer.borderColor = UIColor.lineDdd.cgColor
    }
}

extension SocialSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTextField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
}

extension SocialSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let title = UILabel()
        title.text = "최근 검색어"
        title.font = UIFont.init(name: "AppleSDGothicNeo-Medium", size: 18)
        
        view.addSubview(title)
        title.anchor(left: view.leftAnchor, paddingLeft: 20)
        title.centerY(inView: view)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension SocialSearchViewController: UITableViewDelegate {
    
}
