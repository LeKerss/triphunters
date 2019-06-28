//
//  Activity.swift
//  TripHunters
//
//  Created by oscar Amzalag on 28/06/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import Foundation
import UIKit

struct Activity {
    
    let idActivity: Int
    var idUser : Int
    var nomActivité: String
    var descriptionActivite: String
    var typeActivity: String
    var adresse: String
    var gpsx: Double
    var gpsy: Double
    var affiché: Bool
    var imageDesc: [UIImage]
    
}
