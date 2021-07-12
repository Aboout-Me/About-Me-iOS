//
//  SocialMyMoreView.swift
//  오늘의 나
//
//  Created by Hyeyeon Lee on 2021/07/04.
//

import UIKit

class SocialMyMoreView: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var handle: UIView!
    var panGestureRecognizer: UIPanGestureRecognizer?
    var originalPosition: CGPoint?
    var currentPositionTouched: CGPoint?
    var commentId: Int?
    var closure: (() -> Void)?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    // MARK: - Selectors
    
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
    
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        guard let commentId = self.commentId else { return }
        SocialApiService.deleteComment(commentId: commentId) { response in
            if response.code == 200 {
                let alert = UIAlertController(title: "삭제가 완료되었습니다.", message: nil, preferredStyle: UIAlertController.Style.alert)
                
                let cancelAction = UIAlertAction(title: "닫기", style: .default) { _ in
                    self.closure?()
                }
                
                alert.addAction(cancelAction)
                self.present(alert, animated: false, completion: nil)
            }
        }
    }
    
    @IBAction func cancelButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    private func configure() {
        self.view.isOpaque = false
        self.roundView.layer.cornerRadius = 15
        self.handle.layer.cornerRadius = 2.5
        
        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        view.addGestureRecognizer(panGestureRecognizer!)
    }
}
