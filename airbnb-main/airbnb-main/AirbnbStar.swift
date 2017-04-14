//
//  AirbnbStar.swift
//  airbnb-main
//
//  Created by Yonas Stephen on 14/4/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

enum AirbnbStarType {
    case empty, halfEmpty, full
}

class AirbnbStar: UIView {
    
    var type: AirbnbStarType = .empty {
        didSet {
            switch type {
            case .empty:
                starView.image = UIImage(named: "Star Empty")?.tint(with: Theme.SECONDARY_COLOR)
            case .halfEmpty:
                starView.image = UIImage(named: "Star Half Empty")?.tint(with: Theme.SECONDARY_COLOR)
            case .full:
                starView.image = UIImage(named: "Star Filled")?.tint(with: Theme.SECONDARY_COLOR)
            }
        }
    }
    
    var starView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(starView)
        
        starView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        starView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        starView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        starView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
