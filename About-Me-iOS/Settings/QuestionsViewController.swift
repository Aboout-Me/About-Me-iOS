//
//  QuestionsViewController.swift
//  About-Me-iOS
//
//  Created by Apple on 2021/05/27.
//

import UIKit

class QuestionsViewController: UIViewController {

    @IBOutlet weak var chooseQuestionsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .black
        self.title = "문의하기"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        chooseQuestionsButton.layer.borderWidth = 0.25
        chooseQuestionsButton.layer.borderColor = UIColor.lightGray.cgColor
        chooseQuestionsButton.layer.cornerRadius = 5.0;
        chooseQuestionsButton.backgroundColor = UIColor.white
        chooseQuestionsButton.setTitleColor(UIColor.lightGray, for: .normal)
        
//        let bottomSheet = BottomSheetView(nibName: "BottomSheetView", bundle: nil)
//        bottomSheet.modalPresentationStyle = .overCurrentContext
//        self.present(bottomSheet, animated: true, completion: nil)
    }
    

}
