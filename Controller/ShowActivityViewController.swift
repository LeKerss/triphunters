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
    
    
    var currentActivity = Activity(idActivity: 1, idUser: 1, nameActivity: "Wall Street Pigalle", descriptionActivity: "Un Concept Bar Unique à Paris. \n\nÀ partir de 18h le Concept Bar Wall Street Pigalle à Paris se transforme en place boursière pour vous proposer un large portefeuille boursier composé de verres de vins, de pintes de bières et de nombreux cocktails. \n\n5 écrans géants vous permettent de suivre le cours des boissons en direct dont la tendance changera toutes les 100 secondes ! \n\nUn verre peut ainsi passer de 12 à 4 euros en quelques secondes et même subir une décote sans précédent lors d’un des nombreux krachs boursiers qui viendront pimenter chaque soirée.", typeActivity: typeActivityEnum.NightLife, adresse: "49 Boulevard de Clichy, 75009 Paris", country: "France", gpsx: 0, gpsy: 0, showActivity: true, imageDesc: [UIImage(named: "activityWallStreet")!])
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        imageActivity.image = currentActivity.imageDesc[0]
        nameActivity.text = currentActivity.nameActivity
        adressActivity.text = currentActivity.adresse
        descriptionActivity.text = currentActivity.descriptionActivity
        // Do any additional setup after loading the view.
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
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
