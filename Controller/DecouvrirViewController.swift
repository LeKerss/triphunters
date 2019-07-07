//
//  DecouvrirViewController.swift
//  TripHunters
//
//  Created by oscar Amzalag on 28/06/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit
import MapKit


var activityList = [ActivityPin]()
var activeFilters = [ActivityType]()

func sortActivityList() {
    activityList = activityList.sorted(by: { $0.distance < $1.distance })
}

let lm = CLLocationManager()

class DecouvrirViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDelegate {
    
    
    // Slider settings
    
    enum SliderState {
        case expanded, collapsed
    }
    
    var sliderViewController: SliderViewController!
    var visualEffectView: UIVisualEffectView!
    
    let screenSize: CGRect = UIScreen.main.bounds
    var sliderRatio: CGFloat = 0.9
    var sliderHandleAreaRatio: CGFloat = 0.35
    var sliderHeight: CGFloat = 500
    var sliderHandleAreaHeight: CGFloat = 120
    
    var sliderVisible = false
    var nextState:SliderState {
        return sliderVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
    // Map elements
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var firstLocation = false
    @IBOutlet weak var relocateView: UIView!
    
    // Table view
    
    var currentActivity: Activity!
    
    // Segue to activity page
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier) {
        case "goToActivity":
            let destinationViewController = segue.destination as? ShowActivityViewController
            destinationViewController?.currentActivity = self.currentActivity
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlider()
        setupLocation()
    }
    
    func setupTableView() {
        
    }
    
    @IBAction func relocate(_ sender: Any) {
        centerLocation()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setupSlider() {
        sliderHeight = screenSize.height * sliderRatio
        sliderHandleAreaHeight = 330
        
        visualEffectView = UIVisualEffectView()
        self.visualEffectView.frame = self.mapView.frame
        
        sliderViewController = (self.storyboard?.instantiateViewController(withIdentifier: "slider") as! SliderViewController)
        self.addChild(sliderViewController)
        self.view.addSubview(sliderViewController.view)
        
        sliderViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - sliderHandleAreaHeight, width: self.view.bounds.width, height: sliderHeight)
        
        sliderViewController.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DecouvrirViewController.handleSliderTap(recognizer:)))
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DecouvrirViewController.handleSliderPan(recognizer:)))
        
        sliderViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        sliderViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    @objc
    func handleSliderTap(recognizer:UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            startInteractiveTransition(state: nextState, duration: 0.8)
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    
    @objc
    func handleSliderPan(recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.5)
        case .changed:
            let translation = recognizer.translation(in: self.sliderViewController.handleArea)
            let fractionCompleted = translation.y / sliderHeight
            updateInteractiveTransition(fractionCompleted: sliderVisible ? fractionCompleted : -fractionCompleted)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    func animateTransitionIfNeeded(state:SliderState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.sliderViewController.view.frame.origin.y = self.view.frame.height - self.sliderHeight
                case .collapsed:
                    self.sliderViewController.view.frame.origin.y = self.view.frame.height - self.sliderHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.sliderVisible = !self.sliderVisible
                self.sliderViewController.tableView.reloadData()
                sortActivityList()
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            self.runningAnimations.append(frameAnimator)
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.sliderViewController.view.layer.cornerRadius = 12
                case .collapsed:
                    self.sliderViewController.view.layer.cornerRadius = 0
                    
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.mapView.addSubview(self.visualEffectView)
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
            blurAnimator.addCompletion {_ in
                switch state {
                case .expanded:
                    break
                case .collapsed:
                    self.visualEffectView.removeFromSuperview()
                }
            }
            
            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
        }
    }
    
    func startInteractiveTransition(state:SliderState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition () {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
    func setupLocation() {
        let button = MKUserTrackingButton(mapView: self.mapView)
        button.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        self.relocateView.addSubview(button)
        
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyBest
        mapView.delegate = self
        
        // Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            lm.requestAlwaysAuthorization()
            lm.requestWhenInUseAuthorization()
        }
        
        self.locationManager = lm
        self.locationManager.startUpdatingLocation()
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if(!firstLocation) {
            centerLocation()
            firstLocation = true
            updateDistance()
        }
    }
    
    func updateDistance() {
        if let userLocation = lm.location {
            for pin in activityList {
                let dist = userLocation.distance(from: CLLocation(latitude:pin.coordinate.latitude, longitude: pin.coordinate.longitude))
                pin.distance = Int(dist)
            }
            sortActivityList()
        }
    }
    
    func centerLocation() {
        //Zoom to user location
        if let userLocation = locationManager.location?.coordinate {
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let viewRegion = MKCoordinateRegion(center: userLocation, span: span)
            mapView.setRegion(viewRegion, animated: true)
        }
    }
    
    func populateMap() {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(activityList)
    }
    
    func addPoint(_ currentActivity: Activity) {
        let mapActivityPoint = MKPointAnnotation()
        mapActivityPoint.title = currentActivity.nameActivity
        mapActivityPoint.coordinate = CLLocationCoordinate2D(latitude: currentActivity.gpsx, longitude: currentActivity.gpsy)
        
        mapView.addAnnotation(mapActivityPoint)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // 2
        guard let annotation = annotation as? ActivityPin else { return nil }
        // 3
        let identifier = String(annotation.activity.idActivity)
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            view.markerTintColor = annotation.activity.typeActivity.color
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let activity = view.annotation as! ActivityPin
        self.currentActivity = activity.activity
        performSegue(withIdentifier: "goToActivity", sender: self)
    }
}
