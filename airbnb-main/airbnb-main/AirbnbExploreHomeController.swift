//
//  AirbnbExploreHomeController.swift
//  airbnb-main
//
//  Created by Yonas Stephen on 23/3/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

class AirbnbExploreHomeController: BaseTableController {
    
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
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.register(AirbnbHomeItemTableCell.self, forCellReuseIdentifier: self.cellID)
        view.allowsSelection = false
        view.rowHeight = 15 + 250 + 20 + 20 + 15
        view.separatorStyle = .none
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}

extension AirbnbExploreHomeController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! AirbnbHomeItemTableCell
        
        //cell.textLabel?.text = "\(indexPath.item)"
        cell.home = items[indexPath.row]
        
        return cell
    }
}
