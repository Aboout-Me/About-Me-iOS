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

class HomeBeforeViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var homeBeforeBackgroundImageView: UIImageView!
    @IBOutlet weak var homeBeforeFloatingButton: Floaty!
    @IBOutlet var homeBeforeBottomSheet: HomeBottomSheet!
    @IBOutlet weak var homeBeforeCollectionView: UICollectionView!
    @IBOutlet weak var homeBeforeLastAnswerButton: UIButton!
    private var homeData = [HomeCardListModel]()
    public var sideMenu: SideMenuNavigationController?
    public var questionTitleText: String = ""
    public let lineSpacing: CGFloat = 15
    public var currentPage:Int = 0
    public var selectIndex:Int = 0
    public var screenSize = UIScreen.main.bounds.size
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getHomeCardList()
        self.setLayoutInit()
        self.setSideMenuLayoutInit()
    }
    
    private func setSideMenuLayoutInit() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sideOnlyViewController: SideOnlyViewController = storyboard.instantiateViewController(withIdentifier: "SideOnlyViewController") as! SideOnlyViewController
        self.sideMenu = SideMenuNavigationController(rootViewController: sideOnlyViewController)
        self.sideMenu?.leftSide = true
    }
    
    private func setLayoutInit() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Vector.png"), style: .plain, target: self, action: #selector(self.showSideButtonDidTap))
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon.png"), style: .plain, target: self, action: #selector(self.showAlarmButtonDidTap))
        let mainNib = UINib(nibName: "HomeBeforeCollectionViewCell", bundle: nil)
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateString = dateFormatter.string(from: date)
        self.navigationController?.navigationBar.topItem?.title = dateString
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
        self.homeBeforeCollectionView.allowsMultipleSelection = true
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
        self.homeBeforeFloatingButton.addItem("오늘의 질문", icon: UIImage(named: "Write.png"))
        self.homeBeforeFloatingButton.addItem("자문 자답", icon: UIImage(named: "SelfQuestion.png")) { item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let advisoryAnswerView = storyboard.instantiateViewController(withIdentifier: "AdvisoryAnswerVC") as? AdvisoryAnswerViewController
            guard let advisoryAnswerVC = advisoryAnswerView else { return }
            self.navigationController?.pushViewController(advisoryAnswerVC, animated: true)
        }
        self.homeBeforeFloatingButton.addItem("내 피드", icon: UIImage(named: "Feed.png"))
        self.homeBeforeLastAnswerButton.backgroundColor = .white
        self.homeBeforeLastAnswerButton.layer.cornerRadius = 15
        self.homeBeforeLastAnswerButton.layer.masksToBounds = true
        self.homeBeforeLastAnswerButton.setTitle("같은 질문 지난 응답 확인하기", for: .normal)
        self.homeBeforeLastAnswerButton.setTitleColor(.black, for: .normal)
        self.homeBeforeLastAnswerButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        self.homeBeforeLastAnswerButton.addTarget(self, action: #selector(self.showLastAnswerButtonDidTap), for: .touchUpInside)
    }
    
    
    private func homeBeforeBottomSheetLayoutInit() {
        let questionToolBar = UIToolbar()
        let fiexedButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.toolbarButtonDidTap))
        questionToolBar.items = [fiexedButton,doneButton]
        questionToolBar.sizeToFit()
        self.homeBeforeBottomSheet.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: self.screenSize.height / 2)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        self.homeBeforeBottomSheet.questionTitleLabel.attributedText = NSAttributedString(string:"\(self.questionTitleText)", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        self.homeBeforeBottomSheet.questionTitleLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.homeBeforeBottomSheet.questionTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 20)
        self.homeBeforeBottomSheet.questionTitleLabel.numberOfLines = 0
        self.homeBeforeBottomSheet.questionTitleLabel.textAlignment = .left
        self.homeBeforeBottomSheet.questionTitleLabel.sizeToFit()
        self.homeBeforeBottomSheet.questionQizeTitleLabel.text = "Q. "
        self.homeBeforeBottomSheet.questionQizeTitleLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.homeBeforeBottomSheet.questionQizeTitleLabel.textAlignment = .left
        self.homeBeforeBottomSheet.questionQizeTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 18)
        self.homeBeforeBottomSheet.questionTextView.delegate = self
        self.homeBeforeBottomSheet.questionTextView.text = "당신의 생각을 말해주세요"
        self.homeBeforeBottomSheet.questionTextView.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        self.homeBeforeBottomSheet.questionTextView.isScrollEnabled = false
        self.homeBeforeBottomSheet.questionTextView.inputAccessoryView = questionToolBar
        self.homeBeforeBottomSheet.layer.cornerRadius = 20
        self.homeBeforeBottomSheet.layer.masksToBounds = true
        self.homeBeforeBottomSheet.backgroundColor = UIColor.white
        self.homeBeforeBottomSheet.questionConfirmButton.isEnabled = false
        self.homeBeforeBottomSheet.questionNavigationBar.shadowImage = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0).imageFormatting()
        self.homeBeforeBottomSheet.questionNavigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18)!]
        self.homeBeforeBottomSheet.questionDeleteButton.addTarget(self, action: #selector(self.hiddenBottomSheetDidTap), for: .touchUpInside)
        self.homeBeforeBottomSheet.questionConfirmButton.addTarget(self, action: #selector(self.showQuestionViewDidTap), for: .touchUpInside)
    }
    
    private func getHomeCardList() {
        HomeServerApi.getHomeCardList(userId: 1) { result in
            if case let .success(data) = result, let list = data {
                print(self.homeData)
                DispatchQueue.main.async {
                    self.homeData = list.dailyLists
                    self.homeBeforeCollectionView.reloadData()
                    if self.homeData[0].lev == "1" {
                        self.homeBeforeLastAnswerButton.isHidden = true
                    } else {
                        self.homeBeforeLastAnswerButton.isHidden = false
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
        let parameter = HomeCardSaveParamter(answer: self.homeBeforeBottomSheet.questionTextView.text, color: self.homeData[self.selectIndex].color, level: Int(self.homeData[self.selectIndex].lev)!, share_yn: "Y", title: self.homeData[self.selectIndex].seq, user: 1)
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
        self.homeBeforeBottomSheet.endEditing(true)
    }
    
    
    @objc
    private func showQuestionViewDidTap() {
        self.homeBeforeBottomSheet.questionTextView.resignFirstResponder()
        self.postHomeCardSave()
        UserDefaults.standard.set(self.homeBeforeBottomSheet.questionTextView.text, forKey: "myQuestionText")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.homeBeforeBottomSheet.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: self.screenSize.height / 1.05)
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
        
    }
    
    // TODO: - KeyBoardEvent
    @objc
    public func keyboardWillHide(_ notification: Notification) {
        
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
            let screenSize = UIScreen.main.bounds.size
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                self.homeBeforeBottomSheet.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 1.2)
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
        guard let lastAnswerVC = lastAnswerView else { return }
        self.navigationController?.pushViewController(lastAnswerVC, animated: true)
        
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        if textView.textColor == UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0) {
            self.homeBeforeBottomSheet.questionConfirmButton.isEnabled = true
            textView.text = nil
            textView.textAlignment = .left
            textView.typingAttributes = [NSAttributedString.Key.paragraphStyle : paragraphStyle, NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 16),NSAttributedString.Key.foregroundColor:UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)]
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.homeBeforeBottomSheet.questionConfirmButton.isEnabled = false
            textView.text = "당신의 생각을 말해주세요"
            textView.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        }
    }
        
}

extension HomeBeforeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.homeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeBeforeCell", for: indexPath) as! HomeBeforeCollectionViewCell
        let ParagraphStyle = NSMutableParagraphStyle()
        ParagraphStyle.lineSpacing = 4
        print("색상 테스트\(self.homeData[indexPath.item].color)")
        if self.homeData[indexPath.item].color == "red" {
            cell.homeBeforeCharacterLabel.text = "열정 충만"
            cell.homeBeforeCharacterLabel.textColor = UIColor(red: 244/255, green: 82/255, blue: 82/255, alpha: 1.0)
            cell.homeBeforeCharacterTagFirstButton.setTitle("#열정", for: .normal)
            cell.homeBeforeCharacterTagFirstButton.setTitleColor(UIColor(red: 244/255, green: 82/255, blue: 82/255, alpha: 1.0), for: .normal)
            cell.homeBeforeCharacterTagSecondButton.setTitle("#진로", for: .normal)
            cell.homeBeforeCharacterTagSecondButton.setTitleColor(UIColor(red: 244/255, green: 82/255, blue: 82/255, alpha: 1.0), for: .normal)
            cell.homeBeforeCharacterTagThirdButton.setTitle("#미래", for: .normal)
            cell.homeBeforeCharacterTagThirdButton.setTitleColor(UIColor(red: 244/255, green: 82/255, blue: 82/255, alpha: 1.0), for: .normal)
        } else if self.homeData[indexPath.item].color == "yellow" {
            cell.homeBeforeCharacterLabel.text = "소소한 일상"
            cell.homeBeforeCharacterLabel.textColor = UIColor(red: 220/255, green: 174/255, blue: 9/255, alpha: 1.0)
            cell.homeBeforeCharacterTagFirstButton.setTitle("#일상", for: .normal)
            cell.homeBeforeCharacterTagFirstButton.setTitleColor(UIColor(red: 220/255, green: 174/255, blue: 9/255, alpha: 1.0), for: .normal)
            cell.homeBeforeCharacterTagSecondButton.setTitle("#추억", for: .normal)
            cell.homeBeforeCharacterTagSecondButton.setTitleColor(UIColor(red: 220/255, green: 174/255, blue: 9/255, alpha: 1.0), for: .normal)
            cell.homeBeforeCharacterTagThirdButton.setTitle("#취향", for: .normal)
            cell.homeBeforeCharacterTagThirdButton.setTitleColor(UIColor(red: 220/255, green: 174/255, blue: 9/255, alpha: 1.0), for: .normal)
        } else if self.homeData[indexPath.item].color == "green" {
            cell.homeBeforeCharacterLabel.text = "기억상자"
            cell.homeBeforeCharacterLabel.textColor = UIColor(red: 31/255, green: 176/255, blue: 115/255, alpha: 1.0)
            cell.homeBeforeCharacterTagFirstButton.setTitle("#힐링", for: .normal)
            cell.homeBeforeCharacterTagFirstButton.setTitleColor(UIColor(red: 31/255, green: 176/255, blue: 115/255, alpha: 1.0), for: .normal)
            cell.homeBeforeCharacterTagSecondButton.setTitle("#치유", for: .normal)
            cell.homeBeforeCharacterTagSecondButton.setTitleColor(UIColor(red: 31/255, green: 176/255, blue: 115/255, alpha: 1.0), for: .normal)
            cell.homeBeforeCharacterTagThirdButton.setTitle("#위로", for: .normal)
            cell.homeBeforeCharacterTagThirdButton.setTitleColor(UIColor(red: 31/255, green: 176/255, blue: 115/255, alpha: 1.0), for: .normal)
            
        } else if self.homeData[indexPath.item].color == "pink" {
            cell.homeBeforeCharacterLabel.text = "관계의 미학"
            cell.homeBeforeCharacterLabel.textColor = UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0)
            cell.homeBeforeCharacterTagFirstButton.setTitle("#연애", for: .normal)
            cell.homeBeforeCharacterTagFirstButton.setTitleColor(UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0), for: .normal)
            cell.homeBeforeCharacterTagSecondButton.setTitle("#사랑", for: .normal)
            cell.homeBeforeCharacterTagSecondButton.setTitleColor(UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0), for: .normal)
            cell.homeBeforeCharacterTagThirdButton.setTitle("#가치관", for: .normal)
            cell.homeBeforeCharacterTagThirdButton.setTitleColor(UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0), for: .normal)
        } else  {
            cell.homeBeforeCharacterLabel.text = "상상 플러스"
            cell.homeBeforeCharacterLabel.textColor = UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0)
            cell.homeBeforeCharacterTagFirstButton.setTitle("#만약에", for: .normal)
            cell.homeBeforeCharacterTagFirstButton.setTitleColor(UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0), for: .normal)
            cell.homeBeforeCharacterTagSecondButton.setTitle("#상상", for: .normal)
            cell.homeBeforeCharacterTagSecondButton.setTitleColor(UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0), for: .normal)
            cell.homeBeforeCharacterTagThirdButton.setTitle("#희망", for: .normal)
            cell.homeBeforeCharacterTagThirdButton.setTitleColor(UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0), for: .normal)
        }
        cell.homeBeforeTitleLabel.attributedText = NSAttributedString(string: self.homeData[indexPath.item].question, attributes: [NSAttributedString.Key.paragraphStyle: ParagraphStyle])
        cell.homeBeforeTitleLabel.text = self.homeData[indexPath.item].question
        cell.homeBeforeTitleLabel.textAlignment = .center
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? HomeBeforeCollectionViewCell
        self.selectIndex = indexPath.item
        self.questionTitleText = (cell?.homeBeforeTitleLabel.text)!
        let window = UIApplication.shared.windows.first
        let screenSize = UIScreen.main.bounds.size
        window?.addSubview(self.homeBeforeBottomSheet)
        self.homeBeforeBottomSheetLayoutInit()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.homeBeforeBottomSheet.frame = CGRect(x: 0, y: screenSize.height - screenSize.height / 1.05, width: screenSize.width, height: screenSize.height + self.view.safeAreaInsets.bottom)
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


class HomeBottomSheet: UIView {
    
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var questionConfirmButton: UIButton!
    @IBOutlet weak var questionDeleteButton: UIButton!
    @IBOutlet weak var questionQizeTitleLabel: UILabel!
    @IBOutlet weak var questionPrivateButton: UIButton!
    @IBOutlet weak var questionNavigationBar: BottomNavigationBar!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class BottomNavigationBar: UINavigationBar {
    @IBInspectable var customHeight : CGFloat = 66
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: self.customHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for subview in self.subviews {
            var stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("UIBarBackground") {
                subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.customHeight)
                subview.sizeToFit()
            }
            stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("UINavigationBarContentView") {
                let centerY = (self.customHeight - subview.frame.height) / 2.0
                subview.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
                subview.frame = CGRect(x: 0, y: centerY, width: self.frame.width, height: subview.frame.height)
                subview.sizeToFit()

            }
            stringFromClass = NSStringFromClass(subview.classForCoder)
        }
    }
}


extension UIColor {
    func imageFormatting() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        let ctx = UIGraphicsGetCurrentContext()
        self.setFill()
        ctx!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
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
