//
//  mapAddActivityViewController.swift
//  TripHunters
//
//  Created by oscar Amzalag on 05/07/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit
import MapKit

class mapAddActivityViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var adressPoint: CLLocationCoordinate2D!
    var activity: Activity!
    var proposerView: ProposerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        let mapActivityPoint = MKPointAnnotation()
        //mapActivityPoint.title = currentActivity.nameActivity
        mapActivityPoint.coordinate = adressPoint
        map.setRegion(MKCoordinateRegion(center: mapActivityPoint.coordinate, latitudinalMeters: 100, longitudinalMeters: 100), animated: false)
        map.addAnnotation(mapActivityPoint)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func create(_ sender: Any) {
        allActivities.insert(activity, at: 0)
        activityList.append(ActivityPin(activity: activity))
        newActivity = true
        proposerView.clearAll(self)
        navigationController?.popViewController(animated: false)
        proposerView.performSegue(withIdentifier: "showActivityCreate", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as? ShowActivityViewController
        destinationViewController?.currentActivity = activity!
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
