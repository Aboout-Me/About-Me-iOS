//
//  HomeAfterViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/19.
//

import UIKit
import Floaty

class HomeAfterViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var homeAfterCollectionView: UICollectionView!
    @IBOutlet weak var homeAfterFloaingButton: Floaty!
    @IBOutlet weak var homeAfterBackgroundImageView: UIImageView!
    @IBOutlet var homeAfterAnswerEditBottomSheetView: AnswerEditBottomSheet!
    public var titleText: String = ""
    public var backgroundColor: String = ""
    public var answerLevel: String = ""
    public var screenSize = UIScreen.main.bounds.size
    
    lazy var editBottomContainerView: UIView = {
        let containerView = UIView(frame: self.view.frame)
        containerView.isOpaque = false
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        containerView.tag = 1
        return containerView
    }()
    
    lazy var editBottomView: EditBottomSheetView = {
        let editView = Bundle.main.loadNibNamed("EditBottomSheetView", owner: self, options: nil)?.first as? EditBottomSheetView
        editView?.frame = CGRect(x: 0, y: self.screenSize.height, width: self.screenSize.width, height: 224)
        return editView!
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayoutInit()
    }
    
    
    private func setLayoutInit() {
        let cellWidth = floor(view.frame.width * 0.85)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: cellWidth, height: 420)
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateString = dateFormatter.string(from: date)
        self.navigationItem.title = dateString
        self.homeAfterCollectionView.delegate = self
        self.homeAfterCollectionView.dataSource = self
        self.homeAfterCollectionView.backgroundColor = .clear
        self.homeAfterCollectionView.collectionViewLayout = layout
        let nib = UINib(nibName: "HomeAfterCollectionViewCell", bundle: nil)
        self.homeAfterCollectionView.register(nib, forCellWithReuseIdentifier: "HomeAfterCell")
        self.homeAfterFloaingButton.buttonColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.homeAfterFloaingButton.plusColor = UIColor.white
        self.homeAfterFloaingButton.addItem("오늘의 질문", icon: UIImage(named: "Write.png"))
        self.homeAfterFloaingButton.addItem("자문 자답", icon: UIImage(named: "SelfQuestion.png")) { item in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let advisoryAnswerView = storyboard.instantiateViewController(withIdentifier: "AdvisoryAnswerVC") as? AdvisoryAnswerViewController
            guard let advisoryAnswerVC = advisoryAnswerView else { return }
            self.navigationController?.pushViewController(advisoryAnswerVC, animated: true)
        }
        self.homeAfterFloaingButton.addItem("내 피드", icon: UIImage(named: "Feed.png"))
        if self.backgroundColor == "red" {
            self.homeAfterBackgroundImageView.image = UIImage(named: "imgBackgroundRed.png")
        } else if self.backgroundColor == "yellow" {
            self.homeAfterBackgroundImageView.image = UIImage(named: "imgBackgroundYellow.png")
        } else if self.backgroundColor == "green" {
            self.homeAfterBackgroundImageView.image = UIImage(named: "imgBackgroundGreen.png")
        } else if self.backgroundColor == "pink" {
            self.homeAfterBackgroundImageView.image = UIImage(named: "imgBackgroundPink.png")
        } else if self.backgroundColor == "purple" {
            self.homeAfterBackgroundImageView.image = UIImage(named: "imgBackgroundViolet.png")
        }
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
    
    
    private func answerEditBottomSheetLayoutInit() {
        let paragraphStyle = NSMutableParagraphStyle()
        let editToolbar = UIToolbar()
        let screenSize = UIScreen.main.bounds.size
        paragraphStyle.lineSpacing = 4
        let fiexedbarButtonItem = UIBarButtonItem(systemItem: .flexibleSpace)
        let donebarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.toolbarButtonDidTap))
        editToolbar.items = [fiexedbarButtonItem,donebarButtonItem]
        editToolbar.sizeToFit()
        self.homeAfterAnswerEditBottomSheetView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 2)
        self.homeAfterAnswerEditBottomSheetView.answerTitleQuestionLabel.text = "Q. "
        self.homeAfterAnswerEditBottomSheetView.answerTitleQuestionLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.homeAfterAnswerEditBottomSheetView.answerTitleQuestionLabel.font = UIFont(name: "GmarketSansMedium", size: 18)
        self.homeAfterAnswerEditBottomSheetView.answerTitleQuestionLabel.textAlignment = .left
        self.homeAfterAnswerEditBottomSheetView.answerTitleLabel.attributedText = NSAttributedString(string: "\(self.titleText)", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        self.homeAfterAnswerEditBottomSheetView.answerTitleLabel.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1.0)
        self.homeAfterAnswerEditBottomSheetView.answerTitleLabel.textAlignment = .left
        self.homeAfterAnswerEditBottomSheetView.answerTitleLabel.font = UIFont(name: "GmarketSansMedium", size: 20)
        self.homeAfterAnswerEditBottomSheetView.answerTitleLabel.numberOfLines = 0
        self.homeAfterAnswerEditBottomSheetView.answerTitleLabel.sizeToFit()
        self.homeAfterAnswerEditBottomSheetView.answerTextView.delegate = self
        self.homeAfterAnswerEditBottomSheetView.answerTextView.text = "당신의 생각을 말해주세요"
        self.homeAfterAnswerEditBottomSheetView.answerTextView.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        self.homeAfterAnswerEditBottomSheetView.answerTextView.inputAccessoryView = editToolbar
        self.homeAfterAnswerEditBottomSheetView.answerEditNavigationBar.shadowImage = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0).imageFormatting()
        self.homeAfterAnswerEditBottomSheetView.answerEditNavigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 18)!]
        self.homeAfterAnswerEditBottomSheetView.layer.cornerRadius = 20
        self.homeAfterAnswerEditBottomSheetView.layer.masksToBounds = true
        self.homeAfterAnswerEditBottomSheetView.backgroundColor = .white
        self.homeAfterAnswerEditBottomSheetView.answerConfirmButton.isEnabled = false
        self.homeAfterAnswerEditBottomSheetView.answerDeleteButton.addTarget(self, action: #selector(self.hideAnswerBottomSheetDidTap), for: .touchUpInside)
        self.homeAfterAnswerEditBottomSheetView.answerConfirmButton.addTarget(self, action: #selector(self.confirmEditBottomSheetDidTap), for: .touchUpInside)
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
    
    
    // TODO: - APIRequest
    
    private func editHomeCardList() {
        let parameter = HomeCardEditParamter(answer: self.homeAfterAnswerEditBottomSheetView.answerTextView.text ?? "", category_seq: UserDefaults.standard.integer(forKey: "homeBeforeSeq"), level: UserDefaults.standard.integer(forKey: "homeBeforeLevel"), share: "Y")
        HomeServerApi.putHomeCardList(parameter: parameter) { result in
            if case let .success(data) = result, let list = data {
                print(list)
                self.titleText = list.dailyLists[0].question
                UserDefaults.standard.set(list.dailyLists[0].answer, forKey: "myQuestionText")
                self.homeAfterCollectionView.reloadData()
            } else if case let .failure(error) = result {
                let alert = UIAlertController(title: "Put Error Message", message: error, preferredStyle: .alert)
                let alertButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(alertButton)
                self.present(alert, animated: true, completion: nil)
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
                self.homeAfterAnswerEditBottomSheetView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 1.2)
            })
        }
        alert.addAction(alertCancelButton)
        alert.addAction(alertConfirmButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc
    private func confirmEditBottomSheetDidTap() {
        let screenSize = UIScreen.main.bounds.size
        self.homeAfterAnswerEditBottomSheetView.answerTextView.resignFirstResponder()
        self.editHomeCardList()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.homeAfterAnswerEditBottomSheetView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height / 1.2)
        })
    }
    
    
    @objc
    private func showEditBottomSheetDidTap(_ sender: UIButton) {
        let window = UIApplication.shared.windows.first
        let screenSize = UIScreen.main.bounds.size
        window?.addSubview(self.editBottomContainerView)
        window?.addSubview(self.editBottomView)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.editBottomView.frame = CGRect(x: 0, y: screenSize.height - 224, width: screenSize.width, height: 224 + self.view.safeAreaInsets.bottom)
        })
    }
    
    
    @objc
    private func toolbarButtonDidTap() {
        self.homeAfterAnswerEditBottomSheetView.endEditing(true)
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
                let screenSize = UIScreen.main.bounds.size
                let window = UIApplication.shared.windows.first
                window?.addSubview(self.homeAfterAnswerEditBottomSheetView)
                self.answerEditBottomSheetLayoutInit()
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                    self.homeAfterAnswerEditBottomSheetView.frame = CGRect(x: 0, y: screenSize.height - screenSize.height / 1.05, width: screenSize.width, height: screenSize.height + self.view.safeAreaInsets.bottom)
                })
            }
        }

    }
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        
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
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.homeAfterAnswerEditBottomSheetView.answerConfirmButton.isEnabled = false
            textView.text = "당신의 생각을 말해주세요"
            textView.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        if textView.textColor == UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0) {
            self.homeAfterAnswerEditBottomSheetView.answerConfirmButton.isEnabled = true
            textView.text = nil
            textView.textAlignment = .left
            textView.typingAttributes = [NSAttributedString.Key.paragraphStyle:paragraphStyle,NSAttributedString.Key.font:UIFont(name: "AppleSDGothicNeo-Regular", size: 16),NSAttributedString.Key.foregroundColor:UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)]
        }
    }
    
}


extension HomeAfterViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let homeAfterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeAfterCell", for: indexPath) as? HomeAfterCollectionViewCell
        self.editBottomSheetLayoutInit()
        if self.backgroundColor == "red" {
            homeAfterCell?.homeAfterTagButton.backgroundColor = UIColor(red: 255/255, green: 98/255, blue: 98/255, alpha: 1.0)
            homeAfterCell?.homeAfterTagButton.setTitle("열정충만", for: .normal)
        } else if self.backgroundColor == "yellow" {
            homeAfterCell?.homeAfterTagButton.backgroundColor = UIColor(red: 242/255, green: 194/255, blue: 23/255, alpha: 1.0)
            homeAfterCell?.homeAfterTagButton.setTitle("소소한일상", for: .normal)
        } else if self.backgroundColor == "green" {
            homeAfterCell?.homeAfterTagButton.backgroundColor = UIColor(red: 31/255, green: 176/255, blue: 115/255, alpha: 1.0)
            homeAfterCell?.homeAfterTagButton.setTitle("기억상자", for: .normal)
        } else if self.backgroundColor == "pink" {
            homeAfterCell?.homeAfterTagButton.backgroundColor = UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0)
            homeAfterCell?.homeAfterTagButton.setTitle("관계의미학", for: .normal)
        } else {
            homeAfterCell?.homeAfterTagButton.backgroundColor = UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0)
            homeAfterCell?.homeAfterTagButton.setTitle("상상플러스", for: .normal)
        }
        homeAfterCell?.homeAfterTitleLabel.text = "\(self.titleText)"
        homeAfterCell?.homeAfterSubjectLabel.text = "\(UserDefaults.standard.string(forKey: "myQuestionText")!)"
        homeAfterCell?.homeAfterEditButton.addTarget(self, action: #selector(self.showEditBottomSheetDidTap(_:)), for: .touchUpInside)
        return homeAfterCell!
    }
    
}



class AnswerEditBottomSheet: UIView {
    
    @IBOutlet weak var answerEditNavigationBar: BottomNavigationBar!
    @IBOutlet weak var answerDeleteButton: UIButton!
    @IBOutlet weak var answerConfirmButton: UIButton!
    @IBOutlet weak var answerShareButton: UIButton!
    @IBOutlet weak var answerTitleQuestionLabel: UILabel!
    @IBOutlet weak var answerTitleLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

