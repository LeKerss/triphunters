//
//  TypeActivityTableViewController.swift
//  TripHunters
//
//  Created by Janin Culhaoglu on 02/07/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit

protocol CategoryPickerDelegate: class {
    func didSelectCategory(type: ActivityType)
}

class TypeActivityTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    weak var delegate: CategoryPickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ActivityType.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = ActivityType.allCases[indexPath.row].name()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
         tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let activity = ActivityType.allCases[indexPath.row]
        delegate?.didSelectCategory(type: activity)
        }
}
