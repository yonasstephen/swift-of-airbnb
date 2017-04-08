//
//  AirbnbDatePicker.swift
//  airbnb-datepicker
//
//  Created by Yonas Stephen on 22/2/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

public class AirbnbDatePicker: UIView, AirbnbDatePickerDelegate {
    
    public var selectedStartDate: Date?
    public var selectedEndDate: Date?
    public var delegate: UIViewController?
    
    var dateFormatter: DateFormatter {
        get {
            let f = DateFormatter()
            f.dateFormat = "d MMM"
            return f
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public lazy var dateInputButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = Theme.PRIMARY_COLOR
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btn.adjustsImageWhenHighlighted = false
        btn.addTarget(self, action: #selector(AirbnbDatePicker.showDatePicker), for: .touchUpInside)
        
        let img = UIImage(named: "Calendar", in: Bundle(for: AirbnbDatePicker.self), compatibleWith: nil)
        btn.setImage(img, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        
        btn.setTitle("Anytime", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        btn.titleLabel?.lineBreakMode = .byTruncatingTail
        
        return btn
    }()
    
    func setupViews() {
        addSubview(dateInputButton)
        
        dateInputButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dateInputButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dateInputButton.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        dateInputButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    func showDatePicker() {
        let datePickerViewController = AirbnbDatePickerViewController(dateFrom: selectedStartDate, dateTo: selectedEndDate)
        datePickerViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: datePickerViewController)
        delegate?.present(navigationController, animated: true, completion: nil)
    }
    
    public func datePickerController(_ datePickerController: AirbnbDatePickerViewController, didSaveStartDate startDate: Date?, endDate: Date?) {
        selectedStartDate = startDate
        selectedEndDate = endDate
        
        if selectedStartDate == nil && selectedEndDate == nil {
            dateInputButton.setTitle("Anytime", for: .normal)
            
        } else {
            dateInputButton.setTitle("\(dateFormatter.string(from: startDate!)) - \(dateFormatter.string(from: endDate!))", for: .normal)
        }
    }
}
