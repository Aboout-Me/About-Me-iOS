//
//  SocialViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/01.
//

import UIKit
import SideMenu

class SocialViewController: UIViewController {
    
    // MARK: - Properties
    
    public var sideMenu: SideMenuNavigationController?
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
        self.setSideMenuLayoutInit()
    }
    
    // MARK: - Selectors
    
    @objc
    public func menuIconDidTap() {
        self.present(sideMenu!, animated: true, completion: nil)
    }
    
    @objc
    private func searchIconDidTap(_ sender: UIBarButtonItem) {
        print("@@@@")
    }
    
    // MARK: - Helpers
    
    private func configure() {
        view.backgroundColor = .whiteTwo
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu.png"), style: .plain, target: self, action: #selector(menuIconDidTap))
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchIconDidTap))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationController?.navigationBar.tintColor = .black
        
        self.title = "공감하는 이야기"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 18)]
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let socialHeaderNib = UINib(nibName: "SocialHeaderCell", bundle: nil)
        self.collectionView.register(socialHeaderNib, forCellWithReuseIdentifier: "socialHeaderCell")
        
        let socialContentViewNib = UINib(nibName: "SocialContentViewCell", bundle: nil)
        self.collectionView.register(socialContentViewNib, forCellWithReuseIdentifier: "socialContentViewCell")
    }
    
    private func setSideMenuLayoutInit() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sideOnlyViewController: SideOnlyViewController = storyboard.instantiateViewController(withIdentifier: "SideOnlyViewController") as! SideOnlyViewController
        self.sideMenu = SideMenuNavigationController(rootViewController: sideOnlyViewController)
        self.sideMenu?.leftSide = true
    }
}

extension SocialViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialHeaderCell", for: indexPath) as! SocialHeaderCell
            cell.titleLabel.text = "최신순"
            return cell
        } else if indexPath.row == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialHeaderCell", for: indexPath) as! SocialHeaderCell
            cell.titleLabel.text = "인기순"
            return cell
        } else if indexPath.row == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialHeaderCell", for: indexPath) as! SocialHeaderCell
            cell.titleLabel.text = "취향순"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialContentViewCell", for: indexPath)
            return cell
        }
    }
}

extension SocialViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
}
