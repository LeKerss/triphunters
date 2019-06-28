//
//  ProfileTableViewCell.swift
//  TripHunters
//
//  Created by Simon Chevalier on 28/06/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import Foundation
import UIKit





class ProfileTableViewCell : UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
        // Initialization code
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell: ProfileCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? ProfileCollectionViewCell
        {
            cell.imageActivity.image = UIImage(named: "france")
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = CGSize(width: 120, height: 120)
        return size
    }
    
}


