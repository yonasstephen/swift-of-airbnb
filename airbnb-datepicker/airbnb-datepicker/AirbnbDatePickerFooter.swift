//
//  AirbnbDatePickerFooter.swift
//  airbnb-datepicker
//
//  Created by Yonas Stephen on 24/2/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

protocol AirbnbDatePickerFooterDelegate {
    func didSave()
}

class AirbnbDatePickerFooter: UIView {
    
    var delegate: AirbnbDatePickerFooterDelegate?
    var isSaveEnabled: Bool? {
        didSet {
            if let enabled = isSaveEnabled, enabled {
                saveButton.isEnabled = true
                saveButton.alpha = 1
            } else {
                saveButton.isEnabled = false
                saveButton.alpha = 0.5
            }
        }
    }
    
    lazy var saveButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = Theme.SECONDARY_COLOR
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("Save", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(AirbnbDatePickerFooter.handleSave), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Theme.PRIMARY_COLOR
        
        addSubview(saveButton)
        
        saveButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        saveButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalTo: heightAnchor, constant: -20).isActive = true
        saveButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -30).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleSave() {
        if let del = delegate {
            del.didSave()
        }
    }
}
