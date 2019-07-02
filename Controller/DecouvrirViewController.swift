//
//  DecouvrirViewController.swift
//  TripHunters
//
//  Created by oscar Amzalag on 28/06/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit
import MapKit

class DecouvrirViewController: UIViewController {
    
    enum SliderState {
        case expanded, collapsed
    }
    
    var sliderViewController: SliderViewController!
    var visualEffectView: UIVisualEffectView!
    
    let screenSize: CGRect = UIScreen.main.bounds
    var sliderRatio: CGFloat = 0.9
    var sliderHandleAreaRatio: CGFloat = 0.2
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
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlider()
        setupLocation()
    
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
        
        sliderViewController = SliderViewController(nibName: "SliderViewController", bundle:nil)
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
    locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        
    }
}
