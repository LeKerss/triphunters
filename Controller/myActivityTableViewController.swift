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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return listActivitiesMore.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell : TableActivityViewCell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as? TableActivityViewCell{
            cell.initListImages(myActivity: listActivitiesMore[indexPath.section])
            cell.nameActivity.text = listActivitiesMore[indexPath.section].nameActivity
            cell.imageCountry.image = UIImage(named: listActivitiesMore[indexPath.section].country)
            cell.categoryLabel.text = listActivitiesMore[indexPath.section].typeActivity.name()
            cell.categoryLabel.textColor = listActivitiesMore[indexPath.section].typeActivity.color
            if let userLocation = lm.location {
                let dist = userLocation.distance(from: CLLocation(latitude: CLLocationDegrees(floatLiteral: listActivitiesMore[indexPath.section].gpsx), longitude: CLLocationDegrees(floatLiteral: listActivitiesMore[indexPath.section].gpsy)))
                cell.distanceLabel.text = String(Int(dist)) + "m"
            }
            cell.descLabel.text = listActivitiesMore[indexPath.section].descriptionActivity
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
