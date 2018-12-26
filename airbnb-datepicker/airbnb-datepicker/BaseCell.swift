//
//  BaseCell.swift
//  padstaview
//
//  Created by Yonas Stephen on 11/10/16.
//  Copyright © 2016 Yonas Stephen. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}
