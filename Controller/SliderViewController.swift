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
        f.filter.layer.cornerRadius = 30
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
        return activityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityTableViewCell
        if lm.location != nil {
            myParent.updateDistance()
        }
        let pin = activityList[indexPath.row]
        cell.setImageArray(forActivity: pin)
        cell.activityName.text = pin.activity.nameActivity
        cell.imgCountry.image = UIImage(named: pin.activity.country)
        cell.categoryImg.image = pin.activity.typeActivity.logo
        cell.categoryImg.tintColor = pin.activity.typeActivity.color
        cell.activityDescription.text = pin.activity.descriptionActivity
        if pin.distance != -1 {
            cell.distanceFromUser.text = String(pin.distance) + " m"
        } else {
            cell.distanceFromUser.text = "Distance inconnue"
        }
        

        cell.activityImages.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myParent.currentActivity = activityList[indexPath.row].activity
        myParent.performSegue(withIdentifier: "goToActivity", sender: nil)
    }

}

class ActivityTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var activityImages: UICollectionView!
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var imgCountry: UIImageView!
    @IBOutlet weak var distanceFromUser: UILabel!
    @IBOutlet weak var activityDescription: UILabel!
    @IBOutlet weak var categoryImg: UIImageView!
    
    var imageArray = [UIImage]()

    override func awakeFromNib() {
        self.activityImages.delegate = self
        self.activityImages.dataSource = self
    }

    func setImageArray(forActivity activity: ActivityPin) {
        self.imageArray = activity.activity.imageDesc
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.activityImages.dequeueReusableCell(withReuseIdentifier: "sliderActivityCell", for: indexPath) as! ActivityCollectionViewCell
        cell.activityImg.image = self.imageArray[indexPath.row]
        cell.activityImg.layer.cornerRadius = 15
        return cell
    }

}

class ActivityCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var activityImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

// workaround for tintcolor not updating

extension UIImageView {
    override open func awakeFromNib() {
        super.awakeFromNib()
        tintColorDidChange()
    }
}
