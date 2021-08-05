//
//  SocialSearchCell.swift
//  About-Me-iOS
//
//  Created by Hyeyeon Lee on 2021/05/30.
//

import UIKit

class SocialSearchCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var searchTextLabel: UILabel!
    var buttonClosure: (() -> Void)?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Selectors
    
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        buttonClosure!()
    }
    
}
