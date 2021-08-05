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
    public var answerId: Int = 0
    public var questId: Int = 0
    private var screenSize = UIScreen.main.bounds.size
    private var lastAnswerData = [LastAnswerListModel]()
    private var selectedIndex = 0
    public var isLastShare = "N"
    
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
        editView?.tag = 1
        return editView!
    }()
    
    
    lazy var postBottomView: PostBottomSheetView = {
        let postView = Bundle.main.loadNibNamed("PostBottomSheetView", owner: self, options: nil)?.first as? PostBottomSheetView
        postView?.frame = CGRect(x: self.view.frame.origin.x, y: self.screenSize.height, width: self.view.frame.size.width, height: postView!.frame.size.height)
        postView?.tag = 3
        return postView!
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLastAnswerCardList()
        setLastAnswerLayoutInit()
        print("test \(questId)")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setLastAnswerLayoutInit() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ArrowLeft"), style: .plain, target: self, action: #selector(LastAnswerViewController.navigationButtonDidTap(_:)))
        self.navigationItem.title = "나의 지난 응답"
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18)]
        backgroundImageView.image = UIImage(named: "imgBackgroundYellow.png")
        answerCollectionView.delegate = self
        answerCollectionView.dataSource = self
        let nib = UINib(nibName: "LastAnswerCollectionViewCell", bundle: nil)
        answerCollectionView.register(nib, forCellWithReuseIdentifier: "LastAnswerCell")
        answerCollectionView.backgroundColor = .clear
        answerFloatingButton.buttonColor = .black
        answerFloatingButton.selectedColor = UIColor.gray999
        answerFloatingButton.plusColor = .white
        answerFloatingButton.sticky = true
        answerFloatingButton.addItem("오늘의 질문", icon: UIImage(named: "Home_Write.png")) { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeBeforeView = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeBeforeViewController
            guard let homeBeforeVC = homeBeforeView else { return }
            self.navigationController?.pushViewController(homeBeforeVC, animated: true)
        }
        answerFloatingButton.addItem("자문 자답", icon: UIImage(named: "Question.png")) { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let advisoryAnswerView = storyboard.instantiateViewController(withIdentifier: "AdvisoryAnswerVC") as? AdvisoryAnswerViewController
            guard let advisoryAnswerVC = advisoryAnswerView else { return }
            self.navigationController?.pushViewController(advisoryAnswerVC, animated: true)
        }
        answerFloatingButton.addItem("내 피드", icon: UIImage(named: "icoFeed.png")) { _ in
            let moreVC = SocialMoreContentViewController(nibName: "SocialMoreContentViewController", bundle: nil)
            moreVC.state = .none
            self.navigationController?.pushViewController(moreVC, animated: true)
        }
    }
    
    public func setBottomSheetViewLayout() {
        answerEditBottomView.layer.masksToBounds = true
        answerEditBottomView.layer.cornerRadius = 10
        answerEditBottomView.gestureView.layer.masksToBounds = true
        answerEditBottomView.gestureView.layer.cornerRadius = 10
        answerEditBottomView.editButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        answerEditBottomView.cancelButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        answerEditBottomView.deleteButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideEditBottomSheetView(_:)))
        containerView.addGestureRecognizer(gesture)
        
        answerEditBottomView.editButton.addTarget(self, action: #selector(editButtonDidTap(_:)), for: .touchUpInside)
        answerEditBottomView.cancelButton.addTarget(self, action: #selector(cancelButtonDidTap(_:)), for: .touchUpInside)
        answerEditBottomView.deleteButton.addTarget(self, action: #selector(deleteButtonDidTap(_:)), for: .touchUpInside)
        
        let window = UIApplication.shared.windows.first
        window?.addSubview(containerView)
        window?.addSubview(answerEditBottomView)
    }
    
    public func setPostBottomSheetViewLayout() {
        let editToolbar = UIToolbar()
        let fiexedbarButtonItem = UIBarButtonItem(systemItem: .flexibleSpace)
        let donebarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.postToolBarButtonDidTap))
        editToolbar.items = [fiexedbarButtonItem,donebarButtonItem]
        editToolbar.sizeToFit()
        postBottomView.layer.masksToBounds = true
        postBottomView.layer.cornerRadius = 20
        postBottomView.postNavigationTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        postBottomView.postNavigationTitleLabel.textAlignment = .center
        postBottomView.postNumberLabel.font = UIFont(name: "GmarketSansMedium", size: 18)
        postBottomView.postNumberLabel.text = "Q. "
        postBottomView.postNumberLabel.textColor = .gray333
        postBottomView.postNumberLabel.textAlignment = .left
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        let attributedText = NSAttributedString(string: "인생의 가장 큰 목표는 무엇인가요? 인생의 가장 큰 목표는 무엇인가요?", attributes: [.paragraphStyle: paragraphStyle,.font: UIFont(name: "GmarketSansMedium", size: 20),.foregroundColor: UIColor.gray333])
        postBottomView.postQuestionLabel.numberOfLines = 0
        postBottomView.postQuestionLabel.attributedText = attributedText
        postBottomView.postAnswerTextView.delegate = self
        postBottomView.postAnswerTextView.textAlignment = .left
        postBottomView.postAnswerTextView.text = "당신의 생각을 말해주세요"
        postBottomView.postAnswerTextView.textColor = .gray999
        postBottomView.postAnswerTextView.inputAccessoryView = editToolbar
        postBottomView.postShareButton.isSelected = false
        postBottomView.postShareButton.setImage(UIImage(named: "UnLockBlack"), for: .normal)
        postBottomView.postCancelButton.addTarget(self, action: #selector(postCancelButtonDidTap(_:)), for: .touchUpInside)
        postBottomView.postShareButton.addTarget(self, action: #selector(postShareButtonDidTap(_:)), for: .touchUpInside)
        postBottomView.postConfirmButton.addTarget(self, action: #selector(postConfirmButtonDidTap(_:)), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(LastAnswerViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LastAnswerViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    
    private func getLastAnswerCardList() {
        let parameter = [
            "user_id" : 1,
            "quest_id" : questId
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
    
    private func putLastAnswerCardList() {
        let parameter = HomeCardEditParamter(answer: self.postBottomView.postAnswerTextView.text ?? "", category_seq: self.lastAnswerData[selectedIndex].cardSeq, level: self.lastAnswerData[selectedIndex].level, share: self.isLastShare)
        print("data 1 \(self.lastAnswerData[selectedIndex].quest_id)")
        HomeServerApi.putHomeCardList(parameter: parameter) { result in
            if case let .success(data) = result ,let _ = data {
                DispatchQueue.main.async {
                    self.getLastAnswerCardList()
                }
            }
        }
    }
    
    private func deleteLastAnswerCardList() {
        HomeServerApi.deleteHomeCardList(seq: self.lastAnswerData[selectedIndex].cardSeq) { result in
            if case let .success(data) = result, let _ = data {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc
    public func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardEndFrame = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardEndFrame.height
            let caret = self.postBottomView.postAnswerTextView.caretRect(for: self.postBottomView.postAnswerTextView.selectedTextRange!.start)
            postBottomView.postTextViewBottomConstraint.constant = keyboardHeight + 120
            postBottomView.postAnswerTextView.scrollRectToVisible(caret, animated: true)
            postBottomView.postAnswerTextView.contentInset.bottom = 10
            postBottomView.layoutIfNeeded()
            
        }
    }
    
    @objc
    public func keyboardWillHide(_ notification: Notification) {
        if postBottomView.postAnswerTextView.bounds.height < postBottomView.postAnswerTextView.frame.size.height {
            postBottomView.postTextViewBottomConstraint.constant = 15
        } else {
            postBottomView.postTextViewBottomConstraint.constant = postBottomView.postAnswerTextView.bounds.height
        }
        postBottomView.postAnswerTextView.contentInset.bottom = 10
        postBottomView.layoutIfNeeded()
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
    private func cancelButtonDidTap(_ sender: UIButton) {
        let window = UIApplication.shared.windows.first
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            if let cancelView = window?.viewWithTag(2) {
                cancelView.removeFromSuperview()
            }
            self.answerEditBottomView.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: 224 + self.view.safeAreaInsets.bottom)
        }, completion: nil)
    }
    
    @objc
    private func deleteButtonDidTap(_ sender: UIButton) {
        let window = UIApplication.shared.windows.first
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            if let deleteView = window?.viewWithTag(2) {
                deleteView.removeFromSuperview()
            }
            self.answerEditBottomView.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: 224 + self.view.safeAreaInsets.bottom)
        } completion: { success in
            if success {
                self.deleteLastAnswerCardList()
            }
        }

    }
    
    @objc
    private func editButtonDidTap(_ sender: UIButton) {
        let height = self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let window = UIApplication.shared.windows.first
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            if let view = window?.viewWithTag(2){
                view.removeFromSuperview()
            }
            self.answerEditBottomView.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: 224)
        } completion: { success in
            if success {
                window?.addSubview(self.postBottomView)
                self.setPostBottomSheetViewLayout()
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                    self.postBottomView.frame = CGRect(x: 0, y: self.screenSize.height - (self.screenSize.height - height - 12), width: self.screenSize.width, height: self.screenSize.height + height + 12)
                }, completion: nil)
            }
        }
    }
    
    @objc
    private func postCancelButtonDidTap(_ sender: UIButton) {
        let alert = UIAlertController(title: "작성중인 내용을 \n완료하지 않고 나가시겠습니까?", message: nil, preferredStyle: .alert)
        let alertCancel = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        let alertConfirm = UIAlertAction(title: "네", style: .default) { _ in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.postBottomView.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: self.screenSize.height)
            }, completion: nil)
        }
        alert.addAction(alertCancel)
        alert.addAction(alertConfirm)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc
    private func postShareButtonDidTap(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            isLastShare = "N"
            postBottomView.postShareButton.setImage(UIImage(named: "UnLockBlack"), for: .normal)
            
        } else {
            sender.isSelected = true
            isLastShare = "Y"
            postBottomView.postShareButton.setImage(UIImage(named: "lockBlack"), for: .selected)
        }
    }
    
    @objc
    private func postConfirmButtonDidTap(_ sender: UIButton) {
        postBottomView.postAnswerTextView.resignFirstResponder()
        putLastAnswerCardList()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.postBottomView.frame = CGRect(x: self.view.frame.origin.x, y: self.screenSize.height, width: self.screenSize.width, height: self.screenSize.height)
        }, completion: nil)
    }
    
    
    @objc
    private func navigationButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func postToolBarButtonDidTap() {
        postBottomView.endEditing(true)
    }
}


extension LastAnswerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return lastAnswerData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let answerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastAnswerCell", for: indexPath) as! LastAnswerCollectionViewCell
        
        if lastAnswerData[indexPath.item].color == "red" {
            answerCell.answerCharacterLabel.text = "열정 충만"
            answerCell.answerCharacterView.backgroundColor = .primaryRed
        } else if lastAnswerData[indexPath.item].color == "yellow" {
            answerCell.answerCharacterLabel.text = "소소한일상"
            answerCell.answerCharacterView.backgroundColor = .primaryYellow
        } else if lastAnswerData[indexPath.item].color == "green" {
            answerCell.answerCharacterLabel.text = "기억상자"
            answerCell.answerCharacterView.backgroundColor = .primaryGreen
        } else if lastAnswerData[indexPath.item].color == "pink" {
            answerCell.answerCharacterLabel.text = "관계의 미학"
            answerCell.answerCharacterView.backgroundColor = .primaryPink
        } else {
            answerCell.answerCharacterLabel.text = "상상 플러스"
            answerCell.answerCharacterView.backgroundColor = .primaryPurple
        }
        answerCell.answerQuestionLabel.text = "\(lastAnswerData[indexPath.item].question)"
        answerCell.answerRankLabel.text = "Level \(lastAnswerData[indexPath.item].level)"
        answerCell.answerContentLabel.text = "\(lastAnswerData[indexPath.item].answer)"
        answerCell.editButtonClousr = {
            self.setBottomSheetViewLayout()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.answerEditBottomView.frame = CGRect(x: 0, y: self.screenSize.height - 224, width: self.screenSize.width, height: 224 + self.view.safeAreaInsets.bottom)
            })
        }
        
        return answerCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        let lastAnswerVC = SocialDetailViewController(nibName: "SocialDetailViewController", bundle: nil)
        lastAnswerVC.answerId = lastAnswerData[indexPath.item].answer_id
        lastAnswerVC.title = "" // TODO - MyNickname
        lastAnswerVC.authorId = 1
        self.navigationController?.pushViewController(lastAnswerVC, animated: true)
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

extension LastAnswerViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        if textView.textColor == .gray999 {
            postBottomView.postConfirmButton.isEnabled = true
            textView.text = nil
            textView.textAlignment = .left
            textView.typingAttributes = [.paragraphStyle: paragraphStyle,.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 16),.foregroundColor: UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)]
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            postBottomView.postConfirmButton.isEnabled = false
            textView.text = "당신의 생각을 말해주세요"
            textView.textColor = .gray999
        }
    }
}
