//
//  SocialCommentViewController.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/31.
//

import UIKit

class SocialCommentViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var panGestureRecognizer: UIPanGestureRecognizer?
    var originalPosition: CGPoint?
    var currentPositionTouched: CGPoint?
    private var pullControl = UIRefreshControl()
    
    var answerId: Int?
    var authorId: Int?
    var comments: [SocialComment]?
    var profileClosure: (() -> Void)?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
    }
    
    // MARK: - Selectors
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc private func refreshListData(_ sender: Any) {
        // api
        self.commentTableView.reloadData()
        self.pullControl.endRefreshing()
    }
    
    @objc
    func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: view)
        
        if panGesture.state == .began {
            originalPosition = view.center
            currentPositionTouched = panGesture.location(in: view)
        } else if panGesture.state == .changed {
            view.frame.origin = CGPoint(
                x: view.frame.origin.x,
                y: view.frame.origin.y > translation.y ? view.frame.origin.y : translation.y
            )
        } else if panGesture.state == .ended {
            let velocity = panGesture.velocity(in: view)
            
            if velocity.y >= 1500 {
                UIView.animate(withDuration: 0.2
                               , animations: {
                                self.view.frame.origin = CGPoint(
                                    x: self.view.frame.origin.x,
                                    y: self.view.frame.size.height
                                )
                               }, completion: { (isCompleted) in
                                if isCompleted {
                                    self.dismiss(animated: false, completion: nil)
                                }
                               })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.center = self.originalPosition!
                })
            }
        }
    }
    
    @IBAction func commentButtonDidTap(_ sender: Any) {
        if let comment = commentTextField.text, comment != "",
           let answerId = self.answerId, let authorId = self.authorId {
            commentTextField.text = ""
            commentTextField.resignFirstResponder()
            SocialApiService.saveSocialComment(answerId: answerId, comment: comment) {
                //
                SocialApiService.getSocialDetail(answerId: answerId, authorId: authorId) { detailResponse in
                    if let detail = detailResponse {
                        self.comments = detail.comments
                        self.commentTableView.reloadData()
                    }
                }
            }
        }
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            
            self.bottomConstraint.constant = keyboardHeight
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        self.bottomConstraint.constant = 0
        self.view.layoutIfNeeded()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        if let comments = self.comments {
            self.headerLabel.text = "댓글 \(String(describing: comments.count))"
        }
        self.roundView.layer.cornerRadius = 10
        
        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        self.commentTableView.addGestureRecognizer(panGestureRecognizer!)
        self.commentTableView.dataSource = self
        self.commentTableView.delegate = self
        self.pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        //        self.commentTableView.refreshControl = pullControl
        
        self.bottomView.layer.borderWidth = 1
        self.bottomView.layer.borderColor = UIColor.whiteTwo.cgColor
        
        self.commentButton.layer.borderWidth = 1
        self.commentButton.layer.borderColor = UIColor.gray333.cgColor
        self.commentButton.layer.cornerRadius = 15
        
        let socialCommentNib = UINib(nibName: "SocialCommentCell", bundle: nil)
        self.commentTableView.register(socialCommentNib, forCellReuseIdentifier: "socialCommentCell")
        let noNib = UINib(nibName: "SocialNoContentTableViewCell", bundle: nil)
        self.commentTableView.register(noNib, forCellReuseIdentifier: "noNibCell")
        
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension SocialCommentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let comments = self.comments else { return 1 }
        return comments.count == 0 ? 1 : comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let comments = self.comments else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noNibCell", for: indexPath) as! SocialNoContentTableViewCell
            return cell
        }
        
        if comments.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noNibCell", for: indexPath) as! SocialNoContentTableViewCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "socialCommentCell", for: indexPath) as! SocialCommentCell
        cell.nicknameLabel.text = comments[indexPath.row].nickname
        cell.commentLabel.text =  comments[indexPath.row].comment
        cell.timeLabel.text = comments[indexPath.row].writtenDate
        cell.color = comments[indexPath.row].color
        cell.buttonClosure = { [weak self] in
            guard let self = self else { return }
            if comments[indexPath.row].authorId == USER_ID {
                let myMoreView = SocialMyMoreView(nibName: "SocialMyMoreView", bundle: nil)
                myMoreView.modalPresentationStyle = .overCurrentContext
                myMoreView.deleteType = "comment"
                myMoreView.targetId = comments[indexPath.row].commentId
                myMoreView.closure = { [weak self] in
                    guard let self = self else { return }
                    self.dismiss(animated: false) {
                        self.comments?.remove(at: indexPath.row)
                        self.commentTableView.reloadData()
                    }
                }
                self.present(myMoreView, animated: true, completion: nil)
            } else {
                let moreView = SocialMoreView(nibName: "SocialMoreView", bundle: nil)
                moreView.modalPresentationStyle = .overCurrentContext
                moreView.suedUserId = comments[indexPath.row].authorId
                moreView.targetQuestionId = comments[indexPath.row].commentId
                if self.authorId == USER_ID {
                    moreView.sueType = "comment"
                }
                moreView.closure = {
                    self.dismiss(animated: false, completion: nil)
                }
                moreView.profileClosure = {
                    self.dismiss(animated: true) {
                        self.profileClosure?()
                    }
                }
                self.present(moreView, animated: true, completion: nil)
            }
        }
        return cell
    }
}

extension SocialCommentViewController: UITableViewDelegate {
    
}
