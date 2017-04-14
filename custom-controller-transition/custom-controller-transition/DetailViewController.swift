//
//  DetailViewController.swift
//  custom-controller-transition
//
//  Created by Yonas Stephen on 10/4/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var imageName: String? {
        didSet {
            if let name = imageName {
                imageView.image = UIImage(named: name)
            }
        }
    }
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        
        view.addSubview(imageView)
        
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
}
