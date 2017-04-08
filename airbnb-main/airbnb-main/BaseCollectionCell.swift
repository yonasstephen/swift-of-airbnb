//
//  BaseCollectionCell.swift
//  airbnb-main
//
//  Created by Yonas Stephen on 3/4/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

class BaseCollectionCell: UICollectionViewCell {
    
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
