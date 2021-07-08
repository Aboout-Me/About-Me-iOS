//
//  BottomSheetView.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/11.
//

import UIKit

class BottomSheetView: UIViewController {
    
    enum Mode {
        case none
        case saveAdvisory
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var handle: UIView!
    
    var panGestureRecognizer: UIPanGestureRecognizer?
    var originalPosition: CGPoint?
    var currentPositionTouched: CGPoint?
    
    var mode: Mode = .none
    weak var delegate: AdvisoryDelegate?
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
        
        if self.mode == .saveAdvisory {
            setAdvisoryView()
        }
    }
    
    // MARK: - Helpers
    
    private func configure() {
        self.view.isOpaque = false
        self.view.backgroundColor = .clear
        
        self.colorView.isOpaque = false
        self.colorView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.backgroundView.layer.cornerRadius = 15
        self.handle.layer.cornerRadius = 2.5
        
        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        view.addGestureRecognizer(panGestureRecognizer!)
    }
    
    private func setAdvisoryView() {
        let confirmImage = UIImageView(image: UIImage(named: "confirm.png"))
        confirmImage.setDimensions(height: 50, width: 50)
        
        let confirmLabel = UILabel()
        confirmLabel.text = "글을 저장 하시겠어요?"
        confirmLabel.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 15)// UIFont.systemFont(ofSize: 15)
        confirmLabel.textColor = .gray555
        
        let cancelButton = CustomButton(text: "취소", type: .white)
        let saveButton = CustomButton(text: "저장", type: .black)

        contentView.addSubview(confirmImage)
        confirmImage.centerX(inView: contentView)
        confirmImage.anchor(top: contentView.topAnchor, paddingTop: 30)
        
        contentView.addSubview(confirmLabel)
        confirmLabel.centerX(inView: contentView)
        confirmLabel.anchor(top: confirmImage.bottomAnchor, paddingTop: 15)
        
        let width = (self.contentView.frame.size.width - 20 - 20 - 5) / 2
        contentView.addSubview(cancelButton)
        cancelButton.setDimensions(height: 50, width: width)
//        cancelButton.anchor(top: confirmLabel.bottomAnchor, right: contentView.centerXAnchor,
//                              paddingTop: 50, paddingRight: 5)
        cancelButton.anchor(bottom: contentView.bottomAnchor, right: contentView.centerXAnchor, paddingBottom: 10, paddingRight: 5)
        cancelButton.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)

        contentView.addSubview(saveButton)
        saveButton.setDimensions(height: 50, width: width)
//        saveButton.anchor(top: confirmLabel.bottomAnchor, left: contentView.centerXAnchor,
//                          paddingTop: 50, paddingLeft: 5)
        saveButton.anchor(left: contentView.centerXAnchor, bottom: contentView.bottomAnchor, paddingLeft: 5, paddingBottom: 10)
        saveButton.addTarget(self, action: #selector(saveButtonDidTap), for: .touchUpInside)
    }

    // MARK: - Selectors
    
    @objc
    func cancelButtonDidTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func saveButtonDidTap(_ sender: UIButton) {
        self.delegate?.saveButtonDidTap {
            self.dismiss(animated: true) {
                self.delegate?.closeViewControllersDelegate()
            }
        }
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
    
}
