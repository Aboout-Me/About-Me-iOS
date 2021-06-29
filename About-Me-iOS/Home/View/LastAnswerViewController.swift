//
//  LastAnswerViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/05/06.
//

import UIKit
import Floaty
class LastAnswerViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var answerFloatingButton: Floaty!
    @IBOutlet weak var answerCollectionView: UICollectionView!
    public var answerId: Int = 0
    private var screenSize = UIScreen.main.bounds.size
    private var lastAnswerData = [LastAnswerListModel]()
    
    lazy var containerView: UIView = {
        let dimView = UIView(frame: self.view.frame)
        dimView.isOpaque = false
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimView.tag = 2
        return dimView
    }()
    
    
    lazy var answerEditBottomView: EditBottomSheetView = {
        let editView = Bundle.main.loadNibNamed("EditBottomSheetView", owner: self, options: nil)?.first as? EditBottomSheetView
        editView?.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: 224)
        return editView!
    }()
    
    
    lazy var postBottomView: PostBottomSheetView = {
        let postView = Bundle.main.loadNibNamed("PostBottomSheetView", owner: self, options: nil)?.first as? PostBottomSheetView
        postView?.frame = CGRect(x: self.view.frame.origin.x, y: self.screenSize.height, width: self.view.frame.size.width, height: postView!.frame.size.height)
        return postView!
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getLastAnswerCardList()
        self.setLastAnswerLayoutInit()
        self.view.addSubview(postBottomView)
        self.setPostBottomSheetViewLayout()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.postBottomView.frame = CGRect(x: 0, y: self.screenSize.height - self.screenSize.height / 1.05, width: self.screenSize.width, height: self.postBottomView.frame.size.height + self.view.safeAreaInsets.bottom)
        })
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
    
    public func setBottomSheetViewLayout() {
        self.answerEditBottomView.layer.masksToBounds = true
        self.answerEditBottomView.layer.cornerRadius = 10
        self.answerEditBottomView.gestureView.layer.masksToBounds = true
        self.answerEditBottomView.gestureView.layer.cornerRadius = 10
        self.answerEditBottomView.editButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        self.answerEditBottomView.cancelButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        self.answerEditBottomView.deleteButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideEditBottomSheetView(_:)))
        self.containerView.addGestureRecognizer(gesture)
        self.answerEditBottomView.cancelButton.addTarget(self, action: #selector(cancelEditButtonDidTap(_:)), for: .touchUpInside)
        self.answerEditBottomView.deleteButton.addTarget(self, action: #selector(deleteEditButtonDidTap(_:)), for: .touchUpInside)
        
        let window = UIApplication.shared.windows.first
        window?.addSubview(self.containerView)
        window?.addSubview(self.answerEditBottomView)
    }
    
    public func setPostBottomSheetViewLayout() {
        let editToolbar = UIToolbar()
        let fiexedbarButtonItem = UIBarButtonItem(systemItem: .flexibleSpace)
        let donebarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.postToolBarButtonDidTap))
        editToolbar.items = [fiexedbarButtonItem,donebarButtonItem]
        editToolbar.sizeToFit()
        self.postBottomView.layer.masksToBounds = true
        self.postBottomView.layer.cornerRadius = 20
        self.postBottomView.postNavigationTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        self.postBottomView.postNavigationTitleLabel.textAlignment = .center
        self.postBottomView.postNumberLabel.font = UIFont(name: "GmarketSansMedium", size: 18)
        self.postBottomView.postNumberLabel.text = "Q. "
        self.postBottomView.postNumberLabel.textColor = .gray333
        self.postBottomView.postNumberLabel.textAlignment = .left
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        let attributedText = NSAttributedString(string: "인생의 가장 큰 목표는 무엇인가요? 인생의 가장 큰 목표는 무엇인가요?", attributes: [.paragraphStyle: paragraphStyle,.font: UIFont(name: "GmarketSansMedium", size: 20),.foregroundColor: UIColor.gray333])
        self.postBottomView.postQuestionLabel.numberOfLines = 0
        self.postBottomView.postQuestionLabel.attributedText = attributedText
        self.postBottomView.postAnswerTextView.delegate = self
        self.postBottomView.postAnswerTextView.textAlignment = .left
        self.postBottomView.postAnswerTextView.text = "당신의 생각을 말해주세요"
        self.postBottomView.postAnswerTextView.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        self.postBottomView.postAnswerTextView.inputAccessoryView = editToolbar
        
    }
    
    
    
    private func getUtilList() {
        let parameter = [
            "answer_id" : 97,
            "user_id" : 1
        ]
        UtilApi.getDetailList(parameter: parameter) { result in
            if case let .success(data) = result, let list = data {
                print(list)
            }
        }
    }
    
    private func getLastAnswerCardList() {
        let parameter = [
            "answer_id" : 97
        ]
        
        HomeServerApi.getLastAnswerCardList(parameter: parameter) { result in
            if case let .success(data) = result, let list = data {
                print(list)
                self.lastAnswerData = list.postList
                DispatchQueue.main.async {
                    if self.lastAnswerData[0].color == "red" {
                        self.backgroundImageView.image = UIImage(named: "imgBackgroundRed")
                    } else if self.lastAnswerData[0].color == "yellow" {
                        self.backgroundImageView.image = UIImage(named: "imgBackgroundYellow")
                    } else if self.lastAnswerData[0].color == "green" {
                        self.backgroundImageView.image = UIImage(named: "imgBackgroundGreen")
                    } else if self.lastAnswerData[0].color == "pink" {
                        self.backgroundImageView.image = UIImage(named: "imgBackgroundPink")
                    } else {
                        self.backgroundImageView.image = UIImage(named: "imgBackgroundViolet")
                    }
                    self.answerCollectionView.reloadData()
                }
            }
        }
    }
    
    @objc
    private func hideEditBottomSheetView(_ gesture: UITapGestureRecognizer) {
        let window = UIApplication.shared.windows.first
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            if let removeView = window?.viewWithTag(2) {
                removeView.removeFromSuperview()
            }
            self.answerEditBottomView.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: 224 + self.view.safeAreaInsets.bottom)
        }, completion: nil)
    }
    
    @objc
    private func cancelEditButtonDidTap(_ sender: UIButton) {
        let window = UIApplication.shared.windows.first
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            if let cancelView = window?.viewWithTag(2) {
                cancelView.removeFromSuperview()
            }
            self.answerEditBottomView.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: 224 + self.view.safeAreaInsets.bottom)
        }, completion: nil)
    }
    
    @objc
    private func deleteEditButtonDidTap(_ sender: UIButton) {
        let window = UIApplication.shared.windows.first
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            if let deleteView = window?.viewWithTag(2) {
                deleteView.removeFromSuperview()
            }
            self.answerEditBottomView.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: 224 + self.view.safeAreaInsets.bottom)
        } completion: { success in
            if success {
               // TO DO: answerId
                
            }
        }

    }
    
    
    @objc
    private func navigationButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func postToolBarButtonDidTap() {
        self.postBottomView.endEditing(true)
    }
    
}


extension LastAnswerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.lastAnswerData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let answerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastAnswerCell", for: indexPath) as! LastAnswerCollectionViewCell
        
        if self.lastAnswerData[indexPath.item].color == "red" {
            answerCell.answerCharacterLabel.text = "열정 충만"
        } else if self.lastAnswerData[indexPath.item].color == "yellow" {
            answerCell.answerCharacterLabel.text = "소소한일상"
        } else if self.lastAnswerData[indexPath.item].color == "green" {
            answerCell.answerCharacterLabel.text = "기억상자"
        } else if self.lastAnswerData[indexPath.item].color == "pink" {
            answerCell.answerCharacterLabel.text = "관계의 미학"
        } else {
            answerCell.answerCharacterLabel.text = "상상 플러스"
        }
        answerCell.answerQuestionLabel.text = "\(self.lastAnswerData[indexPath.item].question)"
        answerCell.answerRankLabel.text = "Level \(self.lastAnswerData[indexPath.item].level)"
        answerCell.answerContentLabel.text = "\(self.lastAnswerData[indexPath.item].answer)"
        answerCell.editButtonClousr = {
            self.setBottomSheetViewLayout()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.answerEditBottomView.frame = CGRect(x: 0, y: self.screenSize.height - 224, width: self.screenSize.width, height: 224 + self.view.safeAreaInsets.bottom)
            })
        }
        
        return answerCell
    }
    
    // TO DO :
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    
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
