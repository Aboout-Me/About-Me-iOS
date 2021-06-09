//
//  SocialDetailViewController.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/31.
//

import UIKit

class SocialDetailViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var bottomRoundView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var scrapButton: UIButton!
    @IBOutlet weak var scrapLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    
    var answerId: Int?
    var authorId: Int?
    var comments: [SocialComment]?
    var post: SocialPost?
    private let tags = [("전체", "", UIColor.clear), ("열정충만", "red", UIColor.primaryRed), ("소소한일상", "yellow", UIColor.primaryYellow), ("기억상자", "green", UIColor.primaryGreen), ("관계의미학", "pink", UIColor.primaryPink), ("상상플러스", "purple", UIColor.primaryPurple)]

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureNavigation()
        self.getApi { detailResponse in
            self.comments = detailResponse.comments
            self.setPost(post: detailResponse.post)
        }
    }
    
    // MARK: - Selectors
    
    @objc
    private func backIconDidTap(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func bottomViewDidTap(_ sender: UITapGestureRecognizer) {
        let commentVC = SocialCommentViewController(nibName: "SocialCommentViewController", bundle: nil)
        commentVC.modalPresentationStyle = .overCurrentContext
        commentVC.answerId = self.answerId
        commentVC.authorId = self.authorId
        commentVC.comments = self.comments
        self.present(commentVC, animated: true, completion: nil)
    }
    
    @IBAction func likeButtonDidTap(_ sender: Any) {
        guard let post = post else { return }
        SocialApiService.postLikeButton(questId: post.answerId, authorId: post.userId) {
            self.viewWillAppear(false)
        }
    }
    
    @IBAction func bookmarkButtonDidTap(_ sender: Any) {
        guard let post = post else { return }
        SocialApiService.postScrapButton(questId: post.answerId, authorId: post.userId) {
            self.viewWillAppear(false)
        }
    }
    
    // MARK: - Helpers
    
    private func configureNavigation() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow-left.png"), style: .plain, target: self, action: #selector(backIconDidTap))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationController?.navigationBar.tintColor = .white
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 18)]
    }

    private func configure() {
        self.roundView.layer.cornerRadius = 10
        self.tagView.layer.cornerRadius = 3
        self.bottomRoundView.layer.cornerRadius = 10
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(bottomViewDidTap))
        self.bottomRoundView.addGestureRecognizer(gesture)
    }
    
    private func getApi(completion: @escaping (SocialDetailResponse) -> Void) {
        if let answerId = self.answerId, let authorId = self.authorId {
            SocialApiService.getSocialDetail(answerId: answerId, authorId: authorId) { detailResponse in
                if let detail = detailResponse {
                    completion(detail)
                }
            }
        }
    }
    
    private func setPost(post: SocialPost) {
        self.post = post
        print("post: \(post)")
        tags.forEach { tagText, tagColorText, tagColor in
            if post.color == tagColorText {
                backgroundImageView.image = UIImage(named: "img_background_\(post.color).png")
                tagView.backgroundColor = tagColor
                tagLabel.text = tagText
            }
            questionLabel.text = post.question
            answerTextView.text = post.answer
            likeButton.setImage(post.hasLiked ? UIImage(named: "like_on_dark.png") : UIImage(named: "like_off_dark.png"),
                                for: .normal)
            likeLabel.text = "\(post.likes)"
            scrapButton.setImage(post.hasScrapped ? UIImage(named: "bookmark_on_dark.png") : UIImage(named: "bookmark_off_dark.png"),
                                 for: .normal)
            scrapLabel.text = "\(post.scraps)"
            commentLabel.text = "\(post.comments)"
        }
    }
}
