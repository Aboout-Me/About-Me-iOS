//
//  AdvisoryAnswerViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/01.
//

import UIKit

class AdvisoryAnswerViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var advisoryAnswerTableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Helpers
    
    func configure() {
        advisoryAnswerTableView.dataSource = self
        advisoryAnswerTableView.delegate = self
    }
    
}

extension AdvisoryAnswerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "advisoryAnswerCell", for: indexPath) as? AdvisoryAnswerCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    
}

extension AdvisoryAnswerViewController: UITableViewDelegate {
    
}
