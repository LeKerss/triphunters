//
//  Activity.swift
//  TripHunters
//
//  Created by oscar Amzalag on 28/06/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import Foundation
import UIKit
import MapKit

enum ActivityType : CaseIterable {
    case Sports, Gastronomy, Cultural, Entertainement, Exploration, Freaky, NightLife
    
    func name() -> String {
        switch (self){
        case .Sports:
            return "Sport"
        case .Gastronomy:
            return "Gastronomie"
        case .Cultural:
            return "Culturel"
        case .Entertainement:
            return "Divertissement"
        case .Exploration:
            return "Exploration"
        case .Freaky:
            return "Insolite"
        case .NightLife:
            return "Nightlife"
        }
    }
    
    var color: UIColor {
        switch self {
        case .Sports:
            return UIColor(#colorLiteral(red: 0.9972489476, green: 0.4262111187, blue: 0, alpha: 1))
        case .Gastronomy:
            return UIColor(#colorLiteral(red: 0.8351348459, green: 0, blue: 0, alpha: 1))
        case .NightLife:
            return UIColor(#colorLiteral(red: 0.5647058824, green: 0, blue: 1, alpha: 1))
        case .Cultural:
            return UIColor(#colorLiteral(red: 0, green: 0.6274509804, blue: 0.8509803922, alpha: 1))
        case .Entertainement:
            return UIColor(#colorLiteral(red: 1, green: 0.7843137255, blue: 0.1921568627, alpha: 1))
        case .Exploration:
            return UIColor(#colorLiteral(red: 0, green: 0.7019607843, blue: 0, alpha: 1))
        case .Freaky:
            return UIColor(#colorLiteral(red: 0.8980392157, green: 0, blue: 0.4980392157, alpha: 1))
        }
    }
    
    var logo: UIImage {
        switch self {
        case .Cultural:
            return UIImage(named: "artBlack")!
        case .Entertainement:
            return UIImage(named: "entertainementBlack")!
        case .Exploration:
            return UIImage(named: "explorationBlack")!
        case .Freaky:
            return UIImage(named: "freakyBlack")!
        case .Gastronomy:
            return UIImage(named: "gastronomyBlack")!
        case .Sports:
            return UIImage(named: "sportsBlack")!
        case .NightLife:
            return UIImage(named: "nightlifeBlack")!
        }
    }
    
    
}

struct Activity {
    
    let idActivity: Int
    var idUser : Int
    var nameActivity: String
    var descriptionActivity: String
    var typeActivity: ActivityType
    var adresse: String
    var country: String
    var gpsx: Double
    var gpsy: Double
    var showActivity: Bool
    var imageDesc: [UIImage]
}

class ActivityPin : NSObject, MKAnnotation {
    let activity: Activity
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    
    init(activity act: Activity) {
        self.activity = act
        self.coordinate = CLLocationCoordinate2D(latitude: act.gpsx, longitude: act.gpsy)
        self.title = act.nameActivity
        self.subtitle = String(act.descriptionActivity.prefix(58))
        super.init()
    }
}
