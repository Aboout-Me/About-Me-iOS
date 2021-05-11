//
//  BottomSheetView.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/11.
//

import UIKit

class BottomSheetView: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var totalView: UIView!
    
    var panGestureRecognizer: UIPanGestureRecognizer?
      var originalPosition: CGPoint?
      var currentPositionTouched: CGPoint?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        self.view.isOpaque = false
        self.view.backgroundColor = .clear
        
        self.colorView.isOpaque = false
        self.colorView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.backgroundView.layer.cornerRadius = 15
        
        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
            view.addGestureRecognizer(panGestureRecognizer!)
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

}
