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
    @IBOutlet weak var newButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Selectors
    
    @objc
    private func newButtonDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let questionVC = storyboard.instantiateViewController(withIdentifier: "AdvisoryQuestionVC")
                as? AdvisoryQuestionViewController else { return }
        self.navigationController?.pushViewController(questionVC, animated: true)
    }
    
    // MARK: - Helpers
    
    private func configure() {
        advisoryAnswerTableView.dataSource = self
        advisoryAnswerTableView.delegate = self
        
        self.newButton.setTitle("NEW", for: .normal)
        self.newButton.addTarget(self, action: #selector(newButtonDidTap(_:)), for: .touchUpInside)
//        let nibName = UINib(nibName: "AdvisoryNewAnswerCell", bundle: nil)
//        advisoryAnswerTableView.register(nibName, forCellReuseIdentifier: "newAnswerCell")
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    
}

extension AdvisoryAnswerViewController: UITableViewDelegate {
    
}
