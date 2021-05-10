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

class ViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var mainBackgroundImageView: UIImageView!
    @IBOutlet weak var mainFloatingButton: Floaty!
    @IBOutlet var mainBottomSheet: HomeBottomSheet!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var mainLastAnswerButton: UIButton!
    private var homeData = [HomeCardListModel]()
    public var sideMenu: SideMenuNavigationController?
    public var questionTitleText: String = ""
    public let lineSpacing: CGFloat = 40
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
        let mainNib = UINib(nibName: "MainCollectionViewCell", bundle: nil)
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
        self.mainBackgroundImageView.image = UIImage(named: "imgBackgroundRed.png")
        let cellWidth = floor(view.frame.width * 0.7)
        let layout = HomeCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = self.lineSpacing
        layout.itemSize = CGSize(width: cellWidth, height: 420)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 60)
        self.mainCollectionView.collectionViewLayout = layout
        self.mainCollectionView.allowsMultipleSelection = true
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
        self.mainCollectionView.backgroundColor = UIColor.clear
        self.mainCollectionView.register(mainNib, forCellWithReuseIdentifier: "mainCell")
        self.mainCollectionView.showsHorizontalScrollIndicator = false
        self.mainCollectionView.isPagingEnabled = false
        self.mainCollectionView.decelerationRate = .fast
        self.mainFloatingButton.buttonColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.mainFloatingButton.plusColor = UIColor.white
        self.mainFloatingButton.addItem("오늘의 질문", icon: UIImage(named: "Write.png"))
        self.mainFloatingButton.addItem("자문 자답", icon: UIImage(named: "SelfQuestion.png")) { item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let advisoryAnswerView = storyboard.instantiateViewController(withIdentifier: "AdvisoryAnswerVC") as? AdvisoryAnswerViewController
            guard let advisoryAnswerVC = advisoryAnswerView else { return }
            self.navigationController?.pushViewController(advisoryAnswerVC, animated: true)
        }
        self.mainFloatingButton.addItem("내 피드", icon: UIImage(named: "Feed.png"))
        self.mainLastAnswerButton.backgroundColor = .white
        self.mainLastAnswerButton.layer.cornerRadius = 15
        self.mainLastAnswerButton.layer.masksToBounds = true
        self.mainLastAnswerButton.setTitle("같은 질문 지난 응답 확인하기", for: .normal)
        self.mainLastAnswerButton.setTitleColor(.black, for: .normal)
        self.mainLastAnswerButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        self.mainLastAnswerButton.addTarget(self, action: #selector(self.showLastAnswerButtonDidTap), for: .touchUpInside)
    }
    
    
    private func mainBottomSheetLayoutInit() {
        let questionToolBar = UIToolbar()
        let fiexedButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.toolbarButtonDidTap))
        questionToolBar.items = [fiexedButton,doneButton]
        questionToolBar.sizeToFit()
        self.mainBottomSheet.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: self.screenSize.height / 2)
        self.mainBottomSheet.questionTitleLabel.text = "Q. \(self.questionTitleText)"
        self.mainBottomSheet.questionTitleLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.mainBottomSheet.questionTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 20)
        self.mainBottomSheet.questionTitleLabel.numberOfLines = 0
        self.mainBottomSheet.questionTitleLabel.textAlignment = .left
        self.mainBottomSheet.questionTextView.delegate = self
        self.mainBottomSheet.questionTextView.text = "당신의 생각을 말해주세요"
        self.mainBottomSheet.questionTextView.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        self.mainBottomSheet.questionTextView.isScrollEnabled = false
        self.mainBottomSheet.questionTextView.inputAccessoryView = questionToolBar
        self.mainBottomSheet.layer.cornerRadius = 20
        self.mainBottomSheet.layer.masksToBounds = true
        self.mainBottomSheet.backgroundColor = UIColor.white
        self.mainBottomSheet.questionNavigationBar.shadowImage = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0).imageFormatting()
        self.mainBottomSheet.questionDeleteButton.addTarget(self, action: #selector(self.hiddenBottomSheetDidTap), for: .touchUpInside)
        self.mainBottomSheet.questionConfirmButton.addTarget(self, action: #selector(self.showQuestionViewDidTap), for: .touchUpInside)
    }
    
    private func getHomeCardList() {
        HomeServerApi.getHomeCardList(userId: 1) { result in
            if case let .success(data) = result, let list = data {
                print(self.homeData)
                DispatchQueue.main.async {
                    self.homeData = list.dailyLists
                    self.mainCollectionView.reloadData()
                }
            } else if case let .failure(error) = result {
                //AlertViewController 추가
                print(error)
            }
        }
    }
    
    
    @objc
    private func toolbarButtonDidTap() {
        self.mainBottomSheet.endEditing(true)
    }
    
    
    @objc
    private func showQuestionViewDidTap() {
        UserDefaults.standard.set(self.mainBottomSheet.questionTextView.text, forKey: "myQuestionText")
        self.mainBottomSheet.questionTextView.resignFirstResponder()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.mainBottomSheet.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: self.screenSize.height / 1.05)
        })
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeAfterView = storyboard.instantiateViewController(withIdentifier: "HomeAfterVC") as? HomeAfterViewController
        guard let homeAfterVC = homeAfterView else { return }
        homeAfterVC.titleText = self.questionTitleText
        self.navigationController?.pushViewController(homeAfterVC, animated: true)
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
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.mainBottomSheet.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 1.2)
        })
    }
    
    @objc
    private func showLastAnswerButtonDidTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let lastAnswerView = storyboard.instantiateViewController(identifier: "LastAnswerVC") as? LastAnswerViewController
        guard let lastAnswerVC = lastAnswerView else { return }
        self.navigationController?.pushViewController(lastAnswerVC, animated: true)
        
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0) {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "당신의 생각을 말해주세요"
            textView.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        }
    }
    
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.homeData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! MainCollectionViewCell
        print("색상 테스트\(self.homeData[indexPath.item].color)")
        if self.homeData[indexPath.item].color == "red" {
            cell.mainCharacterLabel.text = "프로 열정러"
            cell.mainCharacterLabel.textColor = UIColor(red: 244/255, green: 82/255, blue: 82/255, alpha: 1.0)
            cell.mainCharacterTagFirstButton.setTitle("#열정", for: .normal)
            cell.mainCharacterTagFirstButton.setTitleColor(UIColor(red: 244/255, green: 82/255, blue: 82/255, alpha: 1.0), for: .normal)
            cell.mainCharacterTagSecondButton.setTitle("#진로", for: .normal)
            cell.mainCharacterTagSecondButton.setTitleColor(UIColor(red: 244/255, green: 82/255, blue: 82/255, alpha: 1.0), for: .normal)
            cell.mainCharacterTagThirdButton.setTitle("#미래", for: .normal)
            cell.mainCharacterTagThirdButton.setTitleColor(UIColor(red: 244/255, green: 82/255, blue: 82/255, alpha: 1.0), for: .normal)
        } else if self.homeData[indexPath.item].color == "yellow" {
            cell.mainCharacterLabel.text = "소소한 일상"
            cell.mainCharacterLabel.textColor = UIColor(red: 220/255, green: 174/255, blue: 9/255, alpha: 1.0)
            cell.mainCharacterTagFirstButton.setTitle("#일상", for: .normal)
            cell.mainCharacterTagFirstButton.setTitleColor(UIColor(red: 220/255, green: 174/255, blue: 9/255, alpha: 1.0), for: .normal)
            cell.mainCharacterTagSecondButton.setTitle("#추억", for: .normal)
            cell.mainCharacterTagSecondButton.setTitleColor(UIColor(red: 220/255, green: 174/255, blue: 9/255, alpha: 1.0), for: .normal)
            cell.mainCharacterTagThirdButton.setTitle("#취향", for: .normal)
            cell.mainCharacterTagThirdButton.setTitleColor(UIColor(red: 220/255, green: 174/255, blue: 9/255, alpha: 1.0), for: .normal)
        } else if self.homeData[indexPath.item].color == "green" {
            self.mainBackgroundImageView.image = UIImage(named: "imgBackgroundGreen.png")
            cell.mainCharacterLabel.text = "기억상자"
            cell.mainCharacterLabel.textColor = UIColor(red: 31/255, green: 176/255, blue: 115/255, alpha: 1.0)
            cell.mainCharacterTagFirstButton.setTitle("#힐링", for: .normal)
            cell.mainCharacterTagFirstButton.setTitleColor(UIColor(red: 31/255, green: 176/255, blue: 115/255, alpha: 1.0), for: .normal)
            cell.mainCharacterTagSecondButton.setTitle("#치유", for: .normal)
            cell.mainCharacterTagSecondButton.setTitleColor(UIColor(red: 31/255, green: 176/255, blue: 115/255, alpha: 1.0), for: .normal)
            cell.mainCharacterTagThirdButton.setTitle("#위로", for: .normal)
            cell.mainCharacterTagThirdButton.setTitleColor(UIColor(red: 31/255, green: 176/255, blue: 115/255, alpha: 1.0), for: .normal)
            
        } else if self.homeData[indexPath.item].color == "pink" {
            self.mainBackgroundImageView.image = UIImage(named: "imgBackgroundPink.png")
            cell.mainCharacterLabel.text = "관계의 미학"
            cell.mainCharacterLabel.textColor = UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0)
            cell.mainCharacterTagFirstButton.setTitle("#연애", for: .normal)
            cell.mainCharacterTagFirstButton.setTitleColor(UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0), for: .normal)
            cell.mainCharacterTagSecondButton.setTitle("#사랑", for: .normal)
            cell.mainCharacterTagSecondButton.setTitleColor(UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0), for: .normal)
            cell.mainCharacterTagThirdButton.setTitle("#가치관", for: .normal)
            cell.mainCharacterTagThirdButton.setTitleColor(UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0), for: .normal)
        } else if self.homeData[indexPath.item].color == "purple" {
            self.mainBackgroundImageView.image = UIImage(named: "imgBackgroundViolet.png")
            cell.mainCharacterLabel.text = "상상 플러스"
            cell.mainCharacterLabel.textColor = UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0)
            cell.mainCharacterTagFirstButton.setTitle("#만약에", for: .normal)
            cell.mainCharacterTagFirstButton.setTitleColor(UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0), for: .normal)
            cell.mainCharacterTagSecondButton.setTitle("#상상", for: .normal)
            cell.mainCharacterTagSecondButton.setTitleColor(UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0), for: .normal)
            cell.mainCharacterTagThirdButton.setTitle("#희망", for: .normal)
            cell.mainCharacterTagThirdButton.setTitleColor(UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0), for: .normal)
        }
        cell.mainTitleLabel.text = self.homeData[indexPath.item].question
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? MainCollectionViewCell
        self.questionTitleText = (cell?.mainTitleLabel.text)!
        let window = UIApplication.shared.windows.first
        let screenSize = UIScreen.main.bounds.size
        window?.addSubview(self.mainBottomSheet)
        self.mainBottomSheetLayoutInit()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.mainBottomSheet.frame = CGRect(x: 0, y: screenSize.height - screenSize.height / 1.05, width: screenSize.width, height: screenSize.height + self.view.safeAreaInsets.bottom)
        })
    }
    
    func scrollViewDidScroll(_ scrollView:UIScrollView) {
        let midX:CGFloat = scrollView.bounds.midX
        let midY:CGFloat = scrollView.bounds.midY
        let point:CGPoint = CGPoint(x:midX, y:midY)
        guard let indexPath = self.mainCollectionView.indexPathForItem(at: point) else { return  }
        let currentPage:Int = indexPath.item
        print("colletionView point\(point)")
        if self.homeData[currentPage].color == "red" {
            self.mainBackgroundImageView.image = UIImage(named: "imgBackgroundRed.png")
        } else if self.homeData[currentPage].color == "yellow" {
            self.mainBackgroundImageView.image = UIImage(named: "imgBackgroundYellow.png")
        } else if self.homeData[currentPage].color == "green" {
            self.mainBackgroundImageView.image = UIImage(named: "imgBackgroundGreen.png")
        } else if self.homeData[currentPage].color == "pink" {
            self.mainBackgroundImageView.image = UIImage(named: "imgBackgroundPink.png")
        } else if self.homeData[currentPage].color == "purple" {
            self.mainBackgroundImageView.image = UIImage(named: "imgBackgroundViolet.png")
        }
        
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
    }
}


class HomeBottomSheet: UIView {
    
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var questionConfirmButton: UIButton!
    @IBOutlet weak var questionDeleteButton: UIButton!
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
