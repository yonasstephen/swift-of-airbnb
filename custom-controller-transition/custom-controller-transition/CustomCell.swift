//
//  CustomCell.swift
//  custom-controller-transition
//
//  Created by Yonas Stephen on 9/4/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

protocol CustomCellDelegate {
    func didSelect(_ customCell:CustomCell)
}

class CustomCell: UICollectionViewCell {
    
    var delegate: CustomCellDelegate?
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
        
        let tap = UITapGestureRecognizer(target: self, action: "handleImageSelected")
        tap.numberOfTapsRequired = 1
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(imageView)
        
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    func handleImageSelected() {
        if let del = delegate {
            del.didSelect(self)
        }
    }
}
