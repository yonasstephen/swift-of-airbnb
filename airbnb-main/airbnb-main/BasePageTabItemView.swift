//
//  BasePageTabView.swift
//  airbnb-main
//
//  Created by Yonas Stephen on 13/3/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

class BasePageTabItemView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func layoutSubviews() {
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}
