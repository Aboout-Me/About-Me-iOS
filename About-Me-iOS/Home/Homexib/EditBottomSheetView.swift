//
//  EditBottomSheetView.swift
//  오늘의 나
//
//  Created by Kim dohyun on 2021/06/28.
//

import UIKit

class EditBottomSheetView: UIView {
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var gestureView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
}
