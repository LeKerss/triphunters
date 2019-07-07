//
//  OtherProfileViewController.swift
//  TripHunters
//
//  Created by Simon Chevalier on 07/07/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit

class OtherProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    
    @IBOutlet weak var joinedEmptyLabel: UILabel!
    @IBOutlet weak var proposedEmptyLabel: UILabel!
    
    // Outlet Countraints in stackview
    @IBOutlet weak var heightMyStackView: NSLayoutConstraint!
    @IBOutlet weak var heightProfileHeader: NSLayoutConstraint!
    @IBOutlet weak var favoriteViewTop: NSLayoutConstraint!

    @IBOutlet weak var scrollView: UIScrollView!
    
    var activitySelected : Activity? = nil
    var listSelectedForMore  : [Activity] = []
    var nameForMore : String = ""
    
    var listActivityJoined : [Activity] = []
    var listActivityProposed : [Activity] = []
    var listActivityFavorites : [Activity] = []
    
    // Création d'une variable myUser
    var myUser : User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Pull to refresh
        if #available(iOS 10.0, *) {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self,
                                     action: #selector(refreshOptions(sender:)),
                                     for: .valueChanged)
            scrollView.refreshControl = refreshControl
        }
        joinedActivityCollection.delegate = self
        joinedActivityCollection.dataSource = self
        proposedActivityCollection.delegate = self
        proposedActivityCollection.dataSource = self
        favoriteActivityCollection.delegate = self
        favoriteActivityCollection.dataSource = self
        self.title = "Profil de \(myUser.pseudo)"
        initProfilInformations()
        initListForCollections()
        manageView()
        
        // Do any additional setup after loading the view.
    }
    
    // Fonction d'initialisation des libellés du Profil et les images de profil et de nationalité
    func initProfilInformations() {
        pseudoLabel.text = myUser.pseudo
        nameLabel.text = "\(myUser.firstName) \(myUser.lastName)"
        
        if let image = myUser.imageProfil{
            imgProfile.maskCircle(anyImage: image)
            
        } else{
            imgProfile.maskCircle(anyImage: UIImage(named: "IMG_default_user")!)
        }
        
        imgNationality.image = UIImage(named: myUser.nationality)
    }
    
    // Fonction d'initialisation des listes pour préparer les collectionView
    func initListForCollections(){
        
        listActivityProposed = []
        listActivityFavorites = []
        listActivityJoined = []
        for activity in allActivities {
            if activity.idUser == self.myUser.idUser {
                listActivityProposed.append(activity)
            }
            for fav in allFavorites {
                if fav.idUser == self.myUser.idUser {
                    if activity.idActivity == fav.idActivity {
                        listActivityFavorites.append(activity)
                    }
                }
            }
            for joined in allInscriptions {
                if joined.idUser == self.myUser.idUser {
                    if activity.idActivity == joined.idActivity {
                        listActivityJoined.append(activity)
                    }
                }
            }
        }
        self.joinedActivityCollection.reloadData()
        self.proposedActivityCollection.reloadData()
        self.favoriteActivityCollection.reloadData()
    }
    
    func manageView(){
        let heightFavorite = favoriteView.frame.height
        if (listActivityJoined.count == 0){
            joinedActivityCollection.isHidden = true
            joinedEmptyLabel.text = "\(myUser.pseudo) n'a rejoint pour l'instant'aucune activité."
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
            proposedEmptyLabel.text = "\(myUser.pseudo) n'a rejoint pour l'instant' aucune activité."
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
                print("1")
                cell.imageActivity
                    .image = listActivityJoined[indexPath.row].imageDesc[0]
                cell.imageActivity.layer.cornerRadius = 15
                cell.nameActivity.text = listActivityJoined[indexPath.row].nameActivity
                cell.categoryActivity.text = listActivityJoined[indexPath.row].typeActivity.name()
                cell.categoryActivity.textColor = listActivityJoined[indexPath.row].typeActivity.color
                cell.categoryActivity.font = UIFont.boldSystemFont(ofSize: 12)
                cell.imageCountry.image = UIImage(named:listActivityJoined[indexPath.row].country)
                return cell
            }
            return UICollectionViewCell()
        case self.proposedActivityCollection:
            if let cell: profileProposedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "proposedCell", for: indexPath) as? profileProposedCollectionViewCell
            {
                print("2")
                cell.imageActivity
                    .image = listActivityProposed[indexPath.row].imageDesc[0]
                cell.imageActivity.layer.cornerRadius = 15
                cell.nameActivity.text = listActivityProposed[indexPath.row].nameActivity
                cell.categoryActivity.text = listActivityProposed[indexPath.row].typeActivity.name()
                cell.categoryActivity.textColor = listActivityProposed[indexPath.row].typeActivity.color
                cell.categoryActivity.font = UIFont.boldSystemFont(ofSize: 12)
                cell.imageCountry.image = UIImage(named:listActivityProposed[indexPath.row].country)
                return cell
            }
            return UICollectionViewCell()
        case self.favoriteActivityCollection:
            if let cell: profileFavoriteCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as? profileFavoriteCollectionViewCell
            {
                print("3")
                cell.imageActivity
                    .image = listActivityFavorites[indexPath.row].imageDesc[0]
                cell.imageActivity.layer.cornerRadius = 15
                cell.nameActivity.text = listActivityFavorites[indexPath.row].nameActivity
                cell.categoryActivity.text = listActivityFavorites[indexPath.row].typeActivity.name()
                cell.categoryActivity.textColor = listActivityFavorites[indexPath.row].typeActivity.color
                cell.categoryActivity.font = UIFont.boldSystemFont(ofSize: 12)
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
        nameForMore = "✔︎ Activités rejointes de \(myUser.pseudo)"
        listSelectedForMore = listActivityJoined
        performSegue(withIdentifier: "showMore", sender: self)
    }
    
    @IBAction func proposedShowMore(_ sender: Any) {
        nameForMore = "+ Activités proposées de \(myUser.pseudo)"
        listSelectedForMore = listActivityProposed
        performSegue(withIdentifier: "showMore", sender: self)
    }
    
    @IBAction func favoriteShowMore(_ sender: Any) {
        nameForMore = " ★ Activités favorites de \(myUser.pseudo)"
        listSelectedForMore = listActivityFavorites
        performSegue(withIdentifier: "showMore", sender: self)
    }
    
    
    
    @objc private func refreshOptions(sender: UIRefreshControl) {
        // Perform actions to refresh the content
        initProfilInformations()
        initListForCollections()
        manageView()
        // and then dismiss the control
        sender.endRefreshing()
    }
}

