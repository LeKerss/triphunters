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
    var tag: Int
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
    var myParent: DecouvrirViewController!
    
    func isFilterActive(forType type: ActivityType) -> Bool {
        for filter in filters {
            if filter.type == type{
                return filter.active
            }
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleLine.layer.cornerRadius = 3
        myParent = self.parent as? DecouvrirViewController
        
        // Initialisation des filtres
        initFilters()
        setupFilters()
        applyFilters()

    }
    
    func initFilters() {
        self.filters = [
            FilterStruct(type: .Sports, filter: sportsFilter, active: true, tag: 1),
            FilterStruct(type: .Exploration, filter: explorationFilter, active: true, tag: 2),
            FilterStruct(type: .Cultural, filter: cultureFilter, active: true, tag: 3),
            FilterStruct(type: .NightLife, filter: nightFilter, active: true, tag: 4),
            FilterStruct(type: .Freaky, filter: freakyFilter, active: true, tag: 5),
            FilterStruct(type: .Entertainement, filter: entertainementFilter, active: true, tag: 6),
            FilterStruct(type: .Gastronomy, filter: gastronomyFilter, active: true, tag: 7)
        ]
    }
    
    func setupFilters() {
        for f in filters {
            colorFilter(f)
            addRecognizer(f)
        }
    }
    
    func applyFilters() {
        let filteredActivities = allActivities.filter { (activity) -> Bool in
            return isFilterActive(forType: activity.typeActivity)
        }
        
        activityList = filteredActivities.map {(activity) -> ActivityPin in
            return ActivityPin(activity: activity)
        }
        myParent.populateMap()
    }
    
    func colorFilter(_ f: FilterStruct) {
        f.filter.layer.cornerRadius = 25
        if f.active {
            f.filter.layer.backgroundColor = f.type.color.cgColor
        }
        else {
            f.filter.layer.backgroundColor =  UIColor.lightGray.cgColor
        }
    }
    
    func addRecognizer(_ f: FilterStruct) {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(SliderViewController.setFilter(recognizer:)))
        
        f.filter.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func setFilter(recognizer: UITapGestureRecognizer) {
        if let view = recognizer.view {
            self.filters[view.tag - 1].active = self.filters[view.tag - 1].active ? false : true
            colorFilter(self.filters[view.tag - 1])
            applyFilters()
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
