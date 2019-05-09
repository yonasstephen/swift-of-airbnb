//
//  AirbnbOccupantFilter.swift
//  airbnb-occupant-filter
//
//  Created by Yonas Stephen on 4/4/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

public class AirbnbOccupantFilter: UIView {
    
    public var delegate: UIViewController?
    
    var adultCount: Int = 1
    var childrenCount: Int = 0
    var infantCount: Int = 0
    var hasPet: Bool = false
    
    public var occupantInputButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = Theme.PRIMARY_COLOR
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btn.adjustsImageWhenHighlighted = false
        btn.addTarget(self, action: #selector(AirbnbOccupantFilter.showOccupantFilter), for: .touchUpInside)
        
        let img = UIImage(named: "Family", in: Bundle(for: AirbnbOccupantFilter.self), compatibleWith: nil)
        btn.setImage(img, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        
        btn.setTitle("1 guest", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        btn.titleLabel?.lineBreakMode = .byTruncatingTail
        return btn
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(occupantInputButton)
        
        occupantInputButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        occupantInputButton.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        occupantInputButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        occupantInputButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
    }
    
    @objc func showOccupantFilter() {
        let occupantController = AirbnbOccupantFilterController(adultCount: adultCount, childrenCount: childrenCount, infantCount: infantCount, hasPet: hasPet)
        occupantController.delegate = self
        let navigationController = UINavigationController(rootViewController: occupantController)
        delegate?.present(navigationController, animated: true, completion: nil)
    }
}

extension AirbnbOccupantFilter: AirbnbOccupantFilterControllerDelegate {
    func occupantFilterController(_ occupantFilterController: AirbnbOccupantFilterController, didSaveAdult adult: Int, children: Int, infant: Int, pet: Bool) {
        
        self.adultCount = adult
        self.childrenCount = children
        self.infantCount = infant
        self.hasPet = pet
        
        let human = adult + children
        let infant = "\(infant > 0 ? (infant.description + " infant" + (infant > 1 ? "s" : "")) : "")"
        let pet = "\(pet ? "pets" : "")"
        
        let text = "\(human) guest\(human > 1 ? "s" : "")" + (infant != "" ? ", " + infant : "") + (pet != "" ? ", " + pet : "")
        occupantInputButton.setTitle(text, for: .normal)
    }
}
