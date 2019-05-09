//
//  AirbnbDatePickerMonthHeader.swift
//  airbnb-datepicker
//
//  Created by Yonas Stephen on 23/2/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

class AirbnbDatePickerMonthHeader: BaseCell {

    var monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(monthLabel)
        
        monthLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        monthLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        monthLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        monthLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
