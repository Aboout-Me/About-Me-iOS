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
    
    private func configure() {
        advisoryAnswerTableView.dataSource = self
        advisoryAnswerTableView.delegate = self
        
        let nibName = UINib(nibName: "AdvisoryNewAnswerCell", bundle: nil)
        advisoryAnswerTableView.register(nibName, forCellReuseIdentifier: "newAnswerCell")
    }
    
}

extension AdvisoryAnswerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newAnswerCell", for: indexPath)
                as? AdvisoryNewAnswerCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let questionVC = storyboard.instantiateViewController(withIdentifier: "AdvisoryQuestionVC")
                as? AdvisoryQuestionViewController else { return }
        self.navigationController?.pushViewController(questionVC, animated: true)
    }
    
    
}

extension AdvisoryAnswerViewController: UITableViewDelegate {
    
}
