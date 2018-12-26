//
//  AirbnbDatePickerHeader.swift
//  airbnb-datepicker
//
//  Created by Yonas Stephen on 23/2/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

class AirbnbDatePickerHeader: UIView {
    
    var calendar = Calendar.current
    var dateDayNameFormat = DateFormatter()
    var dateMonthYearFormat = DateFormatter()
    
    var selectedStartDate: Date? {
        didSet {
            if let date = selectedStartDate {
                startDayLabel.text = "\(dateDayNameFormat.string(from: date)),"
                startDateLabel.text = dateMonthYearFormat.string(from: date)
            } else {
                startDayLabel.text = "Start"
                startDateLabel.text = "Date"
            }
        }
    }
    var selectedEndDate: Date? {
        didSet {
            if let date = selectedEndDate {
                endDayLabel.text = "\(dateDayNameFormat.string(from: date)),"
                endDateLabel.text = dateMonthYearFormat.string(from: date)
            } else {
                endDayLabel.text = "End"
                endDateLabel.text = "Date"
            }
        }

    }
    
    var startDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Start"
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    var startDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date"
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    var endDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "End"
        label.textAlignment = .right
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    var endDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date"
        label.textAlignment = .right
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    var dayLabels: [UILabel] = {
        let days = ["S", "M", "T", "W", "T", "F", "S"]
        var labels = [UILabel]()
        
        for (i, day) in days.enumerated() {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = day
            label.textAlignment = .center
            label.textColor = UIColor.white
            labels.append(label)
        }
        
        return labels
    }()
    
    var slashView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var slashWidthConstraint: NSLayoutConstraint?
    var slash: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dateDayNameFormat.dateFormat = "EEEE"
        dateMonthYearFormat.dateFormat = "d MMM"
        
        setupStartDayLabel()
        setupStartDateLabel()
        
        setupEndDayLabel()
        setupEndDateLabel()
        
        setupSlashView()
        
        setupDayLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Update length constraint and rotation angle
        slashWidthConstraint?.constant = sqrt(pow(slashView.frame.size.width, 2) + pow(slashView.frame.size.height, 2))
        slash.transform = CGAffineTransform(rotationAngle: -atan2(slashView.frame.size.height, slashView.frame.size.width))
    }

    
    func setupStartDayLabel() {
        addSubview(startDayLabel)
        
        startDayLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        startDayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        startDayLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        startDayLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3).isActive = true
    }
    
    func setupStartDateLabel() {
        addSubview(startDateLabel)
        
        startDateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        startDateLabel.topAnchor.constraint(equalTo: startDayLabel.bottomAnchor).isActive = true
        startDateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        startDateLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3).isActive = true
    }
    
    func setupEndDayLabel() {
        addSubview(endDayLabel)
        
        endDayLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        endDayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        endDayLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        endDayLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3).isActive = true
    }
    
    func setupEndDateLabel() {
        addSubview(endDateLabel)
        
        endDateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        endDateLabel.topAnchor.constraint(equalTo: endDayLabel.bottomAnchor).isActive = true
        endDateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        endDateLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3).isActive = true
    }
    
    func setupSlashView() {
        addSubview(slashView)
        
        slashView.leftAnchor.constraint(equalTo: startDayLabel.rightAnchor, constant: 30).isActive = true
        slashView.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        slashView.heightAnchor.constraint(equalTo: slashView.widthAnchor).isActive = true
        slashView.rightAnchor.constraint(equalTo: endDayLabel.leftAnchor, constant: -10).isActive = true
        
        slashView.addSubview(slash)
        
        slash.centerXAnchor.constraint(equalTo: slashView.centerXAnchor).isActive = true
        slash.centerYAnchor.constraint(equalTo: slashView.centerYAnchor).isActive = true
        slash.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        slashWidthConstraint = slash.widthAnchor.constraint(equalToConstant: 0)
        slashWidthConstraint?.isActive = true
    }
    
    func setupDayLabels() {
        for (i, label) in dayLabels.enumerated() {
            addSubview(label)
            
            label.leftAnchor.constraint(equalTo: i == 0 ? leftAnchor : dayLabels[i - 1].rightAnchor).isActive = true
            label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 25).isActive = true
            label.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/CGFloat(dayLabels.count)).isActive = true
        }
    }
}
