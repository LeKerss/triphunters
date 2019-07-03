//
//  ProfilViewController.swift
//  TripHunters
//
//  Created by oscar Amzalag on 28/06/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit

class ProfilViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    

    // Outlets View Header Profile
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var pseudoLabel: UILabel!
    @IBOutlet weak var imgNationality: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // Outlet Collections
    @IBOutlet weak var joinedActivityCollection: UICollectionView!
    @IBOutlet weak var proposedActivityCollection: UICollectionView!
    @IBOutlet weak var favoriteActivityCollection: UICollectionView!
    @IBOutlet weak var buttonJoinedShowMore: UIButton!
    @IBOutlet weak var buttonProposedShowMore: UIButton!
    @IBOutlet weak var buttonFavoriteShowMore: UIButton!
    
    // Outlet Views in stackview
    @IBOutlet weak var myStackView: UIStackView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var joinedView: UIView!
    @IBOutlet weak var proposedView: UIView!
    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var joinedViewEmpty: UIView!
    @IBOutlet weak var proposedViewEmpty: UIView!
    
    // Outlet Countraints in stackview
    @IBOutlet weak var heightMyStackView: NSLayoutConstraint!
    @IBOutlet weak var heightProfileHeader: NSLayoutConstraint!
    @IBOutlet weak var proposedViewTop: NSLayoutConstraint!
    @IBOutlet weak var favoriteViewTop: NSLayoutConstraint!
    
    
    
    var activitySelected : Activity? = nil
    var listSelectedForMore  : [Activity] = []
    var nameForMore : String = ""
    
    var listActivityJoined : [Activity] = []
    var listActivityProposed : [Activity] = []
    var listActivityFavorites : [Activity] = []
    
    // Création d'une variable myUser
    var myUser : User = User(idUser: 1, pseudo: "NqbraL", firstName: "Simon", lastName: "Chevalier", description: nil, email: "sim.chevalier@gmail.com", password: "testpw", nationality: "france", imageProfil: nil)
    
    var Activity1 = Activity(idActivity: 1, idUser: 1, nameActivity: "Wall Street Pigalle", descriptionActivity: "Un Concept Bar Unique à Paris. \n\nÀ partir de 18h le Concept Bar Wall Street Pigalle à Paris se transforme en place boursière pour vous proposer un large portefeuille boursier composé de verres de vins, de pintes de bières et de nombreux cocktails. \n\n5 écrans géants vous permettent de suivre le cours des boissons en direct dont la tendance changera toutes les 100 secondes ! \n\nUn verre peut ainsi passer de 12 à 4 euros en quelques secondes et même subir une décote sans précédent lors d’un des nombreux krachs boursiers qui viendront pimenter chaque soirée.", typeActivity: .NightLife, adresse: "49 Boulevard de Clichy, 75009 Paris", country: "FranceTest", gpsx: 48.88315, gpsy: 2.333989, showActivity: true, imageDesc: [UIImage(named: "activityWallStreet1")!, UIImage(named: "activityWallStreet2")!])
    
    var Activity2 = Activity(idActivity: 2, idUser: 2, nameActivity: "Le musée du Louvre", descriptionActivity: "Avec plus de 460.000 œuvres intemporelles de l’Antiquité à nos jours, le Musée du Louvre est l’un des plus grands musées d’art et d’histoire du monde. \n\nVous y découvrirez des œuvres mondialement connues, telles que La Joconde, La Vénus de Milo, le Radeau de la Méduse, La Liberté guidant le peuple, La mort de la Vierge, La Dentellière, Le Sacre de Napoléon, le Portrait de Louis XIV en costume de sacre, etc.", typeActivity: .Cultural, adresse: "99, rue de Rivoli, 75001 Paris", country: "FranceTest", gpsx: 48.864824, gpsy: 2.334595, showActivity: true, imageDesc: [UIImage(named: "louvre1")!, UIImage(named: "louvre2")!, UIImage(named: "louvre3")!, UIImage(named: "louvre4")!])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        joinedActivityCollection.delegate = self
        joinedActivityCollection.dataSource = self
        proposedActivityCollection.delegate = self
        proposedActivityCollection.dataSource = self
        favoriteActivityCollection.delegate = self
        favoriteActivityCollection.dataSource = self
        initProfilInformations()
        initListForCollections()
        manageView()
        
        // Do any additional setup after loading the view.
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        initProfilInformations()
//        initListForCollections()
//        manageView()
//    }
    
    // Fonction d'initialisation des libellés du Profil et les images de profil et de nationalité
    func initProfilInformations() {
        pseudoLabel.text = myUser.pseudo
        nameLabel.text = "\(myUser.firstName) \(myUser.lastName)"
        if let image = myUser.imageProfil{
            imgProfile.image = image
        } else{
            imgProfile.image = UIImage(named: "IMG_default_user")
        }
        imgNationality.image = UIImage(named: "france")
    }
    
    // Fonction d'initialisation des listes pour préparer les collectionView
    func initListForCollections(){
        listActivityJoined.append(Activity2)
        listActivityJoined.append(Activity1)
        listActivityProposed.append(Activity2)
        listActivityFavorites.append(Activity1)
        listActivityFavorites.append(Activity2)
    }
    
    func manageView(){
        let heightFavorite = favoriteView.frame.height
        if (listActivityJoined.count == 0){
            joinedActivityCollection.isHidden = true
            joinedViewEmpty.isHidden = false
            buttonJoinedShowMore.isHidden = true
        }
        else{
            joinedActivityCollection.isHidden = false
            joinedViewEmpty.isHidden = true
            buttonJoinedShowMore.isHidden = false
        }
        if (listActivityProposed.count == 0){
            proposedActivityCollection.isHidden = true
            proposedViewEmpty.isHidden = false
            buttonProposedShowMore.isHidden = true
        }
        else{
            proposedActivityCollection.isHidden = false
            proposedViewEmpty.isHidden = true
            buttonProposedShowMore.isHidden = false
        }
        if (listActivityFavorites.count == 0){
            favoriteView.isHidden = true
            heightMyStackView.constant -= heightFavorite
        }

    }
    
    
    // Nombre d'item max : 10 sinon longueur tableau
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(collectionView){
        case self.joinedActivityCollection:
            if (listActivityJoined.count < 10){
                return listActivityJoined.count
            }
            else{
                return 10
            }
        case self.proposedActivityCollection:
            if (listActivityProposed.count < 10){
                return listActivityProposed.count
            }
            else{
                return 10
            }
        case self.favoriteActivityCollection:
            if (listActivityFavorites.count < 10){
                return listActivityFavorites.count
            }
            else{
                return 10
            }
        default:
            return 10
        }
    }
    
    
    // Fonction d'ajout d'element dans les differentes collectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch (collectionView){
        case self.joinedActivityCollection:
            if let cell: profileJoinedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "joinedCell", for: indexPath) as? profileJoinedCollectionViewCell
            {
                cell.imageActivity
                    .image = listActivityJoined[indexPath.row].imageDesc[0]
                cell.nameActivity.text = listActivityJoined[indexPath.row].nameActivity
                cell.categoryActivity.text = listActivityJoined[indexPath.row].typeActivity.name()
                cell.imageCountry.image = UIImage(named:listActivityJoined[indexPath.row].country)
                return cell
            }
            return UICollectionViewCell()
        case self.proposedActivityCollection:
            if let cell: profileProposedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "proposedCell", for: indexPath) as? profileProposedCollectionViewCell
            {
                cell.imageActivity
                    .image = listActivityProposed[indexPath.row].imageDesc[0]
                cell.nameActivity.text = listActivityProposed[indexPath.row].nameActivity
                cell.categoryActivity.text = listActivityProposed[indexPath.row].typeActivity.name()
                cell.imageCountry.image = UIImage(named:listActivityProposed[indexPath.row].country)
                return cell
            }
            return UICollectionViewCell()
        case self.favoriteActivityCollection:
            if let cell: profileFavoriteCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as? profileFavoriteCollectionViewCell
            {
                cell.imageActivity
                    .image = listActivityFavorites[indexPath.row].imageDesc[0]
                cell.nameActivity.text = listActivityFavorites[indexPath.row].nameActivity
                cell.categoryActivity.text = listActivityFavorites[indexPath.row].typeActivity.name()
                cell.imageCountry.image = UIImage(named:listActivityFavorites[indexPath.row].country)
                return cell
            }
            return UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (collectionView){
        case self.joinedActivityCollection:
            activitySelected = listActivityJoined[indexPath.row]
        case self.proposedActivityCollection:
            activitySelected = listActivityProposed[indexPath.row]
        case self.favoriteActivityCollection:
            activitySelected = listActivityFavorites[indexPath.row]
        default:
            break
        }
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier){
        case "showDetail" :
            let destinationViewController = segue.destination as? ShowActivityViewController
            destinationViewController?.currentActivity = activitySelected!
        case "showMore" :
            let destinationViewController = segue.destination as? myActivityTableViewController
            destinationViewController?.name = nameForMore
            destinationViewController?.listActivty = listSelectedForMore
        default:
            break
        }
        
    }
    @IBAction func joinedShowMore(_ sender: Any) {
        nameForMore = "✔︎ Mes activités rejoints"
        listSelectedForMore = listActivityJoined
        performSegue(withIdentifier: "showMore", sender: self)
    }
    
    @IBAction func proposedShowMore(_ sender: Any) {
        nameForMore = "+ Mes activités proposées"
        listSelectedForMore = listActivityProposed
        performSegue(withIdentifier: "showMore", sender: self)
    }
    
    @IBAction func favoriteShowMore(_ sender: Any) {
        nameForMore = " ★ Mes activités favorites"
        listSelectedForMore = listActivityFavorites
        performSegue(withIdentifier: "showMore", sender: self)
    }
    
    
    @IBAction func discoverButton(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func proposedButton(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
    }
}

