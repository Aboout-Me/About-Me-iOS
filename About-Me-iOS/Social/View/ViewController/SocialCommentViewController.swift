//
//  SocialCommentViewController.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/31.
//

import UIKit

class SocialCommentViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentButton: UIButton!
    
    var panGestureRecognizer: UIPanGestureRecognizer?
    var originalPosition: CGPoint?
    var currentPositionTouched: CGPoint?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
    }
    
    // MARK: - Selectors
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc
    func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: view)
        
        if panGesture.state == .began {
            originalPosition = view.center
            currentPositionTouched = panGesture.location(in: view)
        } else if panGesture.state == .changed {
            view.frame.origin = CGPoint(
                x: view.frame.origin.x,
                y: view.frame.origin.y > translation.y ? view.frame.origin.y : translation.y
            )
        } else if panGesture.state == .ended {
            let velocity = panGesture.velocity(in: view)
            
            if velocity.y >= 1500 {
                UIView.animate(withDuration: 0.2
                               , animations: {
                                self.view.frame.origin = CGPoint(
                                    x: self.view.frame.origin.x,
                                    y: self.view.frame.size.height
                                )
                               }, completion: { (isCompleted) in
                                if isCompleted {
                                    self.dismiss(animated: false, completion: nil)
                                }
                               })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.center = self.originalPosition!
                })
            }
        }
    }
    
    // MARK: - Helpers
    
    private func configure() {
        self.roundView.layer.cornerRadius = 10
        
        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        self.commentTableView.addGestureRecognizer(panGestureRecognizer!)
        
        self.bottomView.layer.borderWidth = 1
        self.bottomView.layer.borderColor = UIColor.whiteTwo.cgColor
        
        self.commentButton.layer.borderWidth = 1
        self.commentButton.layer.borderColor = UIColor.gray333.cgColor
        self.commentButton.layer.cornerRadius = 15
    }
    
}
