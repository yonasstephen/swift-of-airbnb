//
//  UIImage.swift
//  airbnb-occupant-filter
//
//  Created by Yonas Stephen on 5/4/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

extension UIImage {
    func tint(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        
        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
