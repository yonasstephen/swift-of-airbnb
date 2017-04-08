//
//  ViewController.swift
//  airbnb-occupant-filter
//
//  Created by Yonas Stephen on 4/4/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var occupantFilter: AirbnbOccupantFilter = {
        let btn = AirbnbOccupantFilter()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.delegate = self
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(occupantFilter)
        
        occupantFilter.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        occupantFilter.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        occupantFilter.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        occupantFilter.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
}

