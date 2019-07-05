//
//  SliderViewController.swift
//  TripHunters
//
//  Created by Annas Saker on 01/07/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit
import MapKit

struct FilterStruct {
    var type: ActivityType
    var filter: UIView
    var active: Bool
}

class SliderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var handleLine: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var sportsFilter: UIView!
    @IBOutlet weak var explorationFilter: UIView!
    @IBOutlet weak var cultureFilter: UIView!
    @IBOutlet weak var nightFilter: UIView!
    @IBOutlet weak var gastronomyFilter: UIView!
    @IBOutlet weak var entertainementFilter: UIView!
    @IBOutlet weak var freakyFilter: UIView!
    
    var filters = [FilterStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleLine.layer.cornerRadius = 3
        
        // Initialisation des filtres
        initFilters()
        colorFilterButtons()

    }
    
    func initFilters() {
        self.filters = [
            FilterStruct(type: .Sports, filter: sportsFilter, active: true),
            FilterStruct(type: .Cultural, filter: cultureFilter, active: true),
            FilterStruct(type: .Entertainement, filter: entertainementFilter, active: true),
            FilterStruct(type: .Exploration, filter: explorationFilter, active: true),
            FilterStruct(type: .Freaky, filter: freakyFilter, active: true),
            FilterStruct(type: .Gastronomy, filter: gastronomyFilter, active: true),
            FilterStruct(type: .NightLife, filter: nightFilter, active: true)
        ]
    }
    
    func colorFilterButtons() {
        for f in filters {
            f.filter.layer.cornerRadius = 25
            if f.active {
                f.filter.layer.backgroundColor = f.type.color.cgColor
            }
            else {
                f.filter.layer.backgroundColor =  UIColor.lightGray.cgColor
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allActivities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityTableViewCell
        let pin = ActivityPin(activity: allActivities[indexPath.row])
        
        cell.activityName.text = pin.activity.nameActivity
        cell.activityDescription.text = pin.activity.descriptionActivity
        if let userLocation = lm.location {
            let dist = userLocation.distance(from: CLLocation(latitude:pin.coordinate.latitude, longitude: pin.coordinate.longitude))
            cell.distanceFromUser.text = String(Int(dist)) + "m"
        }
        return cell
    }

}

class ActivityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var distanceFromUser: UILabel!
    @IBOutlet weak var activityDescription: UILabel!
    
}
