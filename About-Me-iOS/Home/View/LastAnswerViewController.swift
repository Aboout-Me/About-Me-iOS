//
//  LastAnswerViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/05/06.
//

import UIKit
import Floaty
class LastAnswerViewController: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var answerFloatingButton: Floaty!
    @IBOutlet weak var answerCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLastAnswerLayoutInit()
    }
    
    private func setLastAnswerLayoutInit() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ArrowLeft"), style: .plain, target: self, action: #selector(self.navigationButtonDidTap(_:)))
        self.navigationItem.title = "나의 지난 응답"
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18)]
        self.backgroundImageView.image = UIImage(named: "imgBackgroundYellow.png")
        self.answerCollectionView.delegate = self
        self.answerCollectionView.dataSource = self
        let nib = UINib(nibName: "LastAnswerCollectionViewCell", bundle: nil)
        self.answerCollectionView.register(nib, forCellWithReuseIdentifier: "LastAnswerCell")
        self.answerCollectionView.backgroundColor = .clear
        self.answerFloatingButton.buttonColor = .black
        self.answerFloatingButton.selectedColor = UIColor.gray999
        self.answerFloatingButton.plusColor = .white
        self.answerFloatingButton.addItem("오늘의 질문", icon: UIImage(named: "Home_Write.png"))
        self.answerFloatingButton.addItem("자문 자답", icon: UIImage(named: "Question.png")) { item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let advisoryAnswerView = storyboard.instantiateViewController(withIdentifier: "AdvisoryAnswerVC") as? AdvisoryAnswerViewController
            guard let advisoryAnswerVC = advisoryAnswerView else { return }
            self.navigationController?.pushViewController(advisoryAnswerVC, animated: true)
        }
        self.answerFloatingButton.addItem("내 피드", icon: UIImage(named: "icoFeed.png"))
    }
    
    @objc
    private func navigationButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension LastAnswerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let answerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastAnswerCell", for: indexPath) as! LastAnswerCollectionViewCell
        answerCell.answerCharacterLabel.text = "소소한일상"
        answerCell.answerQuestionLabel.text = "인생의 가장 큰 목표는  무엇인가요?"
        answerCell.answerRankLabel.text = "Level 2"
        
        return answerCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.size.width - 40, height: 367)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
    }
    
    
}
