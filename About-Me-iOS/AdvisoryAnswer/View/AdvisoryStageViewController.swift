//
//  AdvisoryStageViewController.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/17.
//

import UIKit

class AdvisoryStageViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentTableView: UITableView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    var themeList: ThemeList?
    var lastStage: Int = 0
    var detailList: [AdvisoryAnswerList]?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        getDetailList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getDetailList()
    }
    
    // MARK: - Selectors
    
    @objc
    private func backButtonDidTap(_ sender: UIButton) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func nextButtonDidTap(_ sender: UIButton) {
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
        
        var questionDictionary: [Int: String] = [:]
        var answerDictionary: [Int: String] = [:]
        var editList: [Int] = []
        
        for (index, detail) in detailList!.enumerated() {
            questionDictionary[index + 1] = detail.question
            answerDictionary[index + 1] = detail.answer
            editList.append(index + 1)
        }
        
        questionVC.questionNumber = detailList!.count
        questionVC.advisoryBeforeTitle = themeList!.stage_name
        questionVC.advisoryTitle = themeList!.stage_name
        questionVC.questionDictionary = questionDictionary
        questionVC.answerDictionary = answerDictionary
        questionVC.mode = .ongoing
        questionVC.stage = Int(themeList!.stage_num)!
        questionVC.editList = editList
        
        self.navigationController?.pushViewController(questionVC, animated: false)
    }
    // MARK: - Helpers
    
    private func configure() {
        self.navigationController?.isNavigationBarHidden = true
        
        let stageNib = UINib(nibName: "AdvisoryStageCell", bundle: nil)
        self.contentTableView.register(stageNib, forCellReuseIdentifier: "advisoryStageCell")
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .solidF9F9F9
        self.contentTableView.backgroundColor = .solidF9F9F9
        
        self.backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        self.titleLabel.text = themeList?.stage_name
        
        self.contentTableView.dataSource = self
        self.contentTableView.delegate = self
        
        self.nextButton.layer.cornerRadius = 25
        self.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        self.nextButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.nextButton.layer.shadowRadius = 12
        self.nextButton.layer.shadowOpacity = 0.12
        self.lastStage = Int(themeList!.rate.components(separatedBy: " /")[0]) ?? 0
    }
    
    private func getDetailList() {
        AdvisoryApiService.getAdvisoryDetailList(stage: Int(themeList!.stage_num)!, theme: themeList!.stage_name) { detailList in
            print(detailList)
            // TODO: code check
            self.detailList = detailList.answerLists
            self.contentTableView.reloadData()
        }
    }
}

extension AdvisoryStageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let detailList = self.detailList {
            return detailList.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "advisoryStageCell", for: indexPath)
                as? AdvisoryStageCell else {
            return UITableViewCell()
        }
        if let detailList = detailList {
            cell.setValues(answer: detailList[indexPath.row], totalCount: detailList.count)
        }
        return cell
    }
}

extension AdvisoryStageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
