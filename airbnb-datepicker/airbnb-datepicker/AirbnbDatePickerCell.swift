//
//  AirbnbDatePickerCell.swift
//  airbnb-datepicker
//
//  Created by Yonas Stephen on 23/2/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

class AirbnbDatePickerCell: BaseCell {
    
    var type: AirbnbDatePickerCellType! = []
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.white
        return label
    }()
    
    var highlightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(dateLabel)
        
        dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        addSubview(highlightView)
        
        highlightView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        highlightView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        highlightView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        highlightView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    func configureCell() {
        if type.contains(.Selected) || type.contains(.SelectedStartDate) || type.contains(.SelectedEndDate) || type.contains(.InBetweenDate) {
            
            dateLabel.layer.cornerRadius = 0
            dateLabel.layer.borderColor = UIColor.white.cgColor
            dateLabel.layer.borderWidth = 1
            dateLabel.layer.backgroundColor = UIColor.white.cgColor
            dateLabel.layer.mask = nil
            dateLabel.textColor = Theme.SECONDARY_COLOR
            
            if type.contains(.SelectedStartDate) {
                let side = frame.size.width / 2
                let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: side, height: side))
                let shape = CAShapeLayer()
                shape.path = maskPath.cgPath
                dateLabel.layer.mask = shape
                
            } else if type.contains(.SelectedEndDate) {
                let side = frame.size.width / 2
                let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: side, height: side))
                let shape = CAShapeLayer()
                shape.path = maskPath.cgPath
                dateLabel.layer.mask = shape
                
            } else if !type.contains(.InBetweenDate) {
                dateLabel.layer.cornerRadius = frame.size.width / 2
            }
            
        } else if type.contains(.PastDate) {
            
            dateLabel.layer.cornerRadius = 0
            dateLabel.layer.borderColor = UIColor.clear.cgColor
            dateLabel.layer.borderWidth = 0
            dateLabel.layer.backgroundColor = UIColor.clear.cgColor
            dateLabel.layer.mask = nil
            dateLabel.textColor = Theme.SECONDARY_COLOR

        } else if type.contains(.Today) {
            
            dateLabel.layer.cornerRadius = self.frame.size.width / 2
            dateLabel.layer.borderColor = Theme.SECONDARY_COLOR.cgColor
            dateLabel.layer.borderWidth = 1
            dateLabel.layer.backgroundColor = UIColor.clear.cgColor
            dateLabel.layer.mask = nil
            dateLabel.textColor = UIColor.white
            
        } else {
            
            dateLabel.layer.cornerRadius = 0
            dateLabel.layer.borderColor = UIColor.clear.cgColor
            dateLabel.layer.borderWidth = 0
            dateLabel.layer.backgroundColor = UIColor.clear.cgColor
            dateLabel.layer.mask = nil
            dateLabel.textColor = UIColor.white

        }
        
        
        if type.contains(.Highlighted) {
            highlightView.backgroundColor = UIColor(red: 200 / 255, green: 200 / 255, blue: 200 / 255, alpha: 0.6)
            highlightView.layer.cornerRadius = frame.size.width / 2
        } else {
            highlightView.backgroundColor = UIColor.clear
        }
    }
}

struct AirbnbDatePickerCellType: OptionSet {
    let rawValue: Int
    
    static let Date = AirbnbDatePickerCellType(rawValue: 1 << 0)                    // has number
    static let Empty = AirbnbDatePickerCellType(rawValue: 1 << 1)                   // has no number
    static let PastDate = AirbnbDatePickerCellType(rawValue: 1 << 2)                // disabled
    static let Today = AirbnbDatePickerCellType(rawValue: 1 << 3)                   // has circle
    static let Selected = AirbnbDatePickerCellType(rawValue: 1 << 4)                // has filled circle
    static let SelectedStartDate = AirbnbDatePickerCellType(rawValue: 1 << 5)       // has half filled circle on the left
    static let SelectedEndDate = AirbnbDatePickerCellType(rawValue: 1 << 6)         // has half filled circle on the right
    static let InBetweenDate = AirbnbDatePickerCellType(rawValue: 1 << 7)           // has filled square
    static let Highlighted = AirbnbDatePickerCellType(rawValue: 1 << 8)             // has 
}
