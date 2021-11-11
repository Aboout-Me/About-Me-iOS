//
//  SocialTagCell.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/30.
//

import UIKit

class SocialTagCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "전체"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray333
        
        return label
    }()
    
    var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    var tagNumber: Int = 0
    var colors: [UIColor] = [.gray333, .primaryRed, .primaryYellow, .primaryGreen, .primaryPink, .primaryPurple]
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
                titleLabel.textColor = .white // colors[tagNumber]
                backView.backgroundColor = .gray333
//                backView.layer.borderColor = colors[tagNumber].cgColor
//                backView.layer.borderWidth = 1.5
            } else {
                titleLabel.font = UIFont.systemFont(ofSize: 15)
                titleLabel.textColor = .gray777
                backView.backgroundColor = .white
//                backView.layer.borderWidth = 0
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.textColor = .gray777
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configure() {
        addSubview(backView)
        backView.setDimensions(height: 40, width: self.frame.width)
        backView.centerX(inView: self)
        backView.centerY(inView: self)
        
        backView.addSubview(titleLabel)
        titleLabel.centerX(inView: backView)
        titleLabel.centerY(inView: backView)
        
        titleLabel.anchor(left: backView.leftAnchor, right: backView.rightAnchor, paddingLeft: 20, paddingRight: 20)
        titleLabel.textColor = .gray777
    }
    
}
