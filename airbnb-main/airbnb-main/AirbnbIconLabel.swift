//
//  AirbnbIconLabel.swift
//  airbnb-main
//
//  Created by Yonas Stephen on 15/4/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

class AirbnbIconLabel: UIView {
    
    var iconView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    var labelView: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 16)
        view.textColor = UIColor.black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(labelView)
        
        labelView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        labelView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        labelView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        labelView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(iconView)
        
        iconView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        iconView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        iconView.bottomAnchor.constraint(equalTo: labelView.topAnchor).isActive = true
        iconView.topAnchor.constraint(equalTo: topAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
