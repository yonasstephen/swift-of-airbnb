//
//  AirbnbCounter.swift
//  airbnb-occupant-filter
//
//  Created by Yonas Stephen on 4/4/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit


protocol AirbnbCounterDelegate {
    func counter(_ counter: AirbnbCounter, didUpdate count: Int)
}

class AirbnbCounter: UIView {
    
    var delegate: AirbnbCounterDelegate?
    var fieldID: String?
    
    var maxCount: Int? {
        didSet {
            updateMaxMinCount()
        }
    }
    var minCount: Int?{
        didSet {
            updateMaxMinCount()
        }
    }
    
    var firstLayout: Bool = true
    var count: Int = 0 {
        didSet {
            countLabel.text = "\(count)"
            
            updateMaxMinCount()
            
            if let del = delegate {
                del.counter(self, didUpdate: count)
            }
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
        count = minCount ?? 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    lazy var decrementButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Minus", in: Bundle(for: AirbnbOccupantFilter.self), compatibleWith: nil), for: .normal)
        button.addTarget(self, action: #selector(AirbnbCounter.handleDecrement), for: .touchUpInside)
        button.adjustsImageWhenHighlighted = false

        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = button.frame.size.width / 2
        return button
    }()
    
    lazy var countLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 22)
        view.textColor = UIColor.white
        view.textAlignment = .center
        view.text = "\(self.count)"
        return view
    }()
    
    var incrementButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Plus", in: Bundle(for: AirbnbOccupantFilter.self), compatibleWith: nil), for: .normal)
        button.addTarget(self, action: #selector(AirbnbCounter.handleIncrement), for: .touchUpInside)
        button.adjustsImageWhenHighlighted = false

        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = button.frame.size.width / 2
        return button
    }()
    
    func setupViews() {
        
        addSubview(incrementButton)
        
        incrementButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        incrementButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        incrementButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        incrementButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(countLabel)
        
        countLabel.rightAnchor.constraint(equalTo: incrementButton.leftAnchor).isActive = true
        countLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        countLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        countLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(decrementButton)
        
        decrementButton.rightAnchor.constraint(equalTo: countLabel.leftAnchor).isActive = true
        decrementButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        decrementButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        decrementButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(captionLabel)
        
        captionLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        captionLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 2/3).isActive = true
        captionLabel.rightAnchor.constraint(equalTo: decrementButton.leftAnchor).isActive = true
        captionLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        addSubview(subCaptionLabel)
        
        subCaptionLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor).isActive = true
        subCaptionLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/3).isActive = true
        subCaptionLabel.rightAnchor.constraint(equalTo: decrementButton.leftAnchor).isActive = true
        subCaptionLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        decrementButton.layer.cornerRadius = decrementButton.frame.size.width / 2
        incrementButton.layer.cornerRadius = incrementButton.frame.size.width / 2

    }
    
    @objc func handleDecrement() {
        count -= 1
    }
    
    @objc func handleIncrement() {
        count += 1
    }
    
    func updateMaxMinCount() {
        if minCount != nil, count <= minCount! {
            decrementButton.isEnabled = false
            decrementButton.alpha = 0.5
        } else {
            decrementButton.isEnabled = true
            decrementButton.alpha = 1
        }
        
        if maxCount != nil, count >= maxCount! {
            incrementButton.isEnabled = false
            incrementButton.alpha = 0.5
        } else {
            incrementButton.isEnabled = true
            incrementButton.alpha = 1
        }

    }
}
