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
    let locations = ["Milan", "London", "Stavanger", "Munich"]
    lazy var homes: [AirbnbHome] = {
        var arr = [AirbnbHome]()
        for i in 0..<4 {
            let location = self.locations[Int(arc4random_uniform(UInt32(self.locations.count)))]
            let home = AirbnbHome(imageName: "home-" + "\(i + 1)", description: "Entire home in \(location)", price: Int(arc4random_uniform(100) + 200), reviewCount: Int(arc4random_uniform(300) + 1), rating: Double(arc4random()) / Double(UINT32_MAX) + 4)
            arr.append(home)
        }
        return arr
    }()
    
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
        cell.items = homes
        cell.indexPath = indexPath // needed for dismiss animation
        
        if let parent = parent as? AirbnbCategoryTableCellDelegate {
            cell.delegate = parent
        }

        return cell
    }
}


