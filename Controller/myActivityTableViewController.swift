//
//  myActivityTableViewController.swift
//  TripHunters
//
//  Created by oscar Amzalag on 03/07/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit
import MapKit


class myActivityTableViewController: UITableViewController {
    
    var listActivitiesMore : [Activity] = []
    var name : String = ""
    
    var activitySelected:Activity? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = name
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return listActivitiesMore.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell : TableActivityViewCell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as? TableActivityViewCell{
            cell.initListImages(activity: listActivitiesMore[indexPath.section])
            cell.nameActivity.text = listActivitiesMore[indexPath.section].nameActivity
            cell.imageCountry.image = UIImage(named: listActivitiesMore[indexPath.section].country)
            cell.imgCategory.image = listActivitiesMore[indexPath.section].typeActivity.logo
            cell.imgCategory.tintColor = listActivitiesMore[indexPath.section].typeActivity.color
            cell.descLabel.text = listActivitiesMore[indexPath.section].descriptionActivity
            cell.imagesActivityCollectionView.reloadData()
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activitySelected = listActivitiesMore[indexPath.section]
        performSegue(withIdentifier: "showActivityFromList", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as? ShowActivityViewController
        destinationViewController?.currentActivity = activitySelected!
        
    }

}
