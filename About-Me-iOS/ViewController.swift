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
    public var sideMenu: SideMenuNavigationController?
    public var questionTitleText: String = ""
    public var screenSize = UIScreen.main.bounds.size
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayoutInit()
        self.setSideMenuLayoutInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hero.isEnabled = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.hero.isEnabled = false
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
        self.mainCollectionView.delegate = self
        self.mainCollectionView.backgroundColor = UIColor.clear
        self.mainCollectionView.dataSource = self
        self.mainCollectionView.register(mainNib, forCellWithReuseIdentifier: "mainCell")
        self.mainCollectionView.showsHorizontalScrollIndicator = false
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
    
    @objc func showLastAnswerButtonDidTap() {
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

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! MainCollectionViewCell
        cell.mainTitleLabel.text = "인생의 가장 큰 목표는 무엇인가요?"
        cell.mainCharacterLabel.text = "프로 열정러"
        cell.mainCharacterTagFirstButton.setTitle("#열정", for: .normal)
        cell.mainCharacterTagSecondButton.setTitle("#진로", for: .normal)
        cell.mainCharacterTagThirdButton.setTitle("#미래", for: .normal)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 315, height: 420)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
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
