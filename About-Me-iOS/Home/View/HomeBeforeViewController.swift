//
//  ViewController.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/03/25.
//

import UIKit
import SideMenu
import Hero
import Floaty

class HomeBeforeViewController: UIViewController, SideMenuNavigationControllerDelegate {
    @IBOutlet weak var homeBeforeBackgroundImageView: UIImageView!
    @IBOutlet weak var homeBeforeFloatingButton: Floaty!
    @IBOutlet weak var homeBeforeCollectionView: UICollectionView!
    @IBOutlet weak var homeBeforeLastAnswerButton: UIButton!
    private var homeData = [HomeCardListModel]()
    public var sideMenu: SideMenuNavigationController?
    public var questionTitleText: String = ""
    public let lineSpacing: CGFloat = 15
    public var currentPage:Int = 0
    public var selectIndex:Int = 0
    public var screenSize = UIScreen.main.bounds.size
    public var isshare = "N"
    public var backgroundColor = ""
    
    
    lazy var editAnswerSheetView: PostBottomSheetView = {
        let sheetView = Bundle.main.loadNibNamed("PostBottomSheetView", owner: self, options: nil)?.first as? PostBottomSheetView
        sheetView?.frame = CGRect(x: self.view.frame.origin.x, y: self.screenSize.height, width: self.screenSize.width, height: sheetView!.frame.size.height)
        sheetView?.postConfirmButton.addTarget(self, action: #selector(self.showQuestionViewDidTap), for: .touchUpInside)
        sheetView?.postCancelButton.addTarget(self, action: #selector(self.hiddenBottomSheetDidTap), for: .touchUpInside)
        sheetView?.postShareButton.addTarget(self, action: #selector(self.sharedBottomSheetButtonDidTap(_:)), for: .touchUpInside)
        sheetView?.postAnswerTextView.delegate = self
        return sheetView!
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getHomeCardList()
        self.setLayoutInit()
        self.setSideMenuLayoutInit()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    
    private func setSideMenuLayoutInit() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sideOnlyViewController: SideOnlyViewController = storyboard.instantiateViewController(withIdentifier: "SideOnlyViewController") as! SideOnlyViewController
        self.sideMenu = SideMenuNavigationController(rootViewController: sideOnlyViewController)
        self.sideMenu?.leftSide = true
    }
    
    private func setLayoutInit() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu.png"), style: .plain, target: self, action: #selector(self.showSideButtonDidTap))
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Bell.png"), style: .plain, target: self, action: #selector(self.showAlarmButtonDidTap))
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
        self.homeBeforeBackgroundImageView.image = UIImage(named: "imgBackgroundRed.png")
        let cellWidth = floor(view.frame.width * 0.85)
        let layout = HomeCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = self.lineSpacing
        layout.itemSize = CGSize(width: cellWidth, height: 420)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        self.homeBeforeCollectionView.collectionViewLayout = layout
        self.homeBeforeCollectionView.delegate = self
        self.homeBeforeCollectionView.dataSource = self
        self.homeBeforeCollectionView.backgroundColor = UIColor.clear
        self.homeBeforeCollectionView.register(mainNib, forCellWithReuseIdentifier: "homeBeforeCell")
        self.homeBeforeCollectionView.showsHorizontalScrollIndicator = false
        self.homeBeforeCollectionView.isPagingEnabled = false
        self.homeBeforeBackgroundImageView.contentMode = .scaleToFill
        self.homeBeforeCollectionView.decelerationRate = .fast
        self.homeBeforeFloatingButton.buttonColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.homeBeforeFloatingButton.plusColor = UIColor.white
        self.homeBeforeFloatingButton.selectedColor = UIColor.gray999
        self.homeBeforeFloatingButton.sticky = true
        self.homeBeforeFloatingButton.addItem("오늘의 질문", icon: UIImage(named: "Home_Write.png")) { item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeView = storyboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeBeforeViewController
            guard let homeVC = homeView else { return }
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
        self.homeBeforeFloatingButton.addItem("자문 자답", icon: UIImage(named: "Question.png")) { item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let advisoryAnswerView = storyboard.instantiateViewController(withIdentifier: "AdvisoryAnswerVC") as? AdvisoryAnswerViewController
            guard let advisoryAnswerVC = advisoryAnswerView else { return }
            self.navigationController?.pushViewController(advisoryAnswerVC, animated: true)
        }
        self.homeBeforeFloatingButton.addItem("내 피드", icon: UIImage(named: "icoFeed.png")) { item in
            
        }
        self.homeBeforeLastAnswerButton.backgroundColor = .white
        self.homeBeforeLastAnswerButton.layer.cornerRadius = 15
        self.homeBeforeLastAnswerButton.layer.masksToBounds = true
        self.homeBeforeLastAnswerButton.setTitle("같은 질문 지난 응답 확인하기", for: .normal)
        self.homeBeforeLastAnswerButton.setTitleColor(UIColor.gray333, for: .normal)
        self.homeBeforeLastAnswerButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        self.homeBeforeLastAnswerButton.addTarget(self, action: #selector(self.showLastAnswerButtonDidTap), for: .touchUpInside)
    }
    
    
    private func homeBeforeBottomSheetLayoutInit() {
        let questionToolBar = UIToolbar()
        let fiexedButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.toolbarButtonDidTap))
        questionToolBar.items = [fiexedButton,doneButton]
        questionToolBar.sizeToFit()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        self.editAnswerSheetView.postQuestionLabel.attributedText = NSAttributedString(string:"\(self.questionTitleText)", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        self.editAnswerSheetView.postNavigationTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 18)
        self.editAnswerSheetView.postQuestionLabel.textColor = .gray333
        self.editAnswerSheetView.postQuestionLabel.font = UIFont(name: "GmarketSansMedium", size: 20)
        self.editAnswerSheetView.postQuestionLabel.numberOfLines = 0
        self.editAnswerSheetView.postQuestionLabel.textAlignment = .left
        self.editAnswerSheetView.postQuestionLabel.sizeToFit()
        self.editAnswerSheetView.postNumberLabel.text = "Q. "
        self.editAnswerSheetView.postNumberLabel.textColor = .gray333
        self.editAnswerSheetView.postNumberLabel.textAlignment = .left
        self.editAnswerSheetView.postNumberLabel.font = UIFont(name: "GmarketSansMedium", size: 18)
        self.editAnswerSheetView.postAnswerTextView.text = "당신의 생각을 말해주세요"
        self.editAnswerSheetView.postAnswerTextView.textColor = .gray999
        self.editAnswerSheetView.postAnswerTextView.textAlignment = .left
        self.editAnswerSheetView.postShareButton.isSelected = false
        self.editAnswerSheetView.postAnswerTextView.inputAccessoryView = questionToolBar
        self.editAnswerSheetView.layer.cornerRadius = 20
        self.editAnswerSheetView.layer.masksToBounds = true
        self.editAnswerSheetView.postConfirmButton.isEnabled = false
        self.editAnswerSheetView.postShareButton.setImage(UIImage(named: "UnLock"), for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeBeforeViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeBeforeViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func getHomeCardList() {
        HomeServerApi.getHomeCardList(userId: 1) { result in
            if case let .success(data) = result, let list = data {
                print(self.homeData)
                DispatchQueue.main.async {
                    self.homeData = list.dailyLists
                    self.homeBeforeCollectionView.reloadData()
                    if self.homeData[0].lev == "1" {
                        self.homeBeforeLastAnswerButton.isHidden = false
                    } else {
                        self.homeBeforeLastAnswerButton.isHidden = true
                    }
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
        let parameter = HomeCardSaveParamter(answer: self.editAnswerSheetView.postAnswerTextView.text, color: self.homeData[self.selectIndex].color, level: Int(self.homeData[self.selectIndex].lev)!, share_yn: self.isshare, title: self.homeData[self.selectIndex].seq, user: 1)
        HomeServerApi.postHomecardListSave(parameter: parameter) { result in
            if case let .success(data) = result, let list = data {
                print(list.dailyLists[0].cardSeq, "카드 일련 번호 입니다")
                UserDefaults.standard.set(list.dailyLists[0].level, forKey: "homeBeforeLevel")
                UserDefaults.standard.set(list.dailyLists[0].cardSeq, forKey: "homeBeforeSeq")
            } else if case let .failure(error) = result {
                let alert = UIAlertController(title: "Post Error Message", message: error, preferredStyle: .alert)
                let alertButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(alertButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    @objc
    private func toolbarButtonDidTap() {
        self.editAnswerSheetView.endEditing(true)
    }
    
    
    @objc
    private func showQuestionViewDidTap() {
        self.editAnswerSheetView.postAnswerTextView.resignFirstResponder()
        self.postHomeCardSave()
        UserDefaults.standard.set(self.editAnswerSheetView.postAnswerTextView.text, forKey: "myQuestionText")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.editAnswerSheetView.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: self.screenSize.height)
        })
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeAfterView = storyboard.instantiateViewController(withIdentifier: "HomeAfterVC") as? HomeAfterViewController
        guard let homeAfterVC = homeAfterView else { return }
        homeAfterVC.titleText = self.questionTitleText
        homeAfterVC.backgroundColor = self.homeData[self.selectIndex].color
        homeAfterVC.answerLevel = self.homeData[self.selectIndex].lev
        self.navigationController?.pushViewController(homeAfterVC, animated: true)
    }
    
    // TODO: - KeyBoardEvent
    
    @objc
    public func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardEndFrame = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardEndFrame.height
            let caret = self.editAnswerSheetView.postAnswerTextView.caretRect(for: self.editAnswerSheetView.postAnswerTextView.selectedTextRange!.start)
            self.editAnswerSheetView.postTextViewBottomConstraint.constant = keyboardHeight + 120
            self.editAnswerSheetView.postAnswerTextView.scrollRectToVisible(caret, animated: true)
            self.editAnswerSheetView.postAnswerTextView.contentInset.bottom = 10
            self.editAnswerSheetView.layoutIfNeeded()
        }
        
    }
    
    // TODO: - KeyBoardEvent
    @objc
    public func keyboardWillHide(_ notification: Notification) {
        if self.editAnswerSheetView.postAnswerTextView.bounds.size.height < self.editAnswerSheetView.postAnswerTextView.frame.size.height {
            self.editAnswerSheetView.postTextViewBottomConstraint.constant = 15
        } else {
            self.editAnswerSheetView.postTextViewBottomConstraint.constant = self.editAnswerSheetView.postAnswerTextView.bounds.height
        }
        self.editAnswerSheetView.postAnswerTextView.contentInset.bottom = 10
        self.editAnswerSheetView.layoutIfNeeded()
    }
    
    
    @objc
    public func showSideButtonDidTap() {
        self.present(sideMenu!, animated: true, completion: nil)
    }
    
    @objc
    private func showAlarmButtonDidTap() {
        
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
        let center = self.view.convert(self.homeBeforeCollectionView.center, to: self.homeBeforeCollectionView)
        let indexPath = self.homeBeforeCollectionView.indexPathForItem(at: center)
        lastAnswerView?.answerId = indexPath!.item
        guard let lastAnswerVC = lastAnswerView else { return }
        self.navigationController?.pushViewController(lastAnswerVC, animated: true)
    }
    
    @objc
    private func sharedBottomSheetButtonDidTap(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            isshare = "N"
            self.editAnswerSheetView.postShareButton.setImage(UIImage(named: "UnLock"), for: .normal)
        } else {
            sender.isSelected = true
            isshare = "Y"
            self.editAnswerSheetView.postShareButton.setImage(UIImage(named: "Lock"), for: .selected)
        }
        
    }
    

    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("side menu WillApper ")
        self.sideMenu?.setSideMenuNavigation(viewcontroller: self)
    }
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        self.sideMenu?.deleteEffectViewNavigation(viewcontroller: self)
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
        print("색상 테스트\(self.homeData[indexPath.item].color)")
        if self.homeData[indexPath.item].color == "red" {
            cell.homeBeforeCharacterLabel.text = "열정 충만"
            cell.homeBeforeCharacterLabel.textColor = UIColor(red: 244/255, green: 82/255, blue: 82/255, alpha: 1.0)
            cell.homeBeforeFirstTagLabel.text = "#열정"
            cell.homeBeforeSecondTagLabel.text = "#진로"
            cell.homeBeforeThirdTagLabel.text = "#미래"
            cell.homeBeforeFirstTagLabel.textColor = UIColor.primaryRed
            cell.homeBeforeSecondTagLabel.textColor = UIColor.primaryRed
            cell.homeBeforeThirdTagLabel.textColor = UIColor.primaryRed
        } else if self.homeData[indexPath.item].color == "yellow" {
            cell.homeBeforeCharacterLabel.text = "소소한 일상"
            cell.homeBeforeCharacterLabel.textColor = UIColor(red: 220/255, green: 174/255, blue: 9/255, alpha: 1.0)
            cell.homeBeforeFirstTagLabel.text = "#일상"
            cell.homeBeforeSecondTagLabel.text = "#추억"
            cell.homeBeforeThirdTagLabel.text = "#취향"
            cell.homeBeforeFirstTagLabel.textColor = UIColor.primaryYellow
            cell.homeBeforeSecondTagLabel.textColor = UIColor.primaryYellow
            cell.homeBeforeThirdTagLabel.textColor = UIColor.primaryYellow
        
        } else if self.homeData[indexPath.item].color == "green" {
            cell.homeBeforeCharacterLabel.text = "기억상자"
            cell.homeBeforeCharacterLabel.textColor = UIColor(red: 31/255, green: 176/255, blue: 115/255, alpha: 1.0)
            cell.homeBeforeFirstTagLabel.text = "#힐링"
            cell.homeBeforeSecondTagLabel.text = "#치유"
            cell.homeBeforeThirdTagLabel.text = "#위로"
            cell.homeBeforeFirstTagLabel.textColor = UIColor.primaryGreen
            cell.homeBeforeSecondTagLabel.textColor = UIColor.primaryGreen
            cell.homeBeforeThirdTagLabel.textColor = UIColor.primaryGreen
        } else if self.homeData[indexPath.item].color == "pink" {
            cell.homeBeforeCharacterLabel.text = "관계의 미학"
            cell.homeBeforeCharacterLabel.textColor = UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0)
            cell.homeBeforeFirstTagLabel.text = "#연애"
            cell.homeBeforeSecondTagLabel.text = "#사랑"
            cell.homeBeforeThirdTagLabel.text = "#가치관"
            cell.homeBeforeFirstTagLabel.textColor = UIColor.primaryPink
            cell.homeBeforeSecondTagLabel.textColor = UIColor.primaryPink
            cell.homeBeforeThirdTagLabel.textColor = UIColor.primaryPink
        } else  {
            cell.homeBeforeCharacterLabel.text = "상상 플러스"
            cell.homeBeforeCharacterLabel.textColor = UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0)
            cell.homeBeforeFirstTagLabel.text = "#만약에"
            cell.homeBeforeSecondTagLabel.text = "#상상"
            cell.homeBeforeThirdTagLabel.text = "#희망"
            cell.homeBeforeFirstTagLabel.textColor = UIColor.primaryPurple
            cell.homeBeforeSecondTagLabel.textColor = UIColor.primaryPurple
            cell.homeBeforeThirdTagLabel.textColor = UIColor.primaryPurple
        }
        if self.homeData[indexPath.item].lev == "1" {
            cell.homeBeforeLevelLabel.isHidden = true
        } else {
            cell.homeBeforeLevelLabel.isHidden = false
            let attributedString = NSMutableAttributedString(string: "LV. \(self.homeData[indexPath.item].lev)", attributes: [
              .font: UIFont(name: "GmarketSansBold", size: 12.0)!,
              .foregroundColor: UIColor(white: 0.0, alpha: 1.0)
            ])
            attributedString.addAttribute(.font, value: UIFont(name: "GmarketSansBold", size: 13.0)!, range: NSRange(location: 3, length: 2))
            cell.homeBeforeLevelLabel.attributedText = attributedString
        }
        
        cell.homeBeforeTitleLabel.attributedText = NSAttributedString(string: self.homeData[indexPath.item].question, attributes: [NSAttributedString.Key.paragraphStyle: ParagraphStyle])
        cell.homeBeforeTitleLabel.text = self.homeData[indexPath.item].question
        cell.homeBeforeTitleLabel.textAlignment = .center
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? HomeBeforeCollectionViewCell
        let height = self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        self.selectIndex = indexPath.item
        self.questionTitleText = (cell?.homeBeforeTitleLabel.text)!
        let window = UIApplication.shared.windows.first
        let screenSize = UIScreen.main.bounds.size
        window?.addSubview(self.editAnswerSheetView)
        self.homeBeforeBottomSheetLayoutInit()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.editAnswerSheetView.frame = CGRect(x: 0, y: self.screenSize.height - (self.screenSize.height - height - 12), width: self.screenSize.width, height: self.screenSize.height + height + 12)
        })
    }

    func scrollViewDidScroll(_ scrollView:UIScrollView) {
        let midX:CGFloat = scrollView.bounds.midX
        let midY:CGFloat = scrollView.bounds.midY
        let point:CGPoint = CGPoint(x:midX, y:midY)
        guard let indexPath = self.homeBeforeCollectionView.indexPathForItem(at: point) else { return  }
        self.currentPage = indexPath.item
        print("colletionView point\(point)")
        if self.homeData[self.currentPage].color == "red" {
            self.homeBeforeBackgroundImageView.image = UIImage(named: "imgBackgroundRed.png")
        } else if self.homeData[self.currentPage].color == "yellow" {
            self.homeBeforeBackgroundImageView.image = UIImage(named: "imgBackgroundYellow.png")
        } else if self.homeData[self.currentPage].color == "green" {
            self.homeBeforeBackgroundImageView.image = UIImage(named: "imgBackgroundGreen.png")
        } else if self.homeData[self.currentPage].color == "pink" {
            self.homeBeforeBackgroundImageView.image = UIImage(named: "imgBackgroundPink.png")
        } else {
            self.homeBeforeBackgroundImageView.image = UIImage(named: "imgBackgroundViolet.png")
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
        if self.previousOffset > collectionView.contentOffset.x && velocity.x < 0 {
            self.currentPage = max(self.currentPage - 1, 0)
        } else if previousOffset < collectionView.contentOffset.x && velocity.x > 0 {
            self.currentPage = min(self.currentPage + 1, itemsCount - 1)
        }
        
        let updatedOffset = (itemSize.width + minimumLineSpacing) * CGFloat(self.currentPage)
        self.previousOffset = updatedOffset
        
        return CGPoint(x: updatedOffset, y: proposedContentOffset.y)
    }
}


extension HomeBeforeViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        if textView.textColor == .gray999 {
            self.editAnswerSheetView.postConfirmButton.isEnabled = true
            textView.text = nil
            textView.textAlignment = .left
            textView.typingAttributes = [NSAttributedString.Key.paragraphStyle : paragraphStyle, NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 16),NSAttributedString.Key.foregroundColor:UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)]
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.editAnswerSheetView.postConfirmButton.isEnabled = false
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
        UIView.animate(withDuration: 0.2, delay: 1, options: .curveEaseInOut, animations: {
            effectView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            viewcontroller.view.addSubview(effectView)
        }, completion: nil)
    }
    
    func deleteEffectViewNavigation(viewcontroller: UIViewController) {
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
