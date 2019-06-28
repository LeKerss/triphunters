//
//  ProfilViewController.swift
//  TripHunters
//
//  Created by oscar Amzalag on 28/06/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit

class ProfilViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Outlets
    @IBOutlet weak var imgProfil: UIImageView!
    @IBOutlet weak var imgNationality: UIImageView!
    @IBOutlet weak var pseudoLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var tableForCollections: UITableView!
    
    // Création d'une variable myUser
    var myUser : User = User(idUser: 1, pseudo: "NqbraL", firstName: "Simon", lastName: "Chevalier", description: "Ceci est la description... blablabla", email: "sim.chevalier@gmail.com", password: "testpw", nationality: "france", imageProfil: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initProfilInformations()
        // Do any additional setup after loading the view.
    }
    
    // Fonction d'initialisation des libellés du Profil et les images de profil et de nationalité
    func initProfilInformations() {
        pseudoLabel.text = myUser.pseudo
        nameLabel.text = "\(myUser.firstName) \(myUser.lastName)"
        if let description = myUser.description{
            descLabel.text = description
        } else{
            descLabel.text = ""
        }
        if let image = myUser.imageProfil{
            imgProfil.image = image
        } else{
            imgProfil.image = UIImage(named: "IMG_default_user")
        }
        imgNationality.image = UIImage(named: "france")
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section title \(section)"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Ajout d'un item dans la tableView")
        if let cell = tableView.dequeueReusableCell(withIdentifier: "profileTableViewCell", for: indexPath) as? ProfileTableViewCell
        {
            return cell
        }
        return UITableViewCell()
    }
}

