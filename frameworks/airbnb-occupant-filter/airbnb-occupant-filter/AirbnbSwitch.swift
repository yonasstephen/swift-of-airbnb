//
//  AirbnbSwitch.swift
//  airbnb-occupant-filter
//
//  Created by Yonas Stephen on 5/4/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

class AirbnbSwitch: UIView {
    
    var isAnimating: Bool = false
    var state: Bool = false {
        didSet {
            toggleButton.isEnabled = false
            layoutIfNeeded()
            UIView.setAnimationCurve(.easeInOut)
            UIView.animate(withDuration: 0.2, animations: {
                self.toggleButtonLeftConstraint?.isActive = !self.state
                self.toggleButtonRightConstraint?.isActive = self.state
                self.toggleButton.setImage(self.state ? self.onImage : self.offImage, for: .normal)
                
                self.layoutIfNeeded()
            }, completion: { success in
                self.toggleButton.isEnabled = true
            })
        }
    }
    
    var caption: String? {
        didSet {
            captionLabel.text = caption
        }
    }
    
    var subCaption: String? {
        didSet {
            subCaptionLabel.text = subCaption
        }
    }
    
    var toggleButtonLeftConstraint: NSLayoutConstraint?
    var toggleButtonRightConstraint: NSLayoutConstraint?
    
    var offImage: UIImage = {
        var img = UIImage(named: "Delete", in: Bundle(for: AirbnbOccupantFilter.self), compatibleWith: nil)
        img = img?.tint(with: Theme.PRIMARY_COLOR)
        return img!
    }()
    
    var onImage: UIImage = {
        var img = UIImage(named: "Checkmark", in: Bundle(for: AirbnbOccupantFilter.self), compatibleWith: nil)
        img = img?.tint(with: Theme.PRIMARY_COLOR)
        return img!
    }()
    
    var switchContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var toggleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(self.offImage, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(AirbnbSwitch.toggle), for: .touchUpInside)
        button.adjustsImageWhenHighlighted = false

        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        return button
    }()
    
    var captionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 22)
        view.textColor = UIColor.white
        return view
    }()
    
    var subCaptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 15)
        view.textColor = UIColor.white
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(switchContainer)
        
        switchContainer.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        switchContainer.widthAnchor.constraint(equalToConstant: 40).isActive = true
        switchContainer.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchContainer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        switchContainer.addSubview(toggleButton)
        
        toggleButtonLeftConstraint = toggleButton.leftAnchor.constraint(equalTo: switchContainer.leftAnchor)
        toggleButtonLeftConstraint?.isActive = true
        toggleButtonRightConstraint = toggleButton.rightAnchor.constraint(equalTo: switchContainer.rightAnchor)
        toggleButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        toggleButton.centerYAnchor.constraint(equalTo: switchContainer.centerYAnchor).isActive = true
        toggleButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(captionLabel)
        
        captionLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        captionLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 2/3).isActive = true
        captionLabel.rightAnchor.constraint(equalTo: switchContainer.leftAnchor).isActive = true
        captionLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        addSubview(subCaptionLabel)
        
        subCaptionLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor).isActive = true
        subCaptionLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/3).isActive = true
        subCaptionLabel.rightAnchor.constraint(equalTo: switchContainer.leftAnchor).isActive = true
        subCaptionLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    }
    
    @objc func toggle() {
        state = !state
    }
}
