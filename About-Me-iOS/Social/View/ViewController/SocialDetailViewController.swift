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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureNavigation()
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
        self.present(commentVC, animated: true, completion: nil)
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
}
