//
//  listActivityTableView.swift
//  TripHunters
//
//  Created by Simon Chevalier on 07/07/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import Foundation
import UIKit

class TableActivityViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    @IBOutlet weak var imagesActivityCollectionView: UICollectionView!
    @IBOutlet weak var nameActivity: UILabel!
    @IBOutlet weak var imageCountry: UIImageView!
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    
    var listImages : [UIImage] = []

    
    override func awakeFromNib() {
        self.imagesActivityCollectionView.delegate = self
        self.imagesActivityCollectionView.dataSource = self
    }
    

    
    func initListImages(activity : Activity){
        listImages = activity.imageDesc
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell : imgActivityCollectionViewCell = imagesActivityCollectionView.dequeueReusableCell(withReuseIdentifier: "imgActivityCell", for: indexPath) as? imgActivityCollectionViewCell{
            cell.imgActivity.image = listImages[indexPath.row]
            cell.imgActivity.layer.cornerRadius = 15
            return cell
        }
        return UICollectionViewCell()
    }
}

class imgActivityCollectionViewCell : UICollectionViewCell{
    
    @IBOutlet weak var imgActivity: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
