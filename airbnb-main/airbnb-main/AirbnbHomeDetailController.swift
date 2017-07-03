//
//  AirbnbHomeDetailController.swift
//  airbnb-main
//
//  Created by Yonas Stephen on 10/4/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

class AirbnbHomeDetailController: UIViewController {
    
    var tableIndexPath: IndexPath?
    var cellIndexPath: IndexPath?
    
    var home: AirbnbHome? {
        didSet {
            if let imageName = home?.imageName {
                imageView.image = UIImage(named: imageName)
            }
            
            if let title = home?.homeDescription {
                titleLabel.text = title
            }
            
            if let price = home?.price {
                priceLabel.text = "$\(price)"
            }
            
            if let review = home?.reviewCount {
                reviewCountLabel.text = "\(review)"
            }
            
            if let rating = home?.rating {
                ratingView.rating = rating
            }
        }
    }
    
    let sideMargin: CGFloat = 40
    
    var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.alwaysBounceVertical = true
        return view
    }()
    
    var footerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -1)
        view.layer.shadowOpacity = 0.1
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: "handleBackPressed", for: .touchUpInside)
        
        let img = UIImage(named: "Back")
        button.setImage(img, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()
    
    var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 30)
        view.textColor = Theme.DARK_GRAY
        return view
    }()
    
    var rentTypeLabel: VerticalAlignLabel = {
        let view = VerticalAlignLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.text = "Entire Home"
        view.verticalAlignment = .bottom
        return view
    }()

    var hostedByLabel: VerticalAlignLabel = {
        let view = VerticalAlignLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 16)
        view.textColor = UIColor.lightGray
        view.text = "Hosted by"
        return view
    }()
    
    var hostNameLabel: VerticalAlignLabel = {
        let view = VerticalAlignLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 16)
        view.textColor = Theme.SECONDARY_COLOR
        view.text = "Yonas Stephen"
        return view
    }()
    
    var hostProfileView: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.adjustsImageWhenHighlighted = false
        btn.layer.cornerRadius = 30
        btn.layer.masksToBounds = true
        
        let img = UIImage(named: "profpic")
        btn.setImage(img, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        
        return btn
    }()
    
    var hostSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.LIGHT_GRAY
        return view
    }()
    
    var guestIconLabel: AirbnbIconLabel = {
        let view = AirbnbIconLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var aboutHomeTextView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = Theme.DARK_GRAY
        view.font = UIFont.systemFont(ofSize: 16)
        view.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        return view
    }()
    
    var priceLabel: VerticalAlignLabel = {
        let view = VerticalAlignLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 14)
        view.textColor = UIColor.black
        view.verticalAlignment = .bottom
        view.textAlignment = .left
        return view
    }()
    
    var priceUnitLabel: VerticalAlignLabel = {
        let view = VerticalAlignLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = UIColor.black
        view.text = "per night"
        view.verticalAlignment = .bottom
        view.textAlignment = .left
        return view
    }()
    
    var ratingView: AirbnbReview = {
        let view = AirbnbReview()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var reviewCountLabel: VerticalAlignLabel = {
        let view = VerticalAlignLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 11)
        view.textColor = Theme.GRAY
        view.textAlignment = .left
        view.verticalAlignment = .middle
        return view
    }()
    
    var checkAvailabilityButton: AirbnbButton = {
        let btn = AirbnbButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Check Availability", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //let shadowPath = UIBezierPath(rect: footerView.bounds)
        //footerView.layer.shadowPath = shadowPath.cgPath
    }
    
    func setupViews() {
        
        view.addSubview(scrollView)
        
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        
        view.addSubview(footerView)
        
        footerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        footerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        footerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        setupScrollContent()
        setupFooterViews()
    }
    
    func setupScrollContent() {
        scrollView.addSubview(imageView)
        
        imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        
        scrollView.addSubview(backButton)
        
        backButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        backButton.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        scrollView .addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -sideMargin).isActive = true
        
        setupHostViews()
        
    }
    
    func setupHostViews() {
        scrollView .addSubview(hostProfileView)
        
        hostProfileView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        hostProfileView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        hostProfileView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        hostProfileView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -(sideMargin / 2)).isActive = true
        
        scrollView .addSubview(rentTypeLabel)
        
        rentTypeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        rentTypeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        rentTypeLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: sideMargin / 2).isActive = true
        rentTypeLabel.rightAnchor.constraint(equalTo: hostProfileView.leftAnchor, constant: -10).isActive = true
        
        scrollView .addSubview(hostedByLabel)
        
        hostedByLabel.topAnchor.constraint(equalTo: rentTypeLabel.bottomAnchor).isActive = true
        hostedByLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        hostedByLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: sideMargin / 2).isActive = true
        hostedByLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        scrollView .addSubview(hostNameLabel)
        
        hostNameLabel.topAnchor.constraint(equalTo: rentTypeLabel.bottomAnchor).isActive = true
        hostNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        hostNameLabel.leftAnchor.constraint(equalTo: hostedByLabel.rightAnchor, constant: 5).isActive = true
        hostNameLabel.rightAnchor.constraint(equalTo: hostProfileView.leftAnchor, constant: -10).isActive = true
        
        scrollView .addSubview(hostSeparator)
        
        hostSeparator.topAnchor.constraint(equalTo: hostProfileView.bottomAnchor, constant: 20).isActive = true
        hostSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        hostSeparator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        hostSeparator.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -sideMargin).isActive = true
        
        scrollView.addSubview(aboutHomeTextView)
        
        aboutHomeTextView.topAnchor.constraint(equalTo: hostSeparator.bottomAnchor, constant: 20).isActive = true
        aboutHomeTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        aboutHomeTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        aboutHomeTextView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -sideMargin).isActive = true
        

    }
    
    func setupFooterViews() {
        
        footerView.addSubview(checkAvailabilityButton)
        
        checkAvailabilityButton.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -(sideMargin/2)).isActive = true
        checkAvailabilityButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        checkAvailabilityButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        checkAvailabilityButton.heightAnchor.constraint(equalTo: footerView.heightAnchor, constant: -30).isActive = true
        
        footerView.addSubview(priceLabel)
        
        priceLabel.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: sideMargin / 2).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        priceLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 15).isActive = true
        priceLabel.heightAnchor.constraint(equalTo: footerView.heightAnchor, multiplier: 1/2, constant: -15).isActive = true
        
        footerView.addSubview(priceUnitLabel)
        
        priceUnitLabel.leftAnchor.constraint(equalTo: priceLabel.rightAnchor, constant: 5).isActive = true
        priceUnitLabel.rightAnchor.constraint(equalTo: checkAvailabilityButton.leftAnchor).isActive = true
        priceUnitLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 15).isActive = true
        priceUnitLabel.heightAnchor.constraint(equalTo: footerView.heightAnchor, multiplier: 1/2, constant: -15).isActive = true
        
        footerView.addSubview(ratingView)
        
        ratingView.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: sideMargin / 2).isActive = true
        ratingView.widthAnchor.constraint(equalToConstant: ratingView.starSize * CGFloat(ratingView.stars.count)).isActive = true
        ratingView.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -15).isActive = true
        ratingView.heightAnchor.constraint(equalTo: footerView.heightAnchor, multiplier: 1/2, constant: -15).isActive = true
        
        footerView.addSubview(reviewCountLabel)
        
        reviewCountLabel.leftAnchor.constraint(equalTo: ratingView.rightAnchor, constant: 5).isActive = true
        reviewCountLabel.rightAnchor.constraint(equalTo: checkAvailabilityButton.leftAnchor).isActive = true
        reviewCountLabel.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -15).isActive = true
        reviewCountLabel.heightAnchor.constraint(equalTo: footerView.heightAnchor, multiplier: 1/2, constant: -15).isActive = true

    }
    
    func handleBackPressed() {
        dismiss(animated: true, completion: nil)
    }
}

extension AirbnbHomeDetailController: ImageExpandAnimationControllerProtocol {
    func getImageDestinationFrame() -> CGRect {
        view.layoutIfNeeded()
        return imageView.frame
    }
}

extension AirbnbHomeDetailController: ImageShrinkAnimationControllerProtocol {
    func getInitialImageFrame() -> CGRect {
        view.layoutIfNeeded()
        return imageView.frame
    }
}
