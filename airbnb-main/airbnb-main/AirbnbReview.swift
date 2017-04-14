//
//  AirbnbReview.swift
//  airbnb-main
//
//  Created by Yonas Stephen on 13/4/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

class AirbnbReview: UIView {
    
    var starSize: CGFloat = 12
    
    var rating: Double = 0 {
        didSet {
            var val = rating
            for i in 0..<stars.count {
                if val >= 0.75 {
                    stars[i].type = .full
                    val -= 1
                } else if val >= 0.25 {
                    stars[i].type = .halfEmpty
                    val -= 0.5
                } else {
                    stars[i].type = .empty
                }
            }
        }
    }
    
    var stars: [AirbnbStar] = {
        var arr = [AirbnbStar]()
        for _ in 0..<5 {
            let view = AirbnbStar()
            view.translatesAutoresizingMaskIntoConstraints = false
            arr.append(view)
        }
        return arr
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for i in 0..<stars.count {
            addSubview(stars[i])
            
            stars[i].leftAnchor.constraint(equalTo: i == 0 ? leftAnchor : stars[i - 1].rightAnchor).isActive = true
            stars[i].widthAnchor.constraint(equalToConstant: starSize).isActive = true
            stars[i].centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            stars[i].heightAnchor.constraint(equalToConstant: starSize).isActive = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
