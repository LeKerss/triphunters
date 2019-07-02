//
//  Activity.swift
//  TripHunters
//
//  Created by oscar Amzalag on 28/06/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import Foundation
import UIKit

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
