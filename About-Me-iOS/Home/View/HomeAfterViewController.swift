//
//  HomeAfterViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/19.
//

import UIKit
import Floaty
import SideMenu

class HomeAfterViewController: UIViewController,SideMenuNavigationControllerDelegate {
    @IBOutlet weak var homeAfterCollectionView: UICollectionView!
    @IBOutlet weak var homeAfterFloaingButton: Floaty!
    @IBOutlet weak var homeAfterBackgroundImageView: UIImageView!
    @IBOutlet weak var homeAfterLastAnswerButton: UIButton!
    public var afterSideMenu: SideMenuNavigationController?
    public var titleText: String = ""
    public var backgroundColor: String = ""
    public var answerLevel: String = ""
    public var screenSize = UIScreen.main.bounds.size
    public var isAfterShare = "N"
    public var homeAfterModel = [LastAnswerListModel]()
    private var homeAfterData: SocialDetailResponse? = nil
    
    lazy var editBottomContainerView: UIView = {
        let containerView = UIView(frame: self.view.frame)
        containerView.isOpaque = false
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        containerView.tag = 1
        return containerView
    }()
    
    
    lazy var answerBottomSheetView: PostBottomSheetView = {
        let answerSheetView = Bundle.main.loadNibNamed("PostBottomSheetView", owner: self, options: nil)?.first as? PostBottomSheetView
        answerSheetView?.frame = CGRect(x: self.view.frame.origin.x, y: self.screenSize.height, width: self.screenSize.width, height: answerSheetView!.frame.size.height)
        answerSheetView?.postAnswerTextView.delegate = self
        answerSheetView?.postCancelButton.addTarget(self, action: #selector(self.hideAnswerBottomSheetDidTap), for: .touchUpInside)
        answerSheetView?.postConfirmButton.addTarget(self, action: #selector(self.confirmEditViewButtonDidTap), for: .touchUpInside)
        answerSheetView?.postShareButton.addTarget(self, action: #selector(self.shareEditViewButtonDidTap(_:)), for: .touchUpInside)
        return answerSheetView!
    }()
    
    lazy var editBottomView: EditBottomSheetView = {
        let editView = Bundle.main.loadNibNamed("EditBottomSheetView", owner: self, options: nil)?.first as? EditBottomSheetView
        editView?.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: 224)
        return editView!
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayoutInit()
        self.setSideMenuLayoutInit()
        self.getUtilList()
    }
    
    
    private func setLayoutInit() {
        let cellWidth = floor(view.frame.width * 0.85)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: 420)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateString = dateFormatter.string(from: date)
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu.png"), style: .plain, target: self, action: #selector(self.showAfterSideButtonDidTap))
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Bell"), style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.title = dateString
        self.homeAfterCollectionView.delegate = self
        self.homeAfterCollectionView.dataSource = self
        self.homeAfterCollectionView.backgroundColor = .clear
        self.homeAfterCollectionView.collectionViewLayout = layout
        let nib = UINib(nibName: "HomeAfterCollectionViewCell", bundle: nil)
        self.homeAfterCollectionView.register(nib, forCellWithReuseIdentifier: "HomeAfterCell")
        self.homeAfterFloaingButton.buttonColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.homeAfterFloaingButton.plusColor = UIColor.white
        self.homeAfterFloaingButton.selectedColor = UIColor.gray999
        self.homeAfterFloaingButton.sticky = true
        self.homeAfterLastAnswerButton.setTitle("같은 질문 지난 응답 확인하기", for: .normal)
        self.homeAfterLastAnswerButton.setTitleColor(UIColor.gray333, for: .normal)
        self.homeAfterLastAnswerButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        self.homeAfterLastAnswerButton.backgroundColor = .white
        self.homeAfterLastAnswerButton.layer.cornerRadius = 15
        self.homeAfterLastAnswerButton.layer.masksToBounds = true
        self.homeAfterFloaingButton.addItem("오늘의 질문", icon: UIImage(named: "Write.png"))
        self.homeAfterFloaingButton.addItem("자문 자답", icon: UIImage(named: "SelfQuestion.png")) { item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let advisoryAnswerView = storyboard.instantiateViewController(withIdentifier: "AdvisoryAnswerVC") as? AdvisoryAnswerViewController
            guard let advisoryAnswerVC = advisoryAnswerView else { return }
            self.navigationController?.pushViewController(advisoryAnswerVC, animated: true)
        }
        self.homeAfterFloaingButton.addItem("내 피드", icon: UIImage(named: "Feed.png")) { _ in
            let moreVC = SocialMoreContentViewController(nibName: "SocialMoreContentViewController", bundle: nil)
            moreVC.state = .none
            self.navigationController?.pushViewController(moreVC, animated: true)
        }

    }
    
    
    private func setSideMenuLayoutInit() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sideOnlyViewController: SideOnlyViewController = storyboard.instantiateViewController(withIdentifier: "SideOnlyViewController") as! SideOnlyViewController
        self.afterSideMenu = SideMenuNavigationController(rootViewController: sideOnlyViewController)
        self.afterSideMenu?.leftSide = true
    }
    
    
    private func editBottomSheetLayoutInit() {
        self.editBottomView.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: 224)
        self.editBottomView.gestureView.layer.cornerRadius = 10
        self.editBottomView.gestureView.layer.masksToBounds = true
        self.editBottomView.layer.cornerRadius = 10
        self.editBottomView.layer.masksToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideEditBottomSheetGestureAction(recognizer:)))
        self.editBottomContainerView.addGestureRecognizer(tapGesture)
        self.editBottomView.editButton.addTarget(self, action: #selector(self.homeAfterEditButtonDidTap(_:)), for: .touchUpInside)
        self.editBottomView.deleteButton.addTarget(self, action: #selector(self.homeAfterDeleteButtonDidTap(_:)), for: .touchUpInside)
        self.editBottomView.cancelButton.addTarget(self, action: #selector(self.homeAfterCancelButtonDidTap(_:)), for: .touchUpInside)
    }
    
    
    public func answerEditBottomSheetLayoutInit() {
        let paragraphStyle = NSMutableParagraphStyle()
        let editToolbar = UIToolbar()
        let screenSize = UIScreen.main.bounds.size
        paragraphStyle.lineSpacing = 4
        let fiexedbarButtonItem = UIBarButtonItem(systemItem: .flexibleSpace)
        let donebarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.toolbarButtonDidTap))
        editToolbar.items = [fiexedbarButtonItem,donebarButtonItem]
        editToolbar.sizeToFit()
        self.answerBottomSheetView.postNumberLabel.text = "Q. "
        self.answerBottomSheetView.postNumberLabel.textColor = .gray333
        self.answerBottomSheetView.postNumberLabel.font = UIFont(name: "GmarketSansMedium", size: 18)
        self.answerBottomSheetView.postNumberLabel.textAlignment = .left
        self.answerBottomSheetView.postQuestionLabel.attributedText = NSAttributedString(string: "\(self.titleText)", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        self.answerBottomSheetView.postQuestionLabel.textColor = .gray333
        self.answerBottomSheetView.postQuestionLabel.textAlignment = .left
        self.answerBottomSheetView.postQuestionLabel.font = UIFont(name: "GmarketSansMedium", size: 20)
        self.answerBottomSheetView.postQuestionLabel.numberOfLines = 0
        self.answerBottomSheetView.postQuestionLabel.sizeToFit()
        self.answerBottomSheetView.postAnswerTextView.text = "당신의 생각을 말해주세요"
        self.answerBottomSheetView.postAnswerTextView.textColor = .gray999
        self.answerBottomSheetView.postConfirmButton.isEnabled = false
        self.answerBottomSheetView.postAnswerTextView.inputAccessoryView = editToolbar
        self.answerBottomSheetView.layer.cornerRadius = 20
        self.answerBottomSheetView.layer.masksToBounds = true
        NotificationCenter.default.addObserver(self, selector: #selector(HomeAfterViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeAfterViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func deleteHomeCardList() {
        print(UserDefaults.standard.integer(forKey: "homeBeforeSeq"))
        HomeServerApi.deleteHomeCardList(seq: UserDefaults.standard.integer(forKey: "homeBeforeSeq")) { result in
            if case let .success(data) = result, let list = data {
                print(list)
                self.navigationController?.popViewController(animated: true)
            } else if case let .failure(error) = result {
                let alert = UIAlertController(title: "Delete Error Message", message: error, preferredStyle: .alert)
                let alertButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(alertButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func editHomeCardList() {
        let parameter = HomeCardEditParamter(answer: self.answerBottomSheetView.postAnswerTextView.text ?? "", category_seq: UserDefaults.standard.integer(forKey: "homeBeforeSeq"), level: UserDefaults.standard.integer(forKey: "homeBeforeLevel"), share: isAfterShare)
        HomeServerApi.putHomeCardList(parameter: parameter) { result in
            if case let .success(data) = result, let list = data {
                print(list)
                self.titleText = list.dailyLists[0].question
                UserDefaults.standard.set(list.dailyLists[0].answer, forKey: "myQuestionText")
                self.getUtilList()
            } else if case let .failure(error) = result {
                let alert = UIAlertController(title: "Put Error Message", message: error, preferredStyle: .alert)
                let alertButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(alertButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func getUtilList() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            SocialApiService.getSocialDetail(answerId: UserDefaults.standard.integer(forKey: "homeBeforeSeq"), authorId: 1) { detailResponse in
                DispatchQueue.main.async {
                    self.homeAfterData = detailResponse!
                    if self.homeAfterData?.post.color == "red" {
                        self.homeAfterBackgroundImageView.image = UIImage(named: "imgBackgroundRed.png")
                    } else if self.homeAfterData?.post.color == "yellow" {
                        self.homeAfterBackgroundImageView.image = UIImage(named: "imgBackgroundYellow.png")
                    } else if self.homeAfterData?.post.color == "green" {
                        self.homeAfterBackgroundImageView.image = UIImage(named: "imgBackgroundGreen.png")
                    } else if self.homeAfterData?.post.color == "pink" {
                        self.homeAfterBackgroundImageView.image = UIImage(named: "imgBackgroundPink.png")
                    } else if self.homeAfterData?.post.color == "purple" {
                        self.homeAfterBackgroundImageView.image = UIImage(named: "imgBackgroundViolet.png")
                    }
                    
                    if self.homeAfterData?.post.level == 1 {
                        self.homeAfterLastAnswerButton.isHidden = true
                    } else {
                        self.homeAfterLastAnswerButton.isHidden = false
                    }
                    self.homeAfterCollectionView.reloadData()
                }
                print("get UtilList Data\(self.homeAfterData)")
            }
        }
    }
    
    @objc
    private func hideAnswerBottomSheetDidTap() {
        let screenSize = UIScreen.main.bounds.size
        let alert = UIAlertController(title: "작성중인 내용을 \n완료하지 않고 나가시겠습니까?", message: nil, preferredStyle: .alert)
        let alertCancelButton = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        let alertConfirmButton = UIAlertAction(title: "네", style: .default) { _ in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.answerBottomSheetView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height)
            })
        }
        alert.addAction(alertCancelButton)
        alert.addAction(alertConfirmButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc
    private func confirmEditViewButtonDidTap() {
        let screenSize = UIScreen.main.bounds.size
        self.answerBottomSheetView.postAnswerTextView.resignFirstResponder()
        self.editHomeCardList()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.answerBottomSheetView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height)
        })
    }
    
    @objc
    private func shareEditViewButtonDidTap(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            isAfterShare = "N"
            self.answerBottomSheetView.postShareButton.setImage(UIImage(named: "UnLockBlack"), for: .normal)
            UserDefaults.standard.set(sender.isSelected, forKey: "isshareValue")
        } else {
            sender.isSelected = true
            isAfterShare = "Y"
            self.answerBottomSheetView.postShareButton.setImage(UIImage(named: "lockBlack"), for: .normal)
            UserDefaults.standard.set(sender.isSelected, forKey: "isshareValue")
        }
    }
    
    
    @objc
    private func showEditBottomSheetDidTap(_ sender: UIButton) {
        let window = UIApplication.shared.windows.first
        let screenSize = UIScreen.main.bounds.size
        self.editBottomSheetLayoutInit()
        window?.addSubview(self.editBottomContainerView)
        window?.addSubview(self.editBottomView)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.editBottomView.frame = CGRect(x: 0, y: screenSize.height - 224, width: screenSize.width, height: 224 + self.view.safeAreaInsets.bottom)
        })
    }
    
    
    @objc
    private func toolbarButtonDidTap() {
        self.answerBottomSheetView.endEditing(true)
    }
    
    
    @objc
    private func hideEditBottomSheetGestureAction(recognizer: UITapGestureRecognizer) {
        let screenSize = UIScreen.main.bounds.size
        let window = UIApplication.shared.windows.first
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            if let removeContainer = window?.viewWithTag(1) {
                removeContainer.removeFromSuperview()
            }
            self.editBottomView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 224 + self.view.safeAreaInsets.bottom)
        })
    }
    
    
    @objc
    private func homeAfterEditButtonDidTap(_ sender: UIButton) {
        let window = UIApplication.shared.windows.first
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            if let removeContainer = window?.viewWithTag(1) {
                removeContainer.removeFromSuperview()
            }
            self.editBottomView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height + self.view.safeAreaInsets.bottom)
        } completion: { (success) in
            if success {
                let height = self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
                window?.addSubview(self.answerBottomSheetView)
                self.answerEditBottomSheetLayoutInit()
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                    self.answerBottomSheetView.frame = CGRect(x: 0, y: screenSize.height - (screenSize.height - height - 12), width: screenSize.width, height: screenSize.height + height + 12)
                })
            }
        }
        
    }
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardEndFrame = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardEndFrame.height
            let caret = self.answerBottomSheetView.postAnswerTextView.caretRect(for: self.answerBottomSheetView.postAnswerTextView.selectedTextRange!.start)
            self.answerBottomSheetView.postTextViewBottomConstraint.constant = keyboardHeight + 120
            self.answerBottomSheetView.postAnswerTextView.scrollRectToVisible(caret, animated: true)
            self.answerBottomSheetView.postAnswerTextView.contentInset.bottom = 10
            self.answerBottomSheetView.layoutIfNeeded()
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        if self.answerBottomSheetView.postAnswerTextView.bounds.height < self.answerBottomSheetView.postAnswerTextView.frame.size.height {
            self.answerBottomSheetView.postTextViewBottomConstraint.constant = 15
        } else {
            self.answerBottomSheetView.postTextViewBottomConstraint.constant = self.answerBottomSheetView.postAnswerTextView.bounds.height
        }
        self.answerBottomSheetView.postAnswerTextView.contentInset.bottom = 10
        self.answerBottomSheetView.layoutIfNeeded()
    }
    
    @objc
    private func homeAfterDeleteButtonDidTap(_ sender: UIButton) {
        let window = UIApplication.shared.windows.first
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            if let deleteView = window?.viewWithTag(1) {
                deleteView.removeFromSuperview()
            }
            self.editBottomView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 224 + self.view.safeAreaInsets.bottom)
        } completion: { success in
            if success {
                self.deleteHomeCardList()
            }
        }
        
    }
    
    @objc
    private func homeAfterCancelButtonDidTap(_ sender: UIButton) {
        let window = UIApplication.shared.windows.first
        let screenSize = UIScreen.main.bounds.size
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            if let cancelView = window?.viewWithTag(1) {
                cancelView.removeFromSuperview()
            }
            self.editBottomView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 224 + self.view.safeAreaInsets.bottom)
        }, completion: nil)
    }
    
    @objc
    public func showAfterSideButtonDidTap() {
        guard let sideMenu = self.afterSideMenu else { return }
        self.present(sideMenu, animated: true, completion: nil)
    }
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        self.afterSideMenu?.setSideMenuNavigation(viewcontroller: self)
    }
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        self.afterSideMenu?.deleteEffectViewNavigation(viewcontroller: self)
    }
    
}


extension HomeAfterViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let homeAfterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeAfterCell", for: indexPath) as? HomeAfterCollectionViewCell
        if self.homeAfterData?.post.color == "red" {
            homeAfterCell?.homeAfterTagButton.backgroundColor = UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0)
            homeAfterCell?.homeAfterTagButton.setTitle("열정충만", for: .normal)
        } else if self.homeAfterData?.post.color == "yellow" {
            homeAfterCell?.homeAfterTagButton.backgroundColor = UIColor(red: 242/255, green: 194/255, blue: 23/255, alpha: 1.0)
            homeAfterCell?.homeAfterTagButton.setTitle("소소한일상", for: .normal)
        } else if self.homeAfterData?.post.color == "green" {
            homeAfterCell?.homeAfterTagButton.backgroundColor = UIColor(red: 31/255, green: 176/255, blue: 115/255, alpha: 1.0)
            homeAfterCell?.homeAfterTagButton.setTitle("기억상자", for: .normal)
        } else if self.homeAfterData?.post.color == "pink" {
            homeAfterCell?.homeAfterTagButton.backgroundColor = UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0)
            homeAfterCell?.homeAfterTagButton.setTitle("관계의미학", for: .normal)
        } else {
            homeAfterCell?.homeAfterTagButton.backgroundColor = UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0)
            homeAfterCell?.homeAfterTagButton.setTitle("상상플러스", for: .normal)
        }
        if self.homeAfterData?.post.level == 1 {
            homeAfterCell?.homeAfterLevelView.isHidden = true
            homeAfterCell?.homeAfterLevelLabel.isHidden = true
        } else {
            homeAfterCell?.homeAfterLevelView.isHidden = false
            homeAfterCell?.homeAfterLevelLabel.isHidden = false
        }
        if let questionText = self.homeAfterData?.post.question {
            homeAfterCell?.homeAfterTitleLabel.text = "\(questionText)"
        }
        if let answerText = self.homeAfterData?.post.answer {
            homeAfterCell?.homeAfterSubjectLabel.text = "\(answerText)"
        }
        homeAfterCell?.homeAfterEditButton.addTarget(self, action: #selector(self.showEditBottomSheetDidTap(_:)), for: .touchUpInside)
        return homeAfterCell!
    }
    
}


extension HomeAfterViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.answerBottomSheetView.postConfirmButton.isEnabled = false
            textView.text = "당신의 생각을 말해주세요"
            textView.textColor = .gray999
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        if textView.textColor == .gray999 {
            self.answerBottomSheetView.postConfirmButton.isEnabled = true
            textView.text = nil
            textView.textAlignment = .left
            textView.typingAttributes = [NSAttributedString.Key.paragraphStyle:paragraphStyle,NSAttributedString.Key.font:UIFont(name: "AppleSDGothicNeo-Regular", size: 16),NSAttributedString.Key.foregroundColor:UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)]
        }
    }
}
