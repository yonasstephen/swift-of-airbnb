//
//  AirbnbMapController.swift
//  airbnb-main
//
//  Created by Yonas Stephen on 20/4/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit
import MapKit

class AirbnbMapController: UIViewController {
    
    let cellID = "cellID"
    
    let locations = ["Oslo", "Stockholm", "Barcelona", "Madrid", "Copenhagen", "London", "Milan", "Rome", "Hamburg"]
    
    lazy var items: [AirbnbHome] = {
        var arr = [AirbnbHome]()
        for i in 5..<11 {
            let location = self.locations[Int(arc4random_uniform(UInt32(self.locations.count)))]
            let item = AirbnbHome(imageName: "home-\(i)", description: "Entire home in \(location)", price: Int(arc4random_uniform(100) + 200), reviewCount: Int(arc4random_uniform(300) + 1), rating: Double(arc4random()) / Double(UINT32_MAX) + 4)
            arr.append(item)
        }
        return arr
    }()
    
    var mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var thumbnailCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: 200, height: 185)
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.register(AirbnbMapItemCell.self, forCellWithReuseIdentifier: self.cellID)
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(thumbnailCollectionView)
        
        thumbnailCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        thumbnailCollectionView.heightAnchor.constraint(equalToConstant: 185).isActive = true
        thumbnailCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        thumbnailCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        view.addSubview(mapView)
        
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: thumbnailCollectionView.topAnchor).isActive = true
        mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
}

extension AirbnbMapController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AirbnbMapItemCell
        
        cell.home = items[indexPath.item]
        
        return cell
    }
}
