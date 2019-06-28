//
//  ProfilViewController.swift
//  TripHunters
//
//  Created by oscar Amzalag on 28/06/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit

class ProfilViewController: UIViewController {

    @IBOutlet weak var imgProfil: UIImageView!
    @IBOutlet weak var imgNationality: UIImageView!
    @IBOutlet weak var pseudoLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var myUser : User = User(idUser: 1, firstName: "Simon", lastName: "Chevalier", email: "sim.chevalier@gmail.com", password: "testpw", nationality: "france", imageProfil: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initProfilInformations()
        // Do any additional setup after loading the view.
    }
    
    func initProfilInformations() {
        nameLabel.text = "\(myUser.firstName) \(myUser.lastName)"
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
