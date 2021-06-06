//
//  SocialContentViewCell.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/24.
//

import UIKit

class SocialContentViewCell: UICollectionViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    var socialList: [SocialPostList] = []
    var vcClosure: ((SocialDetailViewController) -> Void)?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configure()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: 240, height: 250)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 30, right: 20)
        self.collectionView.collectionViewLayout = layout
        
        let socialContentNib = UINib(nibName: "SocialContentCell", bundle: nil)
        self.collectionView.register(socialContentNib, forCellWithReuseIdentifier: "socialContentCell")
    }
    
    func setData(_ list: [SocialPostList]) {
        self.socialList = list
        self.collectionView.reloadData()
    }
}

extension SocialContentViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.socialList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialContentCell", for: indexPath) as! SocialContentCell
        let social = self.socialList[indexPath.row]
        cell.backgroundImageView.image = UIImage(named: "s_card_\(social.color)")
        cell.nicknameLabel.text = social.nickname
        cell.questionLabel.text = social.question
        cell.answerLabel.text = social.answer
        cell.likeLabel.text = "\(social.likes)"
        cell.commentLabel.text = "\(social.comments)"
        return cell
    }
}

extension SocialContentViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = SocialDetailViewController(nibName: "SocialDetailViewController", bundle: nil)
        let socialList = self.socialList[indexPath.row]
        detailVC.title = socialList.nickname
        detailVC.authorId = socialList.userId
        detailVC.answerId = socialList.answerId
//        self.navigationController?.pushViewController(detailVC, animated: true)
        vcClosure!(detailVC)
    }
}

extension SocialContentViewCell: UICollectionViewDelegateFlowLayout {
    
}
