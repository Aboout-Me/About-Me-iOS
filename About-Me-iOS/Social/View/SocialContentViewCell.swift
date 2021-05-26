//
//  SocialContentViewCell.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/24.
//

import UIKit

class SocialContentViewCell: UICollectionViewCell {
    
    enum Social: String {
        case latest = "latestList"
        case popular = "currentHotList"
        case category = "latestList/Category"
        case none = ""
    }

    // MARK: - Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    var state: Social = .none
    
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
    
    func getData(_ state: Social) {
        self.state = state
        print(self.state)
        SocialApiService.getSocialList(state: self.state.rawValue, color: nil) { socialList in
            print("socialList: \(socialList)")
        }
    }
}

extension SocialContentViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialContentCell", for: indexPath) as! SocialContentCell
        return cell
    }
}

extension SocialContentViewCell: UICollectionViewDelegate {
    
}

extension SocialContentViewCell: UICollectionViewDelegateFlowLayout {
    
}
