//
//  AdvisoryAnswerViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/01.
//

import UIKit
import SideMenu
import Floaty

class AdvisoryAnswerViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var sectionHeaderView: UIView!
    @IBOutlet weak var advisoryAnswerTableView: UITableView!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var floatyButton: Floaty!
    
    public var sideMenu: SideMenuNavigationController?
    private var answerLists: [ThemeList] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setSideMenuLayoutInit()
        getAnswerList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getAnswerList()
        configureNavigation()
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
    
    @objc
    public func menuIconDidTap() {
        self.present(sideMenu!, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    private func configure() {
        self.backgroundImageView.image = UIImage(named: "advisory.png")
        self.backgroundImageView.contentMode = .scaleAspectFill
        
        let noAnswerNib = UINib(nibName: "NoAnswerCell", bundle: nil)
        advisoryAnswerTableView.register(noAnswerNib, forCellReuseIdentifier: "noAnswerCell")
        let answerNib = UINib(nibName: "AdvisoryAnswerCell", bundle: nil)
        advisoryAnswerTableView.register(answerNib, forCellReuseIdentifier: "advisoryAnswerCell")

        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        advisoryAnswerTableView.dataSource = self
        advisoryAnswerTableView.delegate = self
        
        self.sectionHeaderView.roundCorners([.topLeft, .topRight], radius: 20)
        
        self.newButton.layer.cornerRadius = 25
        self.newButton.addTarget(self, action: #selector(newButtonDidTap), for: .touchUpInside)
        self.newButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.newButton.layer.shadowRadius = 12
        self.newButton.layer.shadowOpacity = 0.12
        self.floatyButton.buttonColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.floatyButton.plusColor = UIColor.white
        self.floatyButton.selectedColor = UIColor.gray999
        self.floatyButton.sticky = true
        self.floatyButton.addItem("오늘의 질문", icon: UIImage(named: "Home_Write.png")) { item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeView = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeBeforeViewController
            guard let homeVC = homeView else { return }
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
        self.floatyButton.addItem("자문 자답", icon: UIImage(named: "Question.png")) { item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let advisoryAnswerView = storyboard.instantiateViewController(withIdentifier: "AdvisoryAnswerVC") as? AdvisoryAnswerViewController
            guard let advisoryAnswerVC = advisoryAnswerView else { return }
            self.navigationController?.pushViewController(advisoryAnswerVC, animated: true)
        }
        self.floatyButton.addItem("내 피드", icon: UIImage(named: "icoFeed.png")) { item in
            let moreVC = SocialMoreContentViewController(nibName: "SocialMoreContentViewController", bundle: nil)
            moreVC.state = .none
            self.navigationController?.pushViewController(moreVC, animated: true)
        }
    }
    
    private func configureNavigation() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu_white.png"), style: .plain, target: self, action: #selector(menuIconDidTap))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationController?.navigationBar.tintColor = .white
        
        self.title = "자문자답"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 18)]
    }
    
    private func setSideMenuLayoutInit() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sideOnlyViewController: SideOnlyViewController = storyboard.instantiateViewController(withIdentifier: "SideOnlyViewController") as! SideOnlyViewController
        self.sideMenu = SideMenuNavigationController(rootViewController: sideOnlyViewController)
        self.sideMenu?.leftSide = true
    }
    
    private func getAnswerList() {
        AdvisoryApiService.getAdvisoryAnswerList { list in
            if let list = list {
                print(list)
                self.answerLists = list.themeLists
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
                cell.stageLabel.textColor = .gray333
                cell.finishView.image = UIImage(named: "circle-checked.png")
            } else {
                let attributedString = NSMutableAttributedString(string: rate,
                                                                 attributes: [.foregroundColor: UIColor.gray333])
                attributedString.append(NSAttributedString(string: "/10",
                                                           attributes: [.foregroundColor: UIColor.gray777]))
                cell.stageLabel.attributedText = attributedString
                cell.finishView.image = UIImage(named: "ico_common_24_complete_off.png")
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
        let stageVC = AdvisoryStageViewController(nibName: "AdvisoryStageViewController", bundle: nil)
        stageVC.themeList = answerLists[indexPath.row]
        self.navigationController?.pushViewController(stageVC, animated: true)
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
