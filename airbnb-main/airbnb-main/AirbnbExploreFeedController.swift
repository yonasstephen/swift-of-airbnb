//
//  AirbnbExploreFeedController.swift
//  airbnb-main
//
//  Created by Yonas Stephen on 12/3/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit

class AirbnbExploreFeedController: BaseTableController {
    
    let cellID = "cellID"
    
    var categories = ["Just Booked", "Homes", "Experiences", "Featured Destinations"]
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.register(AirbnbCategoryTableCell.self, forCellReuseIdentifier: self.cellID)
        view.rowHeight = 300
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.allowsSelection = false
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

extension AirbnbExploreFeedController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! AirbnbCategoryTableCell
        
        cell.title = categories[indexPath.section]
        
        let imageNames = ["home-1", "home-2", "home-3", "home-4"]
        let prices = [200, 250, 400, 550]
        let location = ["Milan", "London", "Stavanger", "Munich"]

        var homes = [AirbnbHome]()
        for i in 0..<4 {
            let home = AirbnbHome(imageName: imageNames[i], description: "Entire home in \(location[i])", price: prices[i], reviewCount: Int(arc4random_uniform(300) + 1))
            homes.append(home)
        }
        
        cell.items = homes
        
        return cell
    }
}


