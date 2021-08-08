//
//  SocialMoreContentViewController.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/30.
//

import UIKit

class SocialMoreContentViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var headerCollectionView: UICollectionView!
    @IBOutlet weak var bodyCollectionView: UICollectionView!
    
    private let tags = [("전체", "", UIColor.clear), ("열정충만", "red", UIColor.primaryRed), ("소소한일상", "yellow", UIColor.primaryYellow), ("기억상자", "green", UIColor.primaryGreen), ("관계의미학", "pink", UIColor.primaryPink), ("상상플러스", "purple", UIColor.primaryPurple)]
    var state: Social = .none
    private var postList: [SocialPostList] = []
    private var feedList: [FeedPost] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configure()
        self.headerCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.state == .none {
            self.configureFeedNavigation()
            MyFeedApiService.getFeedList(color: nil) { feedList in
                print("feedList: \(feedList)")
                if let feedList = feedList {
                    self.feedList = feedList
                    self.bodyCollectionView.reloadData()
                }
            }
        } else {
            self.configureSocialNavigation()
            SocialApiService.getSocialList(state: self.state.rawValue, color: nil) { socialList in
                print("socialList: \(socialList)")
                if let socialList = socialList {
                    self.postList = socialList
                    self.bodyCollectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Selectors
    
    @objc
    private func backIconDidTap(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func searchIconDidTap(_ sender: UIBarButtonItem) {
        self.navigationController?.isNavigationBarHidden = true
        let searchVC = SocialSearchViewController(nibName: "SocialSearchViewController", bundle: nil)
        self.navigationController?.pushViewController(searchVC, animated: true)
    }

    // MARK: - Helpers
    
    private func configureSocialNavigation() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow-left.png"), style: .plain, target: self, action: #selector(backIconDidTap))
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchIconDidTap))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationController?.navigationBar.tintColor = .white
        
        let navigationApp = UINavigationBarAppearance()
        navigationApp.configureWithTransparentBackground()
        self.navigationController?.navigationBar.standardAppearance = navigationApp
        self.navigationController?.navigationBar.compactAppearance = navigationApp
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 18)]
        self.navigationController?.navigationBar.standardAppearance.shadowColor = nil
    }
    
    private func configureFeedNavigation() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow-left.png"), style: .plain, target: self, action: #selector(backIconDidTap))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationController?.navigationBar.tintColor = .white
        
        self.title = "내 피드"
        let navigationApp = UINavigationBarAppearance()
        navigationApp.configureWithTransparentBackground()
        self.navigationController?.navigationBar.standardAppearance = navigationApp
        self.navigationController?.navigationBar.compactAppearance = navigationApp
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 18)]
        self.navigationController?.navigationBar.standardAppearance.shadowColor = nil
    }
    
    private func configure() {
        self.headerCollectionView.dataSource = self
        self.headerCollectionView.delegate = self
        self.bodyCollectionView.dataSource = self
        self.bodyCollectionView.delegate = self
        
        self.headerCollectionView.register(SocialTagCell.self, forCellWithReuseIdentifier: "socialTagCell")
        let socialMoreNib = UINib(nibName: "SocialMoreContentCell", bundle: nil)
        self.bodyCollectionView.register(socialMoreNib, forCellWithReuseIdentifier: "socialMoreContentCell")
        let myFeedNib = UINib(nibName: "MyFeedCell", bundle: nil)
        self.bodyCollectionView.register(myFeedNib, forCellWithReuseIdentifier: "myFeedCell")
        
        let headerLayout = UICollectionViewFlowLayout()
        headerLayout.scrollDirection = .horizontal
        headerLayout.minimumLineSpacing = 10
        headerLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.headerCollectionView.collectionViewLayout = headerLayout
        
        let bodyLayout = UICollectionViewFlowLayout()
        bodyLayout.scrollDirection = .vertical
        bodyLayout.minimumLineSpacing = 15
        bodyLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.bodyCollectionView.collectionViewLayout = bodyLayout
    }
}

extension SocialMoreContentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == headerCollectionView {
            return tags.count
        } else {
            if self.state == .none {
                return self.feedList.count
            }
            else {
                return self.postList.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == headerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialTagCell", for: indexPath) as! SocialTagCell
            cell.titleLabel.text = tags[indexPath.row].0
            cell.tagNumber = indexPath.row
            return cell
        } else {
            if self.state == .none {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myFeedCell", for: indexPath) as! MyFeedCell
                let post = self.feedList[indexPath.row]
                tags.forEach { tagText, tagColorText, tagColor in
                    if post.color == tagColorText {
                        cell.tagView.backgroundColor = tagColor
                        cell.tagLabel.text = tagText
                    }
                }
                if post.level == 1 {
                    cell.levelView.isHidden = true
                } else {
                    cell.levelView.isHidden = false
                    cell.levelLabel.text = "Level \(post.level)"
                }
                cell.questionLabel.text = post.question
                cell.answerLabel.text = post.answer
                cell.closure = { [weak self] in
                    guard let self = self else { return }
                    let myMoreView = SocialMyMoreView(nibName: "SocialMyMoreView", bundle: nil)
                    myMoreView.deleteType = "board"
                    myMoreView.targetId = post.answerId
                    myMoreView.modalPresentationStyle = .overCurrentContext
                    myMoreView.closure = { [weak self] in
                        guard let self = self else { return }
                        self.dismiss(animated: false) {
                            self.feedList.remove(at: indexPath.row)
                            self.bodyCollectionView.reloadData()
                        }
                    }
                    self.present(myMoreView, animated: true, completion: nil)
                }
                return cell
            }
            else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialMoreContentCell", for: indexPath) as! SocialMoreContentCell
                let post = self.postList[indexPath.row]
                tags.forEach { tagText, tagColorText, tagColor in
                    if post.color == tagColorText {
                        cell.tagView.backgroundColor = tagColor
                        cell.tagLabel.text = tagText
                    }
                }
                cell.nicknameLabel.text = post.nickname
                cell.questionLabel.text = post.question
                cell.answerLabel.text = post.answer
                cell.likeLabel.text = "\(post.likes)"
                cell.commentLabel.text = "\(post.comments)"
                
                cell.likeButton.setImage(post.hasLiked ? UIImage(named: "like_on_dark.png") : UIImage(named: "like_off_dark.png"), for: .normal)
                cell.likeButtonTapClosure = {
                    SocialApiService.postLikeButton(questId: post.answerId, authorId: post.userId) {
                        self.viewWillAppear(false)
                    }
                }
                
                cell.bookmarkButton.setImage(post.hasScrapped ? UIImage(named: "bookmark_on_dark.png") : UIImage(named: "bookmark_off_dark.png"), for: .normal)
                cell.bookmarkButtonTapClosure = {
                    SocialApiService.postScrapButton(questId: post.answerId, authorId: post.userId) {
                        self.viewWillAppear(false)
                    }
                }
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == headerCollectionView {
            if indexPath.row == 0 {
                self.backgroundImageView.image = UIImage(named: "img_background_default.png")
            } else {
                self.backgroundImageView.image = UIImage(named: "img_background_\(tags[indexPath.row].1).png")
            }
            
            if self.state == .none {
                MyFeedApiService.getFeedList(color: tags[indexPath.row].1) { feedList in
                    print("feedPost: \(feedList)")
                    if let feedList = feedList {
                        self.feedList = feedList
                    } else {
                        self.feedList = []
                    }
                    self.bodyCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                    self.bodyCollectionView.reloadData()
                }
            }
            else {
                SocialApiService.getSocialList(state: self.state.rawValue, color: tags[indexPath.row].1) { socialList in
                    print("socialList: \(socialList)")
                    if let socialList = socialList {
                        self.postList = socialList
                    } else {
                        self.postList = []
                    }
                    self.bodyCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                    self.bodyCollectionView.reloadData()
                }
            }
        } else {
            let detailVC = SocialDetailViewController(nibName: "SocialDetailViewController", bundle: nil)
            if self.state == .none {
                let post = self.feedList[indexPath.row]
                detailVC.title = USER_NICKNAME
                detailVC.authorId = USER_ID
                detailVC.answerId = post.answerId
            }
            else {
                let post = self.postList[indexPath.row]
                detailVC.title = post.nickname
                detailVC.authorId = post.userId
                detailVC.answerId = post.answerId
            }
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension SocialMoreContentViewController: UICollectionViewDelegate {
    
}

extension SocialMoreContentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == headerCollectionView {
            let label = UILabel()
            label.text = tags[indexPath.row].0
            label.font = UIFont.systemFont(ofSize: 15)
            return CGSize(width: label.intrinsicContentSize.width + 40, height: 40)
        } else {
            if self.state == .none {
                return CGSize(width: collectionView.frame.width - 40, height: 176)
            }
            else {
                return CGSize(width: collectionView.frame.width - 40, height: 230)
            }
        }
    }
}
