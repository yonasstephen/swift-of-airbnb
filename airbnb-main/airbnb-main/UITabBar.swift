//
//  UITabBar.swift
//  airbnb-main
//
//  Created by Yonas Stephen on 12/3/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

extension UITabBar {
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 55 // adjust your size here
        return sizeThatFits
    }
}
