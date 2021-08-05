//
//  SocialSearchViewController.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/27.
//

import UIKit

class SocialSearchViewController: UIViewController {

    enum Status {
        case before
        case after
    }

    // MARK: - Properties
    
    @IBOutlet weak var searchInputView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var beforeView: UIView!
    @IBOutlet weak var afterView: UIView!
    @IBOutlet weak var searchResultLabel: UILabel!
    var searchArray: [String] = []
    var searchResult: [SocialPost] = []
    var status: Status = .before
    private let tags = [("전체", "", UIColor.clear), ("열정충만", "red", UIColor.primaryRed), ("소소한일상", "yellow", UIColor.primaryYellow), ("기억상자", "green", UIColor.primaryGreen), ("관계의미학", "pink", UIColor.primaryPink), ("상상플러스", "purple", UIColor.primaryPurple)]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Selectors
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    private func configure() {
        self.searchTextField.clearButtonMode = .whileEditing
        self.searchTextField.delegate = self
        self.searchTableView.dataSource = self
        self.searchTableView.delegate = self
        
        self.searchInputView.layer.cornerRadius = 20
        self.searchInputView.layer.borderWidth = 1
        self.searchInputView.layer.borderColor = UIColor.lineDdd.cgColor
        
        let socialSearchNib = UINib(nibName: "SocialSearchCell", bundle: nil)
        self.searchTableView.register(socialSearchNib, forCellReuseIdentifier: "socialSearchCell")
        let socialSearchAfterNib = UINib(nibName: "SocialSearchResponseCell", bundle: nil)
        self.searchTableView.register(socialSearchAfterNib, forCellReuseIdentifier: "socialSearchAfterCell")
        
        self.afterView.isHidden = true
        self.afterView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        self.searchArray = UserDefaults.standard.array(forKey: "SearchArray") as? [String] ?? []
    }
}

extension SocialSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTextField.resignFirstResponder()
        if let text = textField.text, text != "" {
            self.searchArray.insert(text, at: 0)
            UserDefaults.standard.setValue(self.searchArray, forKey: "SearchArray")
            SocialApiService.getSocialSearch(keyword: text) { response in
                self.status = .after
                if let postList = response.postList {
                    self.searchResult = postList
                }
                self.searchTableView.reloadData()
            }
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.searchResult = []
        self.status = .before
        self.searchTableView.reloadData()
        return true
    }
}

extension SocialSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.status == .before {
            return searchArray.count > 10 ? 10 : searchArray.count
        } else {
            return searchResult.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.status == .before {
            let cell = tableView.dequeueReusableCell(withIdentifier: "socialSearchCell", for: indexPath) as! SocialSearchCell
            cell.searchTextLabel.text = searchArray[indexPath.row]
            cell.buttonClosure = { [weak self] in
                self?.searchArray.remove(at: indexPath.row)
                UserDefaults.standard.setValue(self?.searchArray, forKey: "SearchArray")
                tableView.reloadData()
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "socialSearchAfterCell", for: indexPath) as! SocialSearchResponseCell
            let post = searchResult[indexPath.row]
            tags.forEach { tagText, tagColorText, tagColor in
                if post.color == tagColorText {
                    cell.tagView.backgroundColor = tagColor
                    cell.tagLabel.text = tagText
                }
            }
            cell.questionLabel.text = post.question
            cell.answerLabel.text = post.answer
            cell.nicknameLabel.text = "by \(post.nickname)"
            cell.likeLabel.text = "\(post.likes)"
            cell.commentLabel.text = "\(post.comments)"
            cell.likeButton.setImage(post.hasLiked ? UIImage(named: "like_on_dark.png") : UIImage(named: "like_off_dark.png"), for: .normal)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.status == .before ? 50 : 163
    }
}

extension SocialSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if self.status == .before {
            searchTextField.text = searchArray[indexPath.row]
            self.searchArray.insert(searchTextField.text!, at: 0)
            UserDefaults.standard.setValue(self.searchArray, forKey: "SearchArray")
            SocialApiService.getSocialSearch(keyword: searchTextField.text!) { response in
                self.status = .after
                if let postList = response.postList {
                    self.searchResult = postList
                }
                self.searchTableView.reloadData()
            }
        } else {
            let detailVC = SocialDetailViewController(nibName: "SocialDetailViewController", bundle: nil)
            let socialList = searchResult[indexPath.row]
            detailVC.title = socialList.nickname
            detailVC.authorId = socialList.userId
            detailVC.answerId = socialList.answerId
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
