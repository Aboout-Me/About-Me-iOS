//
//  MyProfileAnswerViewController.swift
//  About-Me-iOS
//
//  Created by Kim dohyun on 2021/06/03.
//

import UIKit


class MyProfileAnswerViewController: UIViewController {
    @IBOutlet weak var myProfileAnswerCollectionview: UICollectionView!
    public var myProfileColor = "red"
    public var myProfileData: MyProfilePage? = nil
    public var myProfileSubData = [MyProfilePageModel]()
    public var myProfileTagIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMyProfileList()
//        self.myProfileAnswerCollectionview.delegate = self
//        self.myProfileAnswerCollectionview.dataSource = self
    }
    
    private func getMyProfileList() {
        let Paramter = [
            "color": self.myProfileColor
        ]
        if self.myProfileTagIndex == 0 {
            ProfileServerApi.getMyProfilePage(userId: 1, colorParameter:nil ) { result in
                if case let .success(data) = result, let list = data {
                    DispatchQueue.main.async {
                        self.myProfileData = list
                        self.myProfileSubData = list.postList
                        self.myProfileAnswerCollectionview.reloadData()
                        print(self.myProfileData)
                    }
                }
            }
        } else {
            ProfileServerApi.getMyProfilePage(userId: 1, colorParameter:Paramter ) { result in
                if case let .success(data) = result, let list = data {
                    DispatchQueue.main.async {
                        self.myProfileData = list
                        self.myProfileSubData = list.postList
                        self.myProfileAnswerCollectionview.reloadData()
                        print(self.myProfileData)
                    }
                }
            }
        }
    }
    
}


//extension MyProfileAnswerViewController: UICollectionViewDelegate,UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
    
    
//}
