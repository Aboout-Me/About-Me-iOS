//
//  QuestionsListViewController.swift
//  오늘의 나
//
//  Created by Apple on 2021/07/18.
//

import UIKit

class QuestionsListViewController: UIViewController {

    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var fourthImageView: UIImageView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var centerAnchor: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topHandlerView: UIView!
    
    var flag: Int = -1
    var isCenterAnchor: Bool = true
    
    var closeClosure: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.layer.cornerRadius = 10
        topHandlerView.layer.cornerRadius = 2
        
        firstImageView.isHidden = true
        secondImageView.isHidden = true
        thirdImageView.isHidden = true
        fourthImageView.isHidden = true
        
        if flag == 0{
            firstImageView.isHidden = false
        }
        else if flag == 1{
            secondImageView.isHidden = false
        }
        else if flag == 2{
            thirdImageView.isHidden = false
        }
        else if flag == 3{
            fourthImageView.isHidden = false
        }
        else{
            
        }
        
    }
    @IBAction func firstButtonDidTapped(_ sender: Any) {
        closeClosure?(0)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func secondButtonDidTapped(_ sender: Any) {
        closeClosure?(1)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func thirdButtonDidTapped(_ sender: Any) {
        closeClosure?(2)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func fourthButtonDidTapped(_ sender: Any) {
        closeClosure?(3)
        self.dismiss(animated: true, completion: nil)
    }
}
