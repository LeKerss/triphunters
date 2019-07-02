//
//  TypeActivityTableViewController.swift
//  TripHunters
//
//  Created by Janin Culhaoglu on 02/07/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit

class TypeActivityTableViewController: UITableViewController {
    
    var typeActivity = ["Sports", "Gastronomy", "Cultural", "Entertainement", "Exploration", "Freaky", "NightLife"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return typeActivityEnum.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = typeActivity[indexPath.row]
        return cell
    }
}
