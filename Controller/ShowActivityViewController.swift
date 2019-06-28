//
//  ShowActivityViewController.swift
//  TripHunters
//
//  Created by oscar Amzalag on 28/06/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit

class ShowActivityViewController: UIViewController {

    @IBOutlet weak var imageActivity: UIImageView!
    @IBOutlet weak var nameActivity: UILabel!
    @IBOutlet weak var adressActivity: UILabel!
    @IBOutlet weak var descriptionActivity: UILabel!
    @IBOutlet weak var favoriteText: UIButton!
    
    
    var currentActivity = Activity(idActivity: 1, idUser: 1, nameActivity: "Wall Street Pigalle", descriptionActivity: "Un Concept Bar Unique à Paris. \n\nÀ partir de 18h le Concept Bar Wall Street Pigalle à Paris se transforme en place boursière pour vous proposer un large portefeuille boursier composé de verres de vins, de pintes de bières et de nombreux cocktails. \n\n5 écrans géants vous permettent de suivre le cours des boissons en direct dont la tendance changera toutes les 100 secondes ! \n\nUn verre peut ainsi passer de 12 à 4 euros en quelques secondes et même subir une décote sans précédent lors d’un des nombreux krachs boursiers qui viendront pimenter chaque soirée.", typeActivity: typeActivityEnum.NightLife, adresse: "49 Boulevard de Clichy, 75009 Paris", country: "France", gpsx: 0, gpsy: 0, showActivity: true, imageDesc: [UIImage(named: "activityWallStreet1")!, UIImage(named: "activityWallStreet2")!])
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteText.setTitle("☆",for: .normal)
        favoriteText.setTitle("★",for: .selected)
        favoriteText.isSelected = false
        
        imageActivity.image = currentActivity.imageDesc[0]
        nameActivity.text = currentActivity.nameActivity
        adressActivity.text = currentActivity.adresse
        descriptionActivity.text = currentActivity.descriptionActivity
        // Do any additional setup after loading the view.
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        if favoriteText.isSelected == false {
            //add fav
             favoriteText.isSelected.toggle()
        }else{
            //delete fav
            favoriteText.isSelected.toggle()
        }
       
    }
    @IBAction func changeImage(_ sender: Any) {
        //pas 2 fois le meme
        imageActivity.image = currentActivity.imageDesc[Int.random(in: 0...(currentActivity.imageDesc.count - 1))]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
