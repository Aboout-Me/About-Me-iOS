//
//  ViewController.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/03/25.
//

import UIKit
import SideMenu
import Floaty

class HomeBeforeViewController: UIViewController, SideMenuNavigationControllerDelegate {
    @IBOutlet weak var homeBeforeBackgroundImageView: UIImageView!
    @IBOutlet weak var homeBeforeFloatingButton: Floaty!
    @IBOutlet weak var homeBeforeCollectionView: UICollectionView!
    @IBOutlet weak var homeBeforeLastAnswerButton: UIButton!
    private var homeData = [HomeCardListModel]()
    private var sideMenu: SideMenuNavigationController?
    @IBOutlet weak var homeBeforeLastAnswerButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var homeBeforeLastAnswerButtonTopConstraint: NSLayoutConstraint!
    private var questionTitleText: String = ""
    private let lineSpacing: CGFloat = 15
    private var currentPage:Int = 0
    private var selectIndex:Int = 0
    private var screenSize = UIScreen.main.bounds.size
    public var isshare = "Y"
    private var rightBarButtonName = "Bell"
    
    
    lazy var editAnswerSheetView: PostBottomSheetView = {
        let sheetView = Bundle.main.loadNibNamed("PostBottomSheetView", owner: self, options: nil)?.first as? PostBottomSheetView
        sheetView?.frame = CGRect(x: view.frame.origin.x, y: screenSize.height, width: screenSize.width, height: sheetView!.frame.size.height)
        sheetView?.postConfirmButton.addTarget(self, action: #selector(HomeBeforeViewController.showQuestionViewDidTap), for: .touchUpInside)
        sheetView?.postCancelButton.addTarget(self, action: #selector(HomeBeforeViewController.hiddenBottomSheetDidTap), for: .touchUpInside)
        sheetView?.postShareButton.addTarget(self, action: #selector(HomeBeforeViewController.sharedBottomSheetButtonDidTap(_:)), for: .touchUpInside)
        sheetView?.postAnswerTextView.delegate = self
        return sheetView!
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getHomeCardList()
        setLayoutInit()
        setSideMenuLayoutInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: appDelegate!.rightBarIcon ?? rightBarButtonName), style: .plain, target: self, action: #selector(HomeBeforeViewController.showAlarmButtonDidTap))
        self.navigationController?.navigationBar.tintColor = .white
        let navigationApp = UINavigationBarAppearance()
        navigationApp.configureWithTransparentBackground()
        self.navigationController?.navigationBar.standardAppearance = navigationApp
        self.navigationController?.navigationBar.compactAppearance = navigationApp
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "GmarketSansMedium", size: 14)]
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationController?.navigationBar.standardAppearance.shadowColor = nil
        getWriteCardList()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    
    private func setSideMenuLayoutInit() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sideOnlyViewController: SideOnlyViewController = storyboard.instantiateViewController(withIdentifier: "SideOnlyViewController") as! SideOnlyViewController
        sideMenu = SideMenuNavigationController(rootViewController: sideOnlyViewController)
        sideMenu?.leftSide = true
    }
    
    private func setLayoutInit() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let leftBarButtonItem,rightBarButtonItem: UIBarButtonItem
        leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "NewMenu.png"), style: .plain, target: self, action: #selector(HomeBeforeViewController.showSideButtonDidTap))
        rightBarButtonItem = UIBarButtonItem(image: UIImage(named: appDelegate!.rightBarIcon ?? rightBarButtonName), style: .plain, target: self, action: #selector(HomeBeforeViewController.showAlarmButtonDidTap))
        let mainNib = UINib(nibName: "HomeBeforeCollectionViewCell", bundle: nil)
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateString = dateFormatter.string(from: date)
        self.navigationItem.title = dateString
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont(name: "GmarketSansMedium", size: 14)]
        homeBeforeBackgroundImageView.image = UIImage(named: "img_background_red.png")
        let cellWidth = floor(view.frame.width * 0.85)
        let layout = HomeCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = self.lineSpacing
        layout.itemSize = CGSize(width: cellWidth, height: 420)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        homeBeforeCollectionView.collectionViewLayout = layout
        homeBeforeCollectionView.delegate = self
        homeBeforeCollectionView.dataSource = self
        homeBeforeCollectionView.backgroundColor = .clear
        homeBeforeCollectionView.register(mainNib, forCellWithReuseIdentifier: "homeBeforeCell")
        homeBeforeCollectionView.showsHorizontalScrollIndicator = false
        homeBeforeCollectionView.isPagingEnabled = false
        homeBeforeBackgroundImageView.contentMode = .scaleToFill
        homeBeforeCollectionView.decelerationRate = .fast
        homeBeforeFloatingButton.buttonColor = .gray333
        homeBeforeFloatingButton.plusColor = .white
        homeBeforeFloatingButton.selectedColor = .gray999
        homeBeforeFloatingButton.sticky = true
        homeBeforeLastAnswerButton
            .widthAnchor
            .constraint(equalToConstant: cellWidth)
            .isActive = true
        homeBeforeFloatingButton.addItem("오늘의 질문", icon: UIImage(named: "Home_Write.png")) { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeView = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeBeforeViewController
            guard let homeVC = homeView else { return }
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
        self.homeBeforeFloatingButton.addItem("자문 자답", icon: UIImage(named: "Question.png")) { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let advisoryAnswerView = storyboard.instantiateViewController(withIdentifier: "AdvisoryAnswerVC") as? AdvisoryAnswerViewController
            guard let advisoryAnswerVC = advisoryAnswerView else { return }
            self.navigationController?.pushViewController(advisoryAnswerVC, animated: true)
        }
        self.homeBeforeFloatingButton.addItem("내 피드", icon: UIImage(named: "icoFeed.png")) { _ in
            let moreVC = SocialMoreContentViewController(nibName: "SocialMoreContentViewController", bundle: nil)
            moreVC.state = .none
            self.navigationController?.pushViewController(moreVC, animated: true)
        }
        homeBeforeLastAnswerButton.backgroundColor = .white
        homeBeforeLastAnswerButton.layer.cornerRadius = 15
        homeBeforeLastAnswerButton.clipsToBounds = true
        homeBeforeLastAnswerButton.setTitle("같은 질문 지난 응답 확인하기", for: .normal)
        homeBeforeLastAnswerButton.setTitleColor(.gray333, for: .normal)
        homeBeforeLastAnswerButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        homeBeforeLastAnswerButton.addTarget(self, action: #selector(HomeBeforeViewController.showLastAnswerButtonDidTap), for: .touchUpInside)
    }
    
    
    private func homeBeforeBottomSheetLayoutInit() {
        let questionToolBar = UIToolbar()
        let fiexedbarButtonItem,donebarButtonItem: UIBarButtonItem
        fiexedbarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        donebarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(HomeBeforeViewController.toolbarButtonDidTap))
        questionToolBar.items = [fiexedbarButtonItem,donebarButtonItem]
        questionToolBar.sizeToFit()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        editAnswerSheetView.tag = 2
        editAnswerSheetView.postQuestionLabel.attributedText = NSAttributedString(string:"\(questionTitleText)", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        editAnswerSheetView.postNavigationTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        editAnswerSheetView.postQuestionLabel.textColor = .gray333
        editAnswerSheetView.postQuestionLabel.font = UIFont(name: "GmarketSansMedium", size: 20)
        editAnswerSheetView.postQuestionLabel.numberOfLines = 0
        editAnswerSheetView.postQuestionLabel.textAlignment = .left
        editAnswerSheetView.postQuestionLabel.sizeToFit()
        editAnswerSheetView.postNumberLabel.text = "Q. "
        editAnswerSheetView.postNumberLabel.textColor = .gray333
        editAnswerSheetView.postNumberLabel.textAlignment = .left
        editAnswerSheetView.postNumberLabel.font = UIFont(name: "GmarketSansMedium", size: 18)
        editAnswerSheetView.postAnswerTextView.text = "당신의 생각을 말해주세요"
        editAnswerSheetView.postAnswerTextView.textColor = .gray999
        editAnswerSheetView.postAnswerTextView.textAlignment = .left
        editAnswerSheetView.postShareButton.isSelected = false
        editAnswerSheetView.postAnswerTextView.inputAccessoryView = questionToolBar
        editAnswerSheetView.layer.cornerRadius = 20
        editAnswerSheetView.clipsToBounds = true
        editAnswerSheetView.postConfirmButton.isEnabled = false
        editAnswerSheetView.postShareButton.setImage(UIImage(named: "UnLockBlack"), for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeBeforeViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeBeforeViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func getWriteCardList() {
        HomeServerApi.getIsDailyWrite(userId: USER_ID) { result in
            if case let .success(data) = result, let list = data {
                if list.isWritten == true {
                    print("getIsDailyWrite Data \(list.isWritten)")
                    UserDefaults.standard.set(list.isWritten, forKey: "isWrite")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeAfterVC = storyboard.instantiateViewController(withIdentifier: "HomeAfterVC") as? HomeAfterViewController
                    guard let homeAfterView = homeAfterVC else { return }
                    self.navigationController?.pushViewController(homeAfterView, animated: true)
                    print("뷰 계층 getWriteCardList \(self.navigationController?.viewControllers)")
                } else {
                    UserDefaults.standard.set(list.isWritten, forKey: "isWrite")
                    UserDefaults.standard.removeObject(forKey: "card_seq")
                    UserDefaults.standard.removeObject(forKey: "answer_Id")
                    UserDefaults.standard.synchronize()
                }
            }
        }
    }
    
    private func getHomeCardList() {
        HomeServerApi.getHomeCardList(userId: USER_ID) { result in
            if case let .success(data) = result, let list = data {
                print(self.homeData)
                DispatchQueue.main.async {
                    self.homeData = list.dailyLists
                    if self.homeData[0].color != "red" {
                        self.homeData.reverse()
                    }
                    self.homeBeforeCollectionView.reloadData()
                    self.homeBeforeCollectionView.layoutIfNeeded()
                }
            } else if case let .failure(error) = result {
                let alert = UIAlertController(title: "Error Message", message: error, preferredStyle: .alert)
                let alertButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(alertButton)
                self.present(alert, animated: true, completion: nil)
                print(error)
            }
        }
    }
    
    
    private func postHomeCardSave() {
        print("질문 일련번호 \(self.homeData[self.selectIndex].seq)")
        let parameter = HomeCardSaveParamter(answer: self.editAnswerSheetView.postAnswerTextView.text, color: self.homeData[self.selectIndex].color, level: Int(self.homeData[self.selectIndex].lev)!, share_yn: self.isshare, title: self.homeData[self.selectIndex].seq, user: USER_ID)
        DispatchQueue(label: "Concurrent", attributes: .concurrent).async {
            HomeServerApi.postHomecardListSave(parameter: parameter) { result in
                if case let .success(data) = result, let list = data {
                    print(list.dailyLists[0].cardSeq, "카드 일련 번호 입니다")
                    print(list.dailyLists[0].answer_id, "카드 answer_id 입니다!!!")
                        UserDefaults.standard.set(list.dailyLists[0].quest_id, forKey: "quest_id")
                        UserDefaults.standard.set(list.dailyLists[0].cardSeq, forKey: "card_seq")
                        UserDefaults.standard.set(list.dailyLists[0].answer_id, forKey: "answer_Id")
                    print("answerIDcheck before: \(UserDefaults.standard.string(forKey: "answer_Id")!)")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeAfterView = storyboard.instantiateViewController(withIdentifier: "HomeAfterVC") as? HomeAfterViewController
                    guard let homeAfterVC = homeAfterView else { return }
                    self.navigationController?.pushViewController(homeAfterVC, animated: true)
                } else if case let .failure(error) = result {
                    let alert = UIAlertController(title: "Post Error Message", message: error, preferredStyle: .alert)
                    let alertButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                    alert.addAction(alertButton)
                    UserDefaults.standard.removeObject(forKey: "card_seq")
                    UserDefaults.standard.removeObject(forKey: "answer_Id")
                    UserDefaults.standard.synchronize()
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc
    private func toolbarButtonDidTap() {
        editAnswerSheetView.endEditing(true)
    }
    
    
    @objc
    private func showQuestionViewDidTap() {
        editAnswerSheetView.postAnswerTextView.resignFirstResponder()
        UserDefaults.standard.set(editAnswerSheetView.postAnswerTextView.text, forKey: "myQuestionText")
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.editAnswerSheetView.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: self.screenSize.height)
            })
        }
        postHomeCardSave()
    }
    
    @objc
    public func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardEndFrame = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardEndFrame.height
            let caret = editAnswerSheetView.postAnswerTextView.caretRect(for: editAnswerSheetView.postAnswerTextView.selectedTextRange!.start)
            editAnswerSheetView.postTextViewBottomConstraint.constant = keyboardHeight + 120
            editAnswerSheetView.postAnswerTextView.scrollRectToVisible(caret, animated: true)
            editAnswerSheetView.postAnswerTextView.contentInset.bottom = 10
            editAnswerSheetView.layoutIfNeeded()
        }
        
    }
    
    // TODO: - KeyBoardEvent
    @objc
    public func keyboardWillHide(_ notification: Notification) {
        if editAnswerSheetView.postAnswerTextView.bounds.size.height < editAnswerSheetView.postAnswerTextView.frame.size.height {
            editAnswerSheetView.postTextViewBottomConstraint.constant = 15
        } else {
            editAnswerSheetView.postTextViewBottomConstraint.constant = editAnswerSheetView.postAnswerTextView.bounds.height
        }
        editAnswerSheetView.postAnswerTextView.contentInset.bottom = 10
        editAnswerSheetView.layoutIfNeeded()
    }
    
    
    @objc
    public func showSideButtonDidTap() {
        self.present(sideMenu!, animated: true, completion: nil)
    }
    
    @objc
    private func showAlarmButtonDidTap(_ sender: UIButton) {
        let window = UIApplication.shared.windows.first
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let noticeView = storyboard.instantiateViewController(withIdentifier: "NoticeVC") as? NoticeViewController
        guard let noticeVC = noticeView else { return }
        if let editView = window?.viewWithTag(2) {
            editView.removeFromSuperview()
        }
        self.navigationController?.pushViewController(noticeVC, animated: true)
    }
    
    @objc
    private func hiddenBottomSheetDidTap() {
        let alert = UIAlertController(title: "작성중인 내용을 \n완료하지 않고 나가시겠습니까?", message: nil, preferredStyle: .alert)
        let alertDeleteButton = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        let alertConfirmButton = UIAlertAction(title: "네", style: .default) { _ in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.editAnswerSheetView.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: self.screenSize.height)
            })
        }
        alert.addAction(alertDeleteButton)
        alert.addAction(alertConfirmButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc
    private func showLastAnswerButtonDidTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let lastAnswerView = storyboard.instantiateViewController(identifier: "LastAnswerVC") as? LastAnswerViewController
        let center = view.convert(homeBeforeCollectionView.center, to: homeBeforeCollectionView)
        let indexPath = self.homeBeforeCollectionView.indexPathForItem(at: center)
        lastAnswerView?.answerId = indexPath!.item
        lastAnswerView?.questId = homeData[indexPath!.item].seq
        guard let lastAnswerVC = lastAnswerView else { return }
        self.navigationController?.pushViewController(lastAnswerVC, animated: true)
    }
    
    @objc
    private func sharedBottomSheetButtonDidTap(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            isshare = "Y"
            editAnswerSheetView.postShareButton.setImage(UIImage(named: "UnLockBlack"), for: .normal)
        } else {
            sender.isSelected = true
            isshare = "N"
            editAnswerSheetView.postShareButton.setImage(UIImage(named: "lockBlack"), for: .selected)
        }
        
    }
    

    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("side menu WillApper ")
        sideMenu?.setSideMenuNavigation(viewcontroller: self)
    }
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        sideMenu?.deleteEffectViewNavigation(viewcontroller: self)
    }
}

extension HomeBeforeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.homeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeBeforeCell", for: indexPath) as! HomeBeforeCollectionViewCell
        let ParagraphStyle = NSMutableParagraphStyle()
        ParagraphStyle.lineSpacing = 6
        print("색상 테스트\(homeData[indexPath.item].color)")
            if homeData[indexPath.item].lev == "1" {
                homeBeforeLastAnswerButton.isHidden = true
                homeBeforeLastAnswerButtonHeightConstraint.constant = 0
                homeBeforeLastAnswerButtonTopConstraint.constant = 0
            } else {
                homeBeforeLastAnswerButton.isHidden = false
                homeBeforeLastAnswerButtonHeightConstraint.constant = 60
                homeBeforeLastAnswerButtonTopConstraint.constant = 16
            }
        if homeData[indexPath.item].color == "red" {
            cell.homeBeforeCharacterLabel.text = "열정 충만"
            cell.homeBeforeCharacterLabel.textColor = UIColor(red: 244/255, green: 82/255, blue: 82/255, alpha: 1.0)
            cell.homeBeforeFirstTagLabel.text = "#열정"
            cell.homeBeforeSecondTagLabel.text = "#진로"
            cell.homeBeforeThirdTagLabel.text = "#미래"
            cell.homeBeforeFirstTagLabel.textColor = UIColor.primaryRed
            cell.homeBeforeSecondTagLabel.textColor = UIColor.primaryRed
            cell.homeBeforeThirdTagLabel.textColor = UIColor.primaryRed
        } else if homeData[indexPath.item].color == "yellow" {
            cell.homeBeforeCharacterLabel.text = "소소한 일상"
            cell.homeBeforeCharacterLabel.textColor = UIColor(red: 220/255, green: 174/255, blue: 9/255, alpha: 1.0)
            cell.homeBeforeFirstTagLabel.text = "#일상"
            cell.homeBeforeSecondTagLabel.text = "#추억"
            cell.homeBeforeThirdTagLabel.text = "#취향"
            cell.homeBeforeFirstTagLabel.textColor = UIColor.primaryYellow
            cell.homeBeforeSecondTagLabel.textColor = UIColor.primaryYellow
            cell.homeBeforeThirdTagLabel.textColor = UIColor.primaryYellow
        
        } else if homeData[indexPath.item].color == "green" {
            cell.homeBeforeCharacterLabel.text = "기억상자"
            cell.homeBeforeCharacterLabel.textColor = UIColor(red: 31/255, green: 176/255, blue: 115/255, alpha: 1.0)
            cell.homeBeforeFirstTagLabel.text = "#힐링"
            cell.homeBeforeSecondTagLabel.text = "#치유"
            cell.homeBeforeThirdTagLabel.text = "#위로"
            cell.homeBeforeFirstTagLabel.textColor = UIColor.primaryGreen
            cell.homeBeforeSecondTagLabel.textColor = UIColor.primaryGreen
            cell.homeBeforeThirdTagLabel.textColor = UIColor.primaryGreen
        } else if homeData[indexPath.item].color == "pink" {
            cell.homeBeforeCharacterLabel.text = "관계의 미학"
            cell.homeBeforeCharacterLabel.textColor = UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0)
            cell.homeBeforeFirstTagLabel.text = "#연애"
            cell.homeBeforeSecondTagLabel.text = "#사랑"
            cell.homeBeforeThirdTagLabel.text = "#가치관"
            cell.homeBeforeFirstTagLabel.textColor = UIColor.primaryPink
            cell.homeBeforeSecondTagLabel.textColor = UIColor.primaryPink
            cell.homeBeforeThirdTagLabel.textColor = UIColor.primaryPink
        } else {
            cell.homeBeforeCharacterLabel.text = "상상 플러스"
            cell.homeBeforeCharacterLabel.textColor = UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0)
            cell.homeBeforeFirstTagLabel.text = "#만약에"
            cell.homeBeforeSecondTagLabel.text = "#상상"
            cell.homeBeforeThirdTagLabel.text = "#희망"
            cell.homeBeforeFirstTagLabel.textColor = UIColor.primaryPurple
            cell.homeBeforeSecondTagLabel.textColor = UIColor.primaryPurple
            cell.homeBeforeThirdTagLabel.textColor = UIColor.primaryPurple
        }
        if homeData[indexPath.item].lev == "1" {
            cell.homeBeforeLevelLabel.isHidden = true
            cell.homeBeforeLevelBoxView.isHidden = true
            let attributedString = NSMutableAttributedString(string: "LV. \(homeData[indexPath.item].lev)", attributes: [
              .font: UIFont(name: "GmarketSansBold", size: 12.0)!,
              .foregroundColor: UIColor(white: 0.0, alpha: 1.0)
            ])
            attributedString.addAttribute(.font, value: UIFont(name: "GmarketSansBold", size: 13.0)!, range: NSRange(location: 3, length: 2))
            cell.homeBeforeLevelLabel.attributedText = attributedString
        } else {
            cell.homeBeforeLevelLabel.isHidden = false
            cell.homeBeforeLevelBoxView.isHidden = false
            let attributedString = NSMutableAttributedString(string: "LV. \(homeData[indexPath.item].lev)", attributes: [
              .font: UIFont(name: "GmarketSansBold", size: 12.0)!,
              .foregroundColor: UIColor(white: 0.0, alpha: 1.0)
            ])
            attributedString.addAttribute(.font, value: UIFont(name: "GmarketSansBold", size: 13.0)!, range: NSRange(location: 3, length: 2))
            cell.homeBeforeLevelLabel.attributedText = attributedString
        }
        
        cell.homeBeforeTitleLabel.attributedText = NSAttributedString(string: homeData[indexPath.item].question, attributes: [NSAttributedString.Key.paragraphStyle: ParagraphStyle])
        cell.homeBeforeTitleLabel.text = homeData[indexPath.item].question
        cell.homeBeforeTitleLabel.textAlignment = .center
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? HomeBeforeCollectionViewCell
        let height = self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        selectIndex = indexPath.item
        questionTitleText = (cell?.homeBeforeTitleLabel.text)!
        let window = UIApplication.shared.windows.first
        window?.addSubview(self.editAnswerSheetView)
        homeBeforeBottomSheetLayoutInit()
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                    self.editAnswerSheetView.frame = CGRect(x: 0, y: self.screenSize.height - (self.screenSize.height - height - 12), width: self.screenSize.width, height: self.screenSize.height + height + 12)
                })
            }
        }
    }

    func scrollViewDidScroll(_ scrollView:UIScrollView) {
        let midX:CGFloat = scrollView.bounds.midX
        let midY:CGFloat = scrollView.bounds.midY
        let point:CGPoint = CGPoint(x:midX, y:midY)
        guard let indexPath = homeBeforeCollectionView.indexPathForItem(at: point) else { return  }
        currentPage = indexPath.item
        if homeData[currentPage].lev == "1" {
            homeBeforeLastAnswerButton.isHidden = true
            homeBeforeLastAnswerButtonHeightConstraint.constant = 0
            homeBeforeLastAnswerButtonTopConstraint.constant = 0
        } else {
            homeBeforeLastAnswerButton.isHidden = false
            homeBeforeLastAnswerButtonHeightConstraint.constant = 60
            homeBeforeLastAnswerButtonTopConstraint.constant = 16
        }
        print("colletionView point\(point)")
        if homeData[currentPage].color == "red" {
            homeBeforeBackgroundImageView.image = UIImage(named: "img_background_red.png")
        } else if homeData[currentPage].color == "yellow" {
            self.homeBeforeBackgroundImageView.image = UIImage(named: "img_background_yellow.png")
        } else if homeData[currentPage].color == "green" {
            self.homeBeforeBackgroundImageView.image = UIImage(named: "img_background_green.png")
        } else if homeData[currentPage].color == "pink" {
            self.homeBeforeBackgroundImageView.image = UIImage(named: "img_background_pink.png")
        } else {
            self.homeBeforeBackgroundImageView.image = UIImage(named: "img_background_purple.png")
        }
    }
}

class HomeCollectionViewFlowLayout: UICollectionViewFlowLayout {
    private var previousOffset: CGFloat = 0
    private var currentPage: Int = 0
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        if previousOffset > collectionView.contentOffset.x && velocity.x < 0 {
            currentPage = max(currentPage - 1, 0)
        } else if previousOffset < collectionView.contentOffset.x && velocity.x > 0 {
            currentPage = min(currentPage + 1, itemsCount - 1)
        }
        
        let updatedOffset = (itemSize.width + minimumLineSpacing) * CGFloat(currentPage)
        previousOffset = updatedOffset
        
        return CGPoint(x: updatedOffset, y: proposedContentOffset.y)
    }
}


extension HomeBeforeViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        if textView.textColor == .gray999 {
            editAnswerSheetView.postConfirmButton.isEnabled = true
            textView.text = nil
            textView.textAlignment = .left
            textView.typingAttributes = [NSAttributedString.Key.paragraphStyle : paragraphStyle, NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 16),NSAttributedString.Key.foregroundColor:UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)]
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            editAnswerSheetView.postConfirmButton.isEnabled = false
            textView.text = "당신의 생각을 말해주세요"
            textView.textColor = .gray999
        }
    }
    
}

extension SideMenuNavigationController: SideMenuNavigationControllerDelegate {
    func setSideMenuNavigation(viewcontroller: UIViewController) {
        let effectView = UIView()
        effectView.frame = viewcontroller.view.frame
        effectView.tag = 1
        if let view = viewcontroller.view.viewWithTag(1) {
            view.removeFromSuperview()
        }
        viewcontroller.navigationController?.navigationBar.alpha = 0.5
        UIView.animate(withDuration: 0.2, delay: 1, options: .curveEaseInOut, animations: {
            effectView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            viewcontroller.view.addSubview(effectView)
        }, completion: nil)
    }
    
    func deleteEffectViewNavigation(viewcontroller: UIViewController) {
        viewcontroller.navigationController?.navigationBar.alpha = 1.0
        if let view = viewcontroller.view.viewWithTag(1) {
            view.removeFromSuperview()
        }
    }
    
    public func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        self.setSideMenuNavigation(viewcontroller: self)
    }
    public func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        self.deleteEffectViewNavigation(viewcontroller: self)
    }
}
