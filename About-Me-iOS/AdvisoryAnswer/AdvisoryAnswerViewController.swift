//
//  AdvisoryAnswerViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/01.
//

import UIKit

class AdvisoryAnswerViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var sectionHeaderView: UIView!
    @IBOutlet weak var sectionHeaderLabel: UILabel!
    @IBOutlet weak var advisoryAnswerTableView: UITableView!
    @IBOutlet weak var newButton: UIButton!
    
    private var answerLists: [ThemeList] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        getAnswerList()
    }
    
    // MARK: - Selectors
    
    @objc
    private func newButtonDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let questionVC = storyboard.instantiateViewController(withIdentifier: "AdvisoryQuestionVC")
                as? AdvisoryQuestionViewController else { return }
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        self.navigationController?.view.layer.add(transition, forKey: nil)
        
        questionVC.modalPresentationStyle = .custom
        self.navigationController?.pushViewController(questionVC, animated: false)
    }
    
    // MARK: - Helpers
    
    private func configure() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "advisory")!)
        let noAnswerNib = UINib(nibName: "NoAnswerCell", bundle: nil)
        advisoryAnswerTableView.register(noAnswerNib, forCellReuseIdentifier: "noAnswerCell")
        let answerNib = UINib(nibName: "AdvisoryAnswerCell", bundle: nil)
        advisoryAnswerTableView.register(answerNib, forCellReuseIdentifier: "advisoryAnswerCell")

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        advisoryAnswerTableView.dataSource = self
        advisoryAnswerTableView.delegate = self
        
        self.sectionHeaderView.roundCorners([.topLeft, .topRight], radius: 20)
        self.sectionHeaderLabel.textColor = UIColor(white: 85.0 / 255.0, alpha: 1.0)
        
        //        self.newButton.setTitle("NEW", for: .normal)
        self.newButton.setTitleColor(UIColor(white: 1.0, alpha: 1.0), for: .normal)
        self.newButton.backgroundColor = UIColor(white: 34.0 / 255.0, alpha: 1.0)
        self.newButton.addTarget(self, action: #selector(newButtonDidTap(_:)), for: .touchUpInside)
        self.newButton.layer.cornerRadius = 5
        //        let nibName = UINib(nibName: "AdvisoryNewAnswerCell", bundle: nil)
        //        advisoryAnswerTableView.register(nibName, forCellReuseIdentifier: "newAnswerCell")
    }
    
    private func getAnswerList() {
        AdvisoryApiService.getAdvisoryAnswerList { list in
            if let list = list {
                print(list)
                self.answerLists = list.themeLists
                if list.themeLists.count == 0 {
                    self.advisoryAnswerTableView.alwaysBounceVertical = false
                    self.newButton.setTitle("첫 번째 \(self.newButton.titleLabel!.text!)",
                                            for: .normal)
                } else {
                    self.advisoryAnswerTableView.alwaysBounceVertical = true
                    self.newButton.setTitle("새로운 \(self.newButton.titleLabel!.text!)",
                                            for: .normal)
                }
                self.advisoryAnswerTableView.reloadData()
            }
        }
    }
    
}

extension AdvisoryAnswerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.answerLists.count == 0 {
            return 1
        } else {
            return self.answerLists.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.answerLists.count == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "noAnswerCell", for: indexPath)
                    as? NoAnswerCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "advisoryAnswerCell", for: indexPath) as? AdvisoryAnswerCell else {
                return UITableViewCell()
            }
            
            let answer = self.answerLists[indexPath.row]
            cell.titleLabel.text = answer.stage_name
            cell.createdLabel.text = answer.timer
            let rate = String(answer.rate.components(separatedBy: " /")[0])
            
            if rate == "10" {
                cell.stageLabel.text = "10/10"
                cell.stageLabel.textColor = UIColor(white: 34.0 / 255.0, alpha: 1.0)
                cell.finishView.tintColor = UIColor(white: 34.0 / 255.0, alpha: 1.0)
            } else {
                let attributedString = NSMutableAttributedString(string: rate,
                                                                 attributes: [.foregroundColor: UIColor(white: 34.0 / 255.0, alpha: 1.0)])
                attributedString.append(NSAttributedString(string: "/10",
                                                           attributes: [.foregroundColor: UIColor(white: 119.0 / 255.0, alpha: 1.0)]))
                cell.stageLabel.attributedText = attributedString
                cell.finishView.tintColor = UIColor(white: 119.0 / 255.0, alpha: 1.0)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.answerLists.count == 0 {
            return 150
        } else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    
}

extension AdvisoryAnswerViewController: UITableViewDelegate {
    
}

extension UIView {
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        self.layoutIfNeeded()
        let path: UIBezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask: CAShapeLayer = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
