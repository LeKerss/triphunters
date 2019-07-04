//
//  DecouvrirViewController.swift
//  TripHunters
//
//  Created by oscar Amzalag on 28/06/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit
import MapKit


var activityList = allActivities.map { (Activity) -> ActivityPin in
    return ActivityPin(activity: Activity)
}

class DecouvrirViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    enum SliderState {
        case expanded, collapsed
    }
    
    var sliderViewController: SliderViewController!
    var visualEffectView: UIVisualEffectView!
    
    @IBOutlet weak var relocateBtn: UIButton!
    let screenSize: CGRect = UIScreen.main.bounds
    var sliderRatio: CGFloat = 0.9
    var sliderHandleAreaRatio: CGFloat = 0.3
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
    
//    Table view
    
    
    var currentActivity: Activity!
    
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
        self.relocateBtn.layer.cornerRadius = 10
    
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
        sliderHandleAreaHeight = screenSize.height * sliderHandleAreaRatio
        
        visualEffectView = UIVisualEffectView()
        self.visualEffectView.frame = self.mapView.frame
        
        sliderViewController = self.storyboard?.instantiateViewController(withIdentifier: "slider") as! SliderViewController
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
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.delegate = self
        
        // Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        
        self.locationManager = locationManager
        self.locationManager.startUpdatingLocation()
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if(!firstLocation) {
            centerLocation()
            firstLocation = true
        }
    }
    
    func centerLocation() {
        //Zoom to user location
        if let userLocation = self.locationManager.location?.coordinate {
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let viewRegion = MKCoordinateRegion(center: userLocation, span: span)
            mapView.setRegion(viewRegion, animated: true)
        }
        
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
