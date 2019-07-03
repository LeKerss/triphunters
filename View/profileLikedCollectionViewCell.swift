//
//  profileLikedCollectionViewCell.swift
//  TripHunters
//
//  Created by Simon Chevalier on 01/07/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import Foundation
import UIKit

class profileLikedCollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var imageActivity: UIImageView!
    @IBOutlet weak var nameActivity: UILabel!
    @IBOutlet weak var categoryActivity: UILabel!
    @IBOutlet weak var imageCountry: UIImageView!
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected
            {
                UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                    self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                    
                }, completion: nil)
                UIView.animate(withDuration: 0.5, delay: 0.6, options: [], animations: {
                    self.transform = CGAffineTransform.identity
                    
                }, completion: nil)
            }
        }
    }
}
