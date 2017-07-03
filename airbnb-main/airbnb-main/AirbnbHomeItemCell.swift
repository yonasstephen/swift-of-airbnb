//
//  AirbnbHomeItemCell.swift
//  airbnb-main
//
//  Created by Yonas Stephen on 3/4/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

class AirbnbHomeItemCell: BaseCollectionCell {
    
    var home: AirbnbHome? {
        didSet {
            imageView.image = UIImage(named: home!.imageName)
            priceLabel.text = "$\(home!.price)"
            descriptionLabel.text = home?.homeDescription
            reviewCountLabel.text = "\(home!.reviewCount) Reviews"
            ratingView.rating = home!.rating
        }
    }
    
    var homeDescription: String? {
        didSet {
            descriptionLabel.text = homeDescription
        }
    }
    
    var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    var priceLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 14)
        view.textColor = UIColor.black
        return view
    }()
    
    var descriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = UIColor.gray
        return view
    }()
    
    var ratingView: AirbnbReview = {
        let view = AirbnbReview()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var reviewCountLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 10)
        view.textColor = UIColor.darkGray
        return view
    }()
    
    override func setupViews() {
        
        addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        addSubview(priceLabel)
        
        priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(descriptionLabel)
        
        descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: priceLabel.rightAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        addSubview(ratingView)
        
        ratingView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 0).isActive = true
        ratingView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        ratingView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        ratingView.widthAnchor.constraint(equalToConstant: ratingView.starSize * CGFloat(ratingView.stars.count)).isActive = true
        
        addSubview(reviewCountLabel)
        
        reviewCountLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 0).isActive = true
        reviewCountLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        reviewCountLabel.leftAnchor.constraint(equalTo: ratingView.rightAnchor, constant: 5).isActive = true
        reviewCountLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
    }
}
