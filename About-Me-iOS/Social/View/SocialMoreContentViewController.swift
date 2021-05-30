//
//  SocialMoreContentViewController.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/30.
//

import UIKit

class SocialMoreContentViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var headerCollectionView: UICollectionView!
    @IBOutlet weak var bodyCollectionView: UICollectionView!
    
    let tags = ["전체", "열정충만", "소소한일상", "기억상자", "관계의미학", "상상플러스"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configure()
        self.headerCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configureNavigation()
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
    
    private func configureNavigation() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow-left.png"), style: .plain, target: self, action: #selector(backIconDidTap))
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchIconDidTap))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationController?.navigationBar.tintColor = .white
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 18)]
    }
    
    private func configure() {
        self.headerCollectionView.dataSource = self
        self.headerCollectionView.delegate = self
        self.bodyCollectionView.dataSource = self
        self.bodyCollectionView.delegate = self
        
        self.headerCollectionView.register(SocialTagCell.self, forCellWithReuseIdentifier: "socialTagCell")
        let socialMoreNib = UINib(nibName: "SocialMoreContentCell", bundle: nil)
        self.bodyCollectionView.register(socialMoreNib, forCellWithReuseIdentifier: "socialMoreContentCell")
        
        let headerLayout = UICollectionViewFlowLayout()
        headerLayout.scrollDirection = .horizontal
        headerLayout.minimumLineSpacing = 10
        headerLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.headerCollectionView.collectionViewLayout = headerLayout
        
        let bodyLayout = UICollectionViewFlowLayout()
        bodyLayout.scrollDirection = .vertical
        bodyLayout.minimumLineSpacing = 10
        bodyLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        self.bodyCollectionView.collectionViewLayout = bodyLayout
    }
}

extension SocialMoreContentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == headerCollectionView {
            return tags.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == headerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialTagCell", for: indexPath) as! SocialTagCell
            cell.titleLabel.text = tags[indexPath.row]
            cell.tagNumber = indexPath.row
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialMoreContentCell", for: indexPath) as! SocialMoreContentCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == headerCollectionView {
            print("indexpath: \(indexPath.section) \(indexPath.row)")
        }
    }
}

extension SocialMoreContentViewController: UICollectionViewDelegate {
    
}

extension SocialMoreContentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == headerCollectionView {
            let label = UILabel()
            label.text = tags[indexPath.row]
            label.font = UIFont.systemFont(ofSize: 15)
            return CGSize(width: label.intrinsicContentSize.width + 40, height: 40)
        } else {
            return CGSize(width: collectionView.frame.width - 40, height: 230)
        }
    }
}
