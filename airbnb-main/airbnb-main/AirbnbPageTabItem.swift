//
//  AirbnbPageTabItem.swift
//  airbnb-main
//
//  Created by Yonas Stephen on 13/3/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

protocol AirbnbPageTabItemDelegate {
    func didSelect(tabItem: AirbnbPageTabItem, completion: (() -> Void)?)
}

class AirbnbPageTabItem: BasePageTabItemView {
    
    var delegate: AirbnbPageTabItemDelegate?
    
    var title: String = "" {
        didSet {
            titleButton.setTitle(title.uppercased(), for: .normal)
        }
    }
    var titleColor: UIColor = UIColor.white {
        didSet {
            titleButton.setTitleColor(titleColor, for: .normal)
        }
    }
    
    var selectedTitleColor: UIColor = UIColor.white {
        didSet {
            if isSelected {
                titleButton.setTitleColor(selectedTitleColor, for: .normal)
            }
        }
    }
    
    var isSelected: Bool = false {
        didSet {
            if isSelected {
                
            } else {
                
            }
        }
    }
    
    lazy var titleButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(self.titleColor, for: .normal)
        view.titleLabel?.textAlignment = .center
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        view.addTarget(self, action: #selector(AirbnbPageTabItem.didSelect), for: .touchUpInside)
        return view
    }()
    
    var titleLabelWidthAnchor: NSLayoutConstraint?
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(titleButton)
        
        titleButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        titleButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -30).isActive = true
    }
    
    func didSelect() {
        if let handler = delegate {
            handler.didSelect(tabItem: self, completion: nil)
        }
    }
}
