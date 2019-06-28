//
//  Activity.swift
//  TripHunters
//
//  Created by oscar Amzalag on 28/06/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import Foundation
import UIKit

enum typeActivityEnum {
    case Sports, Gastronomy, Cultural, Entertainement, Exploration, Freaky, NightLife
}

struct Activity {
    
    let idActivity: Int
    var idUser : Int
    var nameActivity: String
    var descriptionActivity: String
    var typeActivity: typeActivityEnum
    var adresse: String
    var country: String
    var gpsx: Double
    var gpsy: Double
    var showActivity: Bool
    var imageDesc: [UIImage]
    
}
