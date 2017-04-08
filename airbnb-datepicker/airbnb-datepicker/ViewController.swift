//
//  ViewController.swift
//  airbnb-datepicker
//
//  Created by Yonas Stephen on 22/2/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var datePicker: AirbnbDatePicker = {
        let btn = AirbnbDatePicker()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.delegate = self
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(datePicker)
        
        datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datePicker.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }

}

