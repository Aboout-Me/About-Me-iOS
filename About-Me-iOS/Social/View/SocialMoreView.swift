//
//  SocialMoreView.swift
//  오늘의 나
//
//  Created by Hyeyeon Lee on 2021/07/04.
//

import UIKit

class SocialMoreView: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var handle: UIView!
    @IBOutlet weak var roundView: UIView!
    var panGestureRecognizer: UIPanGestureRecognizer?
    var originalPosition: CGPoint?
    var currentPositionTouched: CGPoint?
    var suedUserId: Int?
    var targetQuestionId: Int?
    
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
    
    @IBAction func profileButtonDidTap(_ sender: Any) {
    }
    
    @IBAction func reportButtonDidTap(_ sender: Any) {
        let alert = UIAlertController(title: "신고사유", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "욕설, 혐오, 타인비방", style: .default , handler:{ action in
            self.reportPost(reason: action.title ?? "")
        }))
        
        alert.addAction(UIAlertAction(title: "홍보, 영리목적", style: .default , handler:{ action in
            self.reportPost(reason: action.title ?? "")
        }))
        
        alert.addAction(UIAlertAction(title: "음란, 청소년 유해", style: .default , handler:{ action in
            self.reportPost(reason: action.title ?? "")
        }))
        
        alert.addAction(UIAlertAction(title: "도배, 스팸", style: .default , handler:{ action in
            self.reportPost(reason: action.title ?? "")
        }))
        
        alert.addAction(UIAlertAction(title: "기타", style: .default , handler:{ action in
            self.reportPost(reason: action.title ?? "")
        }))
        
        alert.addAction(UIAlertAction(title: "취소하기", style: .cancel, handler:{ action in
        }))
        
        self.present(alert, animated: true, completion: nil)
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
    
    private func reportPost(reason: String) {
        if let suedUserId = self.suedUserId, let targetQuestionId = self.targetQuestionId {
            SocialApiService.postReport(suedUserId: suedUserId, targetQuestionId: targetQuestionId, sueReason: reason, sueType: "board") { response in
                if response.code == 200 {
                    let alert = UIAlertController(title: "신고가 완료되었습니다.", message: nil, preferredStyle: UIAlertController.Style.alert)
                    
                    let cancelAction = UIAlertAction(title: "닫기", style: .default, handler: nil)
                    
                    alert.addAction(cancelAction)
                    self.present(alert, animated: false, completion: nil)
                }
            }
        }
    }
}
