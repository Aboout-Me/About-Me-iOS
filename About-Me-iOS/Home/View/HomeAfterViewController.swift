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
    @IBOutlet weak var homeAfterAnswerView: UIView!
    @IBOutlet weak var homeAfterTagView: UIButton!
    @IBOutlet weak var homeAfterEditButton: UIButton!
    @IBOutlet weak var homeAfterQuestionLabel: UILabel!
    @IBOutlet weak var homeAfterLevelFlexView: UIView!
    @IBOutlet weak var homeAfterLevelLabel: UILabel!
    @IBOutlet weak var homeAfterLineView: UIView!
    @IBOutlet weak var homeAfterAnswerTextView: UITextView!
    @IBOutlet weak var homeAfterFloaingButton: Floaty!
    @IBOutlet weak var homeAfterBackgroundImageView: UIImageView!
    @IBOutlet weak var homeAfterLastAnswerButton: UIButton!
    public var afterSideMenu: SideMenuNavigationController?
    public var screenSize = UIScreen.main.bounds.size
    public var isAfterShare = "Y"
    private var homeAfterData: SocialDetailResponse? = nil
    private var rightBarButtonName = "Bell"
    
    lazy var editBottomContainerView: UIView = {
        let containerView = UIView(frame: self.view.frame)
        containerView.isOpaque = false
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        containerView.tag = 4
        return containerView
    }()
    
    
    lazy var answerBottomSheetView: PostBottomSheetView = {
        let answerSheetView = Bundle.main.loadNibNamed("PostBottomSheetView", owner: self, options: nil)?.first as? PostBottomSheetView
        answerSheetView?.frame = CGRect(x: self.view.frame.origin.x, y: self.screenSize.height, width: self.screenSize.width, height: answerSheetView!.frame.size.height)
        answerSheetView?.postAnswerTextView.delegate = self
        answerSheetView?.postCancelButton.addTarget(self, action: #selector(HomeAfterViewController.hideAnswerBottomSheetDidTap), for: .touchUpInside)
        answerSheetView?.postConfirmButton.addTarget(self, action: #selector(HomeAfterViewController.confirmEditViewButtonDidTap), for: .touchUpInside)
        answerSheetView?.postShareButton.addTarget(self, action: #selector(HomeAfterViewController.shareEditViewButtonDidTap(_:)), for: .touchUpInside)
        return answerSheetView!
    }()
    
    lazy var editBottomView: EditBottomSheetView = {
        let editView = Bundle.main.loadNibNamed("EditBottomSheetView", owner: self, options: nil)?.first as? EditBottomSheetView
        editView?.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 224)
        return editView!
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isWriteCardCheck()
        setLayoutInit()
        setSideMenuLayoutInit()
        getUtilList()
        print("Answe_ id Check viewdidload",UserDefaults.standard.string(forKey: "answer_Id"))
        print("homeAfter 뷰 계층: \(self.navigationController?.viewControllers)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: appDelegate?.rightBarIcon ?? rightBarButtonName), style: .plain, target: self, action: #selector(HomeAfterViewController.showAlarmButtonDidTap))
        self.navigationController?.navigationBar.tintColor = .white
        let navigationApp = UINavigationBarAppearance()
        navigationApp.configureWithTransparentBackground()
        self.navigationController?.navigationBar.standardAppearance = navigationApp
        self.navigationController?.navigationBar.compactAppearance = navigationApp
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "GmarketSansMedium", size: 14)]
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationController?.navigationBar.standardAppearance.shadowColor = nil
        isWriteCardCheck()
        getUtilList()
        print("homeAfter ViewwillApper뷰 계층: \(self.navigationController?.viewControllers)")
        print("Answe_ id Check viewwillapear",UserDefaults.standard.string(forKey: "answer_Id"))
    }
    
    private func setLayoutInit() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateString = dateFormatter.string(from: date)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu.png"), style: .plain, target: self, action: #selector(HomeAfterViewController.showAfterSideButtonDidTap))
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: appDelegate?.rightBarIcon ?? rightBarButtonName), style: .plain, target: self, action: #selector(HomeAfterViewController.showAlarmButtonDidTap))
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.title = dateString
        homeAfterBackgroundImageView.contentMode = .scaleToFill
        homeAfterAnswerView.layer.borderColor = UIColor.clear.cgColor
        homeAfterAnswerView.layer.cornerRadius = 10
        homeAfterAnswerView.clipsToBounds = true
        homeAfterAnswerView.backgroundColor = UIColor.white
        
        homeAfterTagView.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 12)
        homeAfterTagView.titleLabel?.textAlignment = .center
        homeAfterTagView.setTitleColor(.white, for: .normal)
        homeAfterTagView.layer.masksToBounds = true
        homeAfterTagView.layer.cornerRadius = 3
        homeAfterTagView.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        homeAfterTagView.isEnabled = false
        
        homeAfterLevelFlexView.layer.borderWidth = 1
        homeAfterLevelFlexView.layer.borderColor = UIColor.gray555.cgColor
        homeAfterLevelFlexView.layer.cornerRadius = 3
        
        homeAfterQuestionLabel.numberOfLines = 0
        homeAfterQuestionLabel.textAlignment = .left
        homeAfterQuestionLabel.font = UIFont(name: "GmarketSansMedium", size: 20)
        homeAfterQuestionLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        
        homeAfterAnswerTextView.textAlignment = .left
        homeAfterAnswerTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        homeAfterAnswerTextView.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        homeAfterAnswerTextView.isEditable = false
        homeAfterAnswerTextView.isSelectable = false
        homeAfterAnswerTextView.textContainer.lineBreakMode = .byTruncatingTail
        homeAfterAnswerTextView.textContainer.lineFragmentPadding = 0
        
        
        homeAfterFloaingButton.buttonColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        homeAfterFloaingButton.plusColor = UIColor.white
        homeAfterFloaingButton.selectedColor = UIColor.gray999
        homeAfterFloaingButton.sticky = true
        
        homeAfterLastAnswerButton.setTitle("같은 질문 지난 응답 확인하기", for: .normal)
        homeAfterLastAnswerButton.setTitleColor(UIColor.gray333, for: .normal)
        homeAfterLastAnswerButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        homeAfterLastAnswerButton.backgroundColor = .white
        homeAfterLastAnswerButton.layer.cornerRadius = 15
        homeAfterLastAnswerButton.layer.masksToBounds = true
        homeAfterLastAnswerButton.addTarget(self, action: #selector(self.showLastAnswerButtonDidTap), for: .touchUpInside)
        homeAfterFloaingButton.addItem("오늘의 질문", icon: UIImage(named: "Write.png")) { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeAfterView = storyboard.instantiateViewController(withIdentifier: "HomeAfterVC") as? HomeAfterViewController
            guard let homeAfterVC = homeAfterView else { return }
            self.navigationController?.pushViewController(homeAfterVC, animated: true)
        }
        homeAfterFloaingButton.addItem("자문 자답", icon: UIImage(named: "SelfQuestion.png")) { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let advisoryAnswerView = storyboard.instantiateViewController(withIdentifier: "AdvisoryAnswerVC") as? AdvisoryAnswerViewController
            guard let advisoryAnswerVC = advisoryAnswerView else { return }
            self.navigationController?.pushViewController(advisoryAnswerVC, animated: true)
        }
        homeAfterFloaingButton.addItem("내 피드", icon: UIImage(named: "Feed.png")) { _ in
            let moreVC = SocialMoreContentViewController(nibName: "SocialMoreContentViewController", bundle: nil)
            moreVC.state = .none
            self.navigationController?.pushViewController(moreVC, animated: true)
        }

        homeAfterEditButton.addTarget(self, action: #selector(HomeAfterViewController.showEditBottomSheetDidTap(_:)), for: .touchUpInside)
    }
    
    private func isWriteCardCheck() {
        HomeServerApi.getIsDailyWrite(userId: USER_ID) { result in
            if case let .success(data) = result, let list = data {
                if list.isWritten == false {
                    UserDefaults.standard.set(list.isWritten, forKey: "isWrite")
                    UserDefaults.standard.removeObject(forKey: "answer_Id")
                    UserDefaults.standard.synchronize()
                    self.navigationController?.popViewController(animated: true)
                } else {
                    UserDefaults.standard.set(list.isWritten, forKey: "isWrite")
                }
            }
        }
    }
    
    
    private func setSideMenuLayoutInit() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sideOnlyViewController: SideOnlyViewController = storyboard.instantiateViewController(withIdentifier: "SideOnlyViewController") as! SideOnlyViewController
        afterSideMenu = SideMenuNavigationController(rootViewController: sideOnlyViewController)
        afterSideMenu?.leftSide = true
    }
    
    
    private func editBottomSheetLayoutInit() {
        self.editBottomView.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: 224)
        editBottomView.gestureView.layer.cornerRadius = 10
        editBottomView.gestureView.layer.masksToBounds = true
        editBottomView.layer.cornerRadius = 10
        editBottomView.layer.masksToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeAfterViewController.hideEditBottomSheetGestureAction(recognizer:)))
        editBottomContainerView.addGestureRecognizer(tapGesture)
        editBottomView.editButton.addTarget(self, action: #selector(HomeAfterViewController.homeAfterEditButtonDidTap(_:)), for: .touchUpInside)
        editBottomView.deleteButton.addTarget(self, action: #selector(HomeAfterViewController.homeAfterDeleteButtonDidTap(_:)), for: .touchUpInside)
        editBottomView.cancelButton.addTarget(self, action: #selector(HomeAfterViewController.homeAfterCancelButtonDidTap(_:)), for: .touchUpInside)
    }
    
    
    public func answerEditBottomSheetLayoutInit() {
        let paragraphStyle = NSMutableParagraphStyle()
        let editToolbar = UIToolbar()
        let screenSize = UIScreen.main.bounds.size
        paragraphStyle.lineSpacing = 4
        let fiexedbarButtonItem,donebarButtonItem: UIBarButtonItem
        fiexedbarButtonItem = UIBarButtonItem(systemItem: .flexibleSpace)
        donebarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.toolbarButtonDidTap))
        editToolbar.items = [fiexedbarButtonItem,donebarButtonItem]
        editToolbar.sizeToFit()
        answerBottomSheetView.postNumberLabel.text = "Q. "
        answerBottomSheetView.postNumberLabel.textColor = .gray333
        answerBottomSheetView.postNumberLabel.font = UIFont(name: "GmarketSansMedium", size: 18)
        answerBottomSheetView.postNumberLabel.textAlignment = .left
        answerBottomSheetView.postQuestionLabel.attributedText = NSAttributedString(string: "\(homeAfterData!.post.question)", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        answerBottomSheetView.postQuestionLabel.textColor = .gray333
        answerBottomSheetView.postQuestionLabel.textAlignment = .left
        answerBottomSheetView.postQuestionLabel.font = UIFont(name: "GmarketSansMedium", size: 20)
        answerBottomSheetView.postQuestionLabel.numberOfLines = 0
        answerBottomSheetView.postQuestionLabel.sizeToFit()
        answerBottomSheetView.postAnswerTextView.text = "당신의 생각을 말해주세요"
        answerBottomSheetView.postAnswerTextView.textColor = .gray999
        answerBottomSheetView.postConfirmButton.isEnabled = false
        answerBottomSheetView.postAnswerTextView.inputAccessoryView = editToolbar
        answerBottomSheetView.postShareButton.setImage(UIImage(named: "UnLockBlack"), for: .normal)
        answerBottomSheetView.layer.cornerRadius = 20
        answerBottomSheetView.clipsToBounds = true
        NotificationCenter.default.addObserver(self, selector: #selector(HomeAfterViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeAfterViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func deleteHomeCardList() {
        print(UserDefaults.standard.integer(forKey: "answer_Id"))
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        HomeServerApi.deleteHomeCardList(seq: UserDefaults.standard.integer(forKey: "answer_Id")) { result in
            if case let .success(data) = result, let _ = data {
                guard let viewcontrollers = self.navigationController?.viewControllers else { return }
                if viewcontrollers.first is HomeBeforeViewController {
                    if let homeBeforeView = viewcontrollers.first as? HomeBeforeViewController {
                        self.navigationController?.popToViewController(homeBeforeView, animated: true)
                    }
                } else {
                    sceneDelegate?.isSceneDailyCheck()
                }
                print("뷰 계층: \(self.navigationController?.viewControllers)")
            } else if case let .failure(error) = result {
                let alert = UIAlertController(title: "Delete Error Message", message: error, preferredStyle: .alert)
                let alertButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(alertButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func editHomeCardList() {
        let parameter = HomeCardEditParamter(answer: self.answerBottomSheetView.postAnswerTextView.text ?? "", category_seq: UserDefaults.standard.integer(forKey: "card_seq"), level: self.homeAfterData!.post.level, share: isAfterShare)
        HomeServerApi.putHomeCardList(parameter: parameter) { result in
            if case let .success(data) = result, let _ = data {
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
            SocialApiService.getSocialDetail(answerId: UserDefaults.standard.integer(forKey: "answer_Id"), authorId: 1) { detailResponse in
                DispatchQueue.main.async {
                    self.homeAfterData = detailResponse!
                    self.setAnswerViewLayout()
                }
            }
        }
    
    private func setAnswerViewLayout() {
        if self.homeAfterData?.post.color == "red" {
            homeAfterBackgroundImageView.image = UIImage(named: "imgBackgroundRed.png")
            homeAfterTagView.backgroundColor = UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0)
            homeAfterTagView.setTitle("열정충만", for: .normal)
        } else if self.homeAfterData?.post.color == "yellow" {
            homeAfterBackgroundImageView.image = UIImage(named: "imgBackgroundYellow.png")
            homeAfterTagView.backgroundColor = UIColor(red: 242/255, green: 194/255, blue: 23/255, alpha: 1.0)
            homeAfterTagView.setTitle("소소한일상", for: .normal)
        } else if self.homeAfterData?.post.color == "green" {
            homeAfterBackgroundImageView.image = UIImage(named: "imgBackgroundGreen.png")
            homeAfterTagView.backgroundColor = UIColor(red: 31/255, green: 176/255, blue: 115/255, alpha: 1.0)
            homeAfterTagView.setTitle("기억상자", for: .normal)
        } else if self.homeAfterData?.post.color == "pink" {
            homeAfterBackgroundImageView.image = UIImage(named: "imgBackgroundPink.png")
            homeAfterTagView.backgroundColor = UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0)
            homeAfterTagView.setTitle("관계의미학", for: .normal)
        } else if self.homeAfterData?.post.color == "purple" {
            self.homeAfterBackgroundImageView.image = UIImage(named: "imgBackgroundViolet.png")
            homeAfterTagView.backgroundColor = UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0)
            homeAfterTagView.setTitle("상상플러스", for: .normal)
        }
        
        if self.homeAfterData?.post.level == 1 {
            self.homeAfterLastAnswerButton.isHidden = false
            self.homeAfterLevelLabel.isHidden = true
            self.homeAfterLevelFlexView.isHidden = true
        } else {
            self.homeAfterLastAnswerButton.isHidden = false
            self.homeAfterLevelLabel.isHidden = false
            self.homeAfterLevelFlexView.isHidden = false
        }
        
        if let question = homeAfterData?.post.question {
            homeAfterQuestionLabel.text = question
        }
        if let answer = homeAfterData?.post.answer {
            homeAfterAnswerTextView.text = answer
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
        answerBottomSheetView.postAnswerTextView.resignFirstResponder()
        editHomeCardList()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.answerBottomSheetView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height)
        })
    }
    
    @objc
    private func shareEditViewButtonDidTap(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            isAfterShare = "Y"
            answerBottomSheetView.postShareButton.setImage(UIImage(named: "UnLockBlack"), for: .normal)
            UserDefaults.standard.set(sender.isSelected, forKey: "isshareValue")
        } else {
            sender.isSelected = true
            isAfterShare = "N"
            answerBottomSheetView.postShareButton.setImage(UIImage(named: "lockBlack"), for: .normal)
            UserDefaults.standard.set(sender.isSelected, forKey: "isshareValue")
        }
    }
    
    @objc
    private func showLastAnswerButtonDidTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let lastAnswerView = storyboard.instantiateViewController(identifier: "LastAnswerVC") as? LastAnswerViewController
        lastAnswerView?.questId = UserDefaults.standard.integer(forKey: "quest_id")
        guard let lastAnswerVC = lastAnswerView else { return }
        self.navigationController?.pushViewController(lastAnswerVC, animated: true)
    }
    
    
    @objc
    private func showEditBottomSheetDidTap(_ sender: UIButton) {
        let window = UIApplication.shared.windows.first {$0.isKeyWindow}
        let screenSize = UIScreen.main.bounds.size
        editBottomSheetLayoutInit()
        window?.addSubview(editBottomContainerView)
        window?.addSubview(editBottomView)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.editBottomView.frame = CGRect(x: 0, y: screenSize.height - 224, width: screenSize.width, height: 224 + self.view.safeAreaInsets.bottom)
        })
    }
    
    
    @objc
    private func toolbarButtonDidTap() {
        answerBottomSheetView.endEditing(true)
    }
    
    
    @objc
    private func hideEditBottomSheetGestureAction(recognizer: UITapGestureRecognizer) {
        let screenSize = UIScreen.main.bounds.size
        let window = UIApplication.shared.windows.first {$0.isKeyWindow}
        DispatchQueue.main.async {
            if let removeContainer = window?.viewWithTag(4) {
                removeContainer.removeFromSuperview()
            }
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.editBottomView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 224 + self.view.safeAreaInsets.bottom)
        })
    }
    
    
    @objc
    private func homeAfterEditButtonDidTap(_ sender: UIButton) {
        let window = UIApplication.shared.windows.first {$0.isKeyWindow}
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            DispatchQueue.main.async {
                if let removeContainer = window?.viewWithTag(4) {
                    removeContainer.removeFromSuperview()
                }
            }
                self.editBottomView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height + self.view.safeAreaInsets.bottom)
        } completion: { (success) in
            if success {
                let height = self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
                window?.addSubview(self.answerBottomSheetView)
                self.answerEditBottomSheetLayoutInit()
                DispatchQueue.global(qos: .userInteractive).async {
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                            self.answerBottomSheetView.frame = CGRect(x: 0, y: screenSize.height - (screenSize.height - height - 12), width: screenSize.width, height: screenSize.height + height + 12)
                        })
                    }
                }
            }
        }
        
    }
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardEndFrame = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardEndFrame.height
            let caret = answerBottomSheetView.postAnswerTextView.caretRect(for: answerBottomSheetView.postAnswerTextView.selectedTextRange!.start)
            answerBottomSheetView.postTextViewBottomConstraint.constant = keyboardHeight + 120
            answerBottomSheetView.postAnswerTextView.scrollRectToVisible(caret, animated: true)
            answerBottomSheetView.postAnswerTextView.contentInset.bottom = 10
            answerBottomSheetView.layoutIfNeeded()
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        if answerBottomSheetView.postAnswerTextView.bounds.height < answerBottomSheetView.postAnswerTextView.frame.size.height {
            answerBottomSheetView.postTextViewBottomConstraint.constant = 15
        } else {
            answerBottomSheetView.postTextViewBottomConstraint.constant = answerBottomSheetView.postAnswerTextView.bounds.height
        }
        answerBottomSheetView.postAnswerTextView.contentInset.bottom = 10
        answerBottomSheetView.layoutIfNeeded()
    }
    
    @objc
    private func homeAfterDeleteButtonDidTap(_ sender: UIButton) {
        let window = UIApplication.shared.windows.first {$0.isKeyWindow}
        let screenSize = UIScreen.main.bounds.size
        DispatchQueue.main.async {
            if let deleteView = window?.viewWithTag(4) {
                deleteView.removeFromSuperview()
            }
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
                self.editBottomView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 224 + self.view.safeAreaInsets.bottom)
        } completion: { success in
            if success {
                self.deleteHomeCardList()
            }
        }
        
    }
    
    @objc
    private func homeAfterCancelButtonDidTap(_ sender: UIButton) {
        let window = UIApplication.shared.windows.first {$0.isKeyWindow}
        let screenSize = UIScreen.main.bounds.size
        DispatchQueue.main.async {
            if let cancelView = window?.viewWithTag(4) {
                cancelView.removeFromSuperview()
            }
        }
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                    self.editBottomView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: 224 + self.view.safeAreaInsets.bottom)
            }, completion: nil)
        }
    }
    
    @objc
    public func showAfterSideButtonDidTap() {
        guard let sideMenu = afterSideMenu else { return }
        self.present(sideMenu, animated: true, completion: nil)
    }
    
    @objc
    public func showAlarmButtonDidTap() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let NoticeView = storyBoard.instantiateViewController(withIdentifier: "NoticeVC") as? NoticeViewController
        guard let NoticeVC = NoticeView else { return }
        self.navigationController?.pushViewController(NoticeVC, animated: true)
    }
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        afterSideMenu?.setSideMenuNavigation(viewcontroller: self)
    }
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        afterSideMenu?.deleteEffectViewNavigation(viewcontroller: self)
    }
    
}

extension HomeAfterViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            answerBottomSheetView.postConfirmButton.isEnabled = false
            textView.text = "당신의 생각을 말해주세요"
            textView.textColor = .gray999
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        if textView.textColor == .gray999 {
            answerBottomSheetView.postConfirmButton.isEnabled = true
            textView.text = nil
            textView.textAlignment = .left
            textView.typingAttributes = [NSAttributedString.Key.paragraphStyle:paragraphStyle,NSAttributedString.Key.font:UIFont(name: "AppleSDGothicNeo-Regular", size: 16),NSAttributedString.Key.foregroundColor:UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)]
        }
    }
}
