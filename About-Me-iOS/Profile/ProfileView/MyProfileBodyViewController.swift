//
//  MyProfileBodyViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/06/02.
//

import UIKit

class MyProfileBodyViewController: UIViewController {
    @IBOutlet weak var myProfileCollectionview: UICollectionView!
    public var myProfileLikeScrapData: MyProfileLikeScrapList? = nil
    public var myProfileLikeScrapSubData = [MyProfileLikeScrapModelBody]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMyLikeScrapList()
        let nib = UINib(nibName: "MyProfileCollectionViewCell", bundle: nil)
        self.myProfileCollectionview.register(nib, forCellWithReuseIdentifier: "MyProfileCell")
        self.myProfileCollectionview.delegate = self
        self.myProfileCollectionview.dataSource = self
    }
    
    
    private func getMyLikeScrapList() {
        let likeParamter = [
            "color" : "red"
        ]
        ProfileServerApi.getMyProfileLikeList(userId: 1, crush: "likes", crushParameter: likeParamter) { result in
            if case let .success(data) = result, let list = data {
                DispatchQueue.main.async {
                    self.myProfileLikeScrapData = list
                    self.myProfileLikeScrapSubData = list.postList[0].body
                    self.myProfileCollectionview.reloadData()
                    print(self.myProfileLikeScrapData)
                }
            }
        }
    }
}


extension MyProfileBodyViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myProfileLikeScrapSubData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let myProfileCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileCell", for: indexPath) as? MyProfileCollectionViewCell
            if self.myProfileLikeScrapSubData[indexPath.item].color == "red" {
                myProfileCell?.myProfileContentTitleLabel.text = "# 열정충만"
                myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 244/255, green: 82/255, blue: 82/255, alpha: 1.0)
            } else if self.myProfileLikeScrapSubData[indexPath.item].color == "yellow" {
                myProfileCell?.myProfileContentTitleLabel.text = "# 소소한 일상"
                myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 220/255, green: 174/255, blue: 9/255, alpha: 1.0)
            } else if self.myProfileLikeScrapSubData[indexPath.item].color == "pink" {
                myProfileCell?.myProfileContentTitleLabel.text = "# 관계의 미학"
                myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 231/255, green: 79/255, blue: 152/255, alpha: 1.0)
            } else if self.myProfileLikeScrapSubData[indexPath.item].color == "green" {
                myProfileCell?.myProfileContentTitleLabel.text = "# 기억상자"
                myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 42/255, green: 212/255, blue: 141/255, alpha: 1.0)
            } else {
                myProfileCell?.myProfileContentTitleLabel.text = "# 상상플러스"
                myProfileCell?.myProfileContentTitleLabel.textColor =  UIColor(red: 159/255, green: 88/255, blue: 251/255, alpha: 1.0)
            }
            if self.myProfileLikeScrapSubData[indexPath.item].likes == 1 {
                myProfileCell?.myProfileContentImageView.image = UIImage(named: "LikeOn.png")
            }
            myProfileCell?.myProfileQuestionTitleLabel.text = "\(self.myProfileLikeScrapSubData[indexPath.item].question)"
            myProfileCell?.myProfileContentDateLabel.text = self.myProfileLikeScrapSubData[indexPath.item].updateDate
            myProfileCell?.myProfileAnswerTitleLabel.text = self.myProfileLikeScrapSubData[indexPath.item].answer
        return myProfileCell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 335, height: 100)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

