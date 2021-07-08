//
//  SocialViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/04/01.
//

import UIKit
import SideMenu

enum Social: String {
    case latest = "latestList"
    case popular = "currentHotList"
    case category = "latestList/Category"
    case none = ""
}

class SocialViewController: UIViewController {
    
    // MARK: - Properties
    
    public var sideMenu: SideMenuNavigationController?
    @IBOutlet weak var collectionView: UICollectionView!
    private var latestList: [SocialPostList] = []
    private var popularList: [SocialPostList] = []
    private var categoryList: [SocialPostList] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
        self.setSideMenuLayoutInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureNavigation()
        self.getApis()
    }
    
    // MARK: - Selectors
    
    @objc
    public func menuIconDidTap() {
        self.present(sideMenu!, animated: true, completion: nil)
    }
    
    @objc
    private func searchIconDidTap(_ sender: UIBarButtonItem) {
        self.navigationController?.isNavigationBarHidden = true
        let searchVC = SocialSearchViewController(nibName: "SocialSearchViewController", bundle: nil)
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    // MARK: - Helpers
    
    private func configureNavigation() {
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu_white.png"), style: .plain, target: self, action: #selector(menuIconDidTap))
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchIconDidTap))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationController?.navigationBar.tintColor = .black
        
        self.title = "공감하는 이야기"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 18)]
    }
    
    private func configure() {
        view.backgroundColor = .whiteTwo
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let socialHeaderNib = UINib(nibName: "SocialHeaderCell", bundle: nil)
        self.collectionView.register(socialHeaderNib, forCellWithReuseIdentifier: "socialHeaderCell")
        
        let socialContentViewNib = UINib(nibName: "SocialContentViewCell", bundle: nil)
        self.collectionView.register(socialContentViewNib, forCellWithReuseIdentifier: "socialContentViewCell")
        
        let socialNoContentViewNib = UINib(nibName: "SocialNoContentCell", bundle: nil)
        self.collectionView.register(socialNoContentViewNib, forCellWithReuseIdentifier: "socialNoContentCell")
    }
    
    private func setSideMenuLayoutInit() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sideOnlyViewController: SideOnlyViewController = storyboard.instantiateViewController(withIdentifier: "SideOnlyViewController") as! SideOnlyViewController
        self.sideMenu = SideMenuNavigationController(rootViewController: sideOnlyViewController)
        self.sideMenu?.leftSide = true
    }
    
    private func getApis() {
        let concurrentQueue = DispatchQueue.init(label: "concurrent", attributes: .concurrent)
        concurrentQueue.async {
            SocialApiService.getSocialList(state: Social.latest.rawValue, color: nil) { socialList in
                print("socialList: \(socialList)")
                if let socialList = socialList {
                    self.latestList = socialList
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
        concurrentQueue.async {
            SocialApiService.getSocialList(state: Social.popular.rawValue, color: nil) { socialList in
                print("socialList: \(socialList)")
                if let socialList = socialList {
                    self.popularList = socialList
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
        concurrentQueue.async {
            SocialApiService.getSocialList(state: Social.category.rawValue, color: nil) { socialList in
                print("socialList: \(socialList)")
                if let socialList = socialList {
                    self.categoryList = socialList
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
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
            if latestList.count > 0 {
                cell.arrowImageView.tintColor = .black
            } else {
                cell.arrowImageView.tintColor = .gray777
            }
            return cell
        }
        else if indexPath.row == 1 {
            if latestList.count > 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialContentViewCell", for: indexPath) as! SocialContentViewCell
                cell.setData(latestList)
                cell.vcClosure = { [weak self] vc in
                    self?.navigationController?.pushViewController(vc, animated: false)
                }
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialNoContentCell", for: indexPath) as! SocialNoContentCell
                return cell
            }
        }
        else if indexPath.row == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialHeaderCell", for: indexPath) as! SocialHeaderCell
            cell.titleLabel.text = "인기순"
            if popularList.count > 0 {
                cell.arrowImageView.tintColor = .black
            } else {
                cell.arrowImageView.tintColor = .gray777
            }
            return cell
        }
        else if indexPath.row == 3 {
            if popularList.count > 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialContentViewCell", for: indexPath) as! SocialContentViewCell
                cell.setData(popularList)
                cell.vcClosure = { [weak self] vc in
                    self?.navigationController?.pushViewController(vc, animated: false)
                }
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialNoContentCell", for: indexPath) as! SocialNoContentCell
                return cell
            }
        }
        else if indexPath.row == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialHeaderCell", for: indexPath) as! SocialHeaderCell
            cell.titleLabel.text = "취향순"
            if categoryList.count > 0 {
                cell.arrowImageView.tintColor = .black
            } else {
                cell.arrowImageView.tintColor = .gray777
            }
            return cell
        }
        else {
            if categoryList.count > 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialContentViewCell", for: indexPath) as! SocialContentViewCell
                cell.setData(categoryList)
                cell.vcClosure = { [weak self] vc in
                    self?.navigationController?.pushViewController(vc, animated: false)
                }
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "socialNoContentCell", for: indexPath) as! SocialNoContentCell
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("ind: \(indexPath.row)")
        if indexPath.row == 0 {
            let moreVC = SocialMoreContentViewController(nibName: "SocialMoreContentViewController", bundle: nil)
            moreVC.title = "최신순"
            moreVC.state = .latest
            self.navigationController?.pushViewController(moreVC, animated: true)
        }
        if indexPath.row == 2, popularList.count > 0 {
            let moreVC = SocialMoreContentViewController(nibName: "SocialMoreContentViewController", bundle: nil)
            moreVC.title = "인기순"
            moreVC.state = .popular
            self.navigationController?.pushViewController(moreVC, animated: true)
        }
        if indexPath.row == 4, categoryList.count > 0 {
            let moreVC = SocialMoreContentViewController(nibName: "SocialMoreContentViewController", bundle: nil)
            moreVC.title = "취향순"
            moreVC.state = .category
            self.navigationController?.pushViewController(moreVC, animated: true)
        }
    }
}

extension SocialViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row % 2 == 0 {
            return CGSize(width: collectionView.frame.width, height: 40)
        } else {
            if indexPath.row == 1, latestList.count == 0 {
                return CGSize(width: collectionView.frame.width, height: 44)
            }
            if indexPath.row == 3, popularList.count == 0 {
                return CGSize(width: collectionView.frame.width, height: 44)
            }
            if indexPath.row == 5, categoryList.count == 0 {
                return CGSize(width: collectionView.frame.width, height: 44)
            }
            return CGSize(width: collectionView.frame.width, height: 300)
        }
    }
}
