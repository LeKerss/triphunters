//
//  ShowActivityViewController.swift
//  TripHunters
//
//  Created by oscar Amzalag on 28/06/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit
import MapKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var commentImageUser: UIImageView!
    @IBOutlet weak var commentPeudo: UILabel!
    @IBOutlet weak var commentDate: UILabel!
    @IBOutlet weak var commentComment: UILabel!
    @IBOutlet weak var commentDeleteButton: UIButton!
    @IBOutlet weak var commentImageFlag: UIImageView!
    
}

class ShowActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, MKMapViewDelegate {
    

    @IBOutlet weak var imageActivity: UIImageView!
    @IBOutlet weak var nameActivity: UILabel!
    @IBOutlet weak var adressActivityLabel: UIButton!
    @IBOutlet weak var descriptionActivity: UILabel!
    @IBOutlet weak var favoriteText: UIButton!
    @IBOutlet weak var enterActivityButton: UIButton!
    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var typeActivity: UILabel!
    @IBOutlet weak var quitActivity: UIButton!
    @IBOutlet weak var suppdeleteActivity: UIButton!
    @IBOutlet weak var sentCommentButton: UIButton!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextNb: UIButton!
    @IBOutlet weak var labelNbImage: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    var currentUser = allUsers[0]
    
//    var currentActivity1 = Activity(idActivity: 1, idUser: 1, nameActivity: "Wall Street Pigalle", descriptionActivity: "Un Concept Bar Unique à Paris. \n\nÀ partir de 18h le Concept Bar Wall Street Pigalle à Paris se transforme en place boursière pour vous proposer un large portefeuille boursier composé de verres de vins, de pintes de bières et de nombreux cocktails. \n\n5 écrans géants vous permettent de suivre le cours des boissons en direct dont la tendance changera toutes les 100 secondes ! \n\nUn verre peut ainsi passer de 12 à 4 euros en quelques secondes et même subir une décote sans précédent lors d’un des nombreux krachs boursiers qui viendront pimenter chaque soirée.", typeActivity: typeActivityEnum.NightLife, adresse: "49 Boulevard de Clichy, 75009 Paris", country: "FranceTest", gpsx: 48.88315, gpsy: 2.333989, showActivity: true, imageDesc: [UIImage(named: "activityWallStreet1")!, UIImage(named: "activityWallStreet2")!])
//
//    var currentActivity = Activity(idActivity: 2, idUser: 2, nameActivity: "Le musée du Louvre", descriptionActivity: "Avec plus de 460.000 œuvres intemporelles de l’Antiquité à nos jours, le Musée du Louvre est l’un des plus grands musées d’art et d’histoire du monde. \n\nVous y découvrirez des œuvres mondialement connues, telles que La Joconde, La Vénus de Milo, le Radeau de la Méduse, La Liberté guidant le peuple, La mort de la Vierge, La Dentellière, Le Sacre de Napoléon, le Portrait de Louis XIV en costume de sacre, etc.", typeActivity: typeActivityEnum.Cultural, adresse: "99, rue de Rivoli, 75001 Paris", country: "FranceTest", gpsx: 48.864824, gpsy: 2.334595, showActivity: true, imageDesc: [UIImage(named: "louvre1")!, UIImage(named: "louvre2")!, UIImage(named: "louvre3")!, UIImage(named: "louvre4")!])
    
    var currentActivity : Activity!
    
    var commentOnActivity : [Comment] = []

    var currentImageNumber = 0
    
    var inFav = false
    var inInscirption = false

    @objc private func refreshOptions(sender: UIRefreshControl) {
        // Perform actions to refresh the content
        self.commentOnActivity = []
        for comment in allComments {
            if comment.idActivity == currentActivity.idActivity {
                commentOnActivity.append(comment)
            }
        }
        self.commentTextNb.setTitle("\(commentOnActivity.count) Commentaires", for: .normal)
        self.tableView.reloadData()

        inFav = false
        for fav in allFavories {
            if fav.idUser == currentUser.idUser && fav.idActivity == currentActivity.idActivity {
                inFav = true
            }
        }
        favoriteText.isSelected = inFav
        
        inInscirption = false
        for inscription in allInscription {
            if inscription.idUser == currentUser.idUser && inscription.idActivity == currentActivity.idActivity {
                inInscirption = true
                if (currentUser.idUser == currentActivity.idUser){
                    suppdeleteActivity.isHidden = false
                    enterActivityButton.isHidden = true
                    quitActivity.isHidden = true
                    
                }else{
                    if inInscirption == false {
                        enterActivityButton.isHidden = false
                        quitActivity.isHidden = true
                    }else{
                        enterActivityButton.isHidden = true
                        quitActivity.isHidden = false
                    }
                    suppdeleteActivity.isHidden = true
                }
            }
        }
        
        // and then dismiss the control
        sender.endRefreshing()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //scrollView.refreshControl = UIRefreshControl()
        
        
        if #available(iOS 10.0, *) {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self,
                                     action: #selector(refreshOptions(sender:)),
                                     for: .valueChanged)
            scrollView.refreshControl = refreshControl
        }
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        //favoriteText init
        
        for comment in allComments {
            if comment.idActivity == currentActivity.idActivity {
                commentOnActivity.append(comment)
            }
        }
        
        for fav in allFavories {
            if fav.idUser == currentUser.idUser && fav.idActivity == currentActivity.idActivity {
                inFav = true
            }
        }
        
        for inscription in allInscription {
            if inscription.idUser == currentUser.idUser && inscription.idActivity == currentActivity.idActivity {
                inInscirption = true
            }
        }
    
        favoriteText.setTitle("☆",for: .normal)
        favoriteText.setTitle("★",for: .selected)
        favoriteText.isSelected = inFav
        favoriteText.layer.cornerRadius = 25
        favoriteText.layer.shadowColor = UIColor.black.cgColor
        favoriteText.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        favoriteText.layer.masksToBounds = false
        favoriteText.layer.shadowRadius = 2.0
        favoriteText.layer.shadowOpacity = 0.5

        self.commentTextNb.setTitle("\(commentOnActivity.count) Commentaires", for: .normal)

        
        if (currentUser.idUser == currentActivity.idUser){
            suppdeleteActivity.isHidden = false
            enterActivityButton.isHidden = true
            quitActivity.isHidden = true

        }else{
            if inInscirption == false {
                enterActivityButton.isHidden = false
                quitActivity.isHidden = true
            }else{
                enterActivityButton.isHidden = true
                quitActivity.isHidden = false
            }
            suppdeleteActivity.isHidden = true
        }
       
        
        commentText.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: UIControl.Event.editingChanged)
        sentCommentButton.backgroundColor = UIColor.gray
        typeActivity.text = showTypeActivity(activity: currentActivity)
        typeActivity.textColor = currentActivity.typeActivity.color
        typeActivity.font = UIFont.boldSystemFont(ofSize: 15)
        enterActivityButton.layer.cornerRadius = 10
        quitActivity.layer.cornerRadius = 10
        suppdeleteActivity.layer.cornerRadius = 10
        sentCommentButton.layer.cornerRadius = 10
        imageActivity.image = currentActivity.imageDesc[currentImageNumber]
        nameActivity.text = currentActivity.nameActivity
        adressActivityLabel.setTitle("📍" + currentActivity.adresse, for: .normal)
        descriptionActivity.text = currentActivity.descriptionActivity

        
        //countryFlag
        countryFlag.image = UIImage(named: currentActivity.country)
        
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 6000
        self.tableView.allowsSelectionDuringEditing = false
        
        self.commentText.delegate = self as UITextFieldDelegate
        
        var xImage = 1
        labelNbImage.text = "🔵"
        while xImage < currentActivity.imageDesc.count {
            labelNbImage.text = labelNbImage.text! + "⚪️"
            xImage = xImage + 1
        }
        // Refresh control add in tableview.
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Signaler", style: .plain, target: self, action: #selector(self.report(sender:)))
        
       
        // show activity on map
        map.delegate = self
        let mapActivityPoint = MKPointAnnotation()
        mapActivityPoint.title = currentActivity.nameActivity
        mapActivityPoint.coordinate = CLLocationCoordinate2D(latitude: currentActivity.gpsx, longitude: currentActivity.gpsy)
        map.setRegion(MKCoordinateRegion(center: mapActivityPoint.coordinate, latitudinalMeters: 100, longitudinalMeters: 100), animated: false)

        map.addAnnotation(mapActivityPoint)
        
        
    }
    

    //mapView
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        annotationView.pinTintColor = currentActivity.typeActivity.color
                
        
        return annotationView
    }
    
    @objc func report(sender: UIBarButtonItem) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Signaler cette activité", message: self.currentActivity.nameActivity, preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Optionnel"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler:nil ))
        
        alert.addAction(UIAlertAction(title: "Envoyez", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            _ = Report(idActivity: self.currentActivity.idActivity, idUser: self.currentUser.idUser, dateReport: Date(), description: textField?.text ?? "")
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    

    
    @IBAction func favoriteAction(_ sender: Any) {

            var favExist = false
            var i = 0
            var favWillDeleteIndex = -1
            for fav in allFavories {
                if fav.idUser == self.currentUser.idUser && fav.idActivity == self.currentActivity.idActivity {
                    favExist = true
                    favWillDeleteIndex = i
                }
                i += 1
            }
            if favExist == false {
                let newFav = FavoritesActivity(idActivity: self.currentActivity.idActivity, idUser: self.currentUser.idUser, dateFav: Date())
                allFavories.append(newFav)
            }else{
                if favWillDeleteIndex > -1 {
                    allFavories.remove(at: favWillDeleteIndex)
                }
        }
            favoriteText.isSelected.toggle()
       
    }
    
    
    //showTypeActivity
    func showTypeActivity(activity: Activity) -> String {
        
        switch activity.typeActivity {
            
        case .Sports:
            return "Sport"
        case .Gastronomy:
            return "Gastronomie"
        case .NightLife:
            return "Night Life"
        case .Cultural:
            return "Culturel"
        case .Entertainement:
            return "Divertissement"
        case .Exploration:
            return "Exploration"
        case .Freaky:
            return "Insolite"
            
        }
    }
    @IBAction func changeImage(_ sender: Any) {
        //pas 2 fois le meme
        let i = currentActivity.imageDesc.count
        if currentImageNumber + 1 < i {
            let j = currentImageNumber
            currentImageNumber = j + 1
            imageActivity.image = currentActivity.imageDesc[currentImageNumber]
            
            //changement d'image
        }else{
            currentImageNumber = 0
            imageActivity.image = currentActivity.imageDesc[currentImageNumber]
        }
        var xImage = 0
        labelNbImage.text = ""
        while xImage < currentActivity.imageDesc.count {
            if currentImageNumber == xImage {
                labelNbImage.text = labelNbImage.text! + "🔵"
            }else{
                labelNbImage.text = labelNbImage.text! + "⚪️"
                
            }
            xImage = xImage + 1
        }
    }
    
    @IBAction func enterActivityAction(_ sender: Any) {
        let optionMenuEnterActivityAction = UIAlertController(title: nil, message: "Voulez vous ajouter cette activité à vos activités ?", preferredStyle: .actionSheet)
        let deleteActionEnterActivityAction = UIAlertAction(title: "Oui", style: .default, handler: { action in
            self.enterActivityButton.isHidden = true
            self.quitActivity.isHidden = false
            var inscriptionExist = false
            for inscription in allInscription {
                if inscription.idUser == self.currentUser.idUser && inscription.idActivity == self.currentActivity.idActivity {
                    inscriptionExist = true
                }
            }
            if inscriptionExist == false {
                let newInscription = InscriptionActivity(idActivity: self.currentActivity.idActivity, idUser: self.currentUser.idUser, dateInscription: Date())
                allInscription.append(newInscription)
            }
        })
        let cancelActionEnterActivityAction = UIAlertAction(title: "Annuler", style: .cancel)
        optionMenuEnterActivityAction.addAction(deleteActionEnterActivityAction)
        optionMenuEnterActivityAction.addAction(cancelActionEnterActivityAction)
        self.present(optionMenuEnterActivityAction, animated: true )
        
    }
    
    @IBAction func quitActivityAction(_ sender: Any) {
        let optionMenuQuitActivityAction = UIAlertController(title: nil, message: "Voulez vous supprimer cette activité de vos activités ?", preferredStyle: .actionSheet)
        let deleteActionQuitActivityAction = UIAlertAction(title: "Oui", style: .default, handler: { action in
            self.enterActivityButton.isHidden = false
            self.quitActivity.isHidden = true
            var i = 0
            for inscription in allInscription {
                if inscription.idUser == self.currentUser.idUser && inscription.idActivity == self.currentActivity.idActivity {
                    allInscription.remove(at: i)
                }
                i+=1
            }
        })
        let cancelActionQuitActivityAction = UIAlertAction(title: "Annuler", style: .cancel)
        optionMenuQuitActivityAction.addAction(deleteActionQuitActivityAction)
        optionMenuQuitActivityAction.addAction(cancelActionQuitActivityAction)
        self.present(optionMenuQuitActivityAction, animated: true )
    }
    
    @IBAction func suppDeleteActivityAction(_ sender: Any) {
        let optionMenuQuitActivityAction = UIAlertController(title: nil, message: "Voulez vous supprimer cette activité définitivement ?", preferredStyle: .actionSheet)
        let deleteActionQuitActivityAction = UIAlertAction(title: "Oui", style: .default, handler: { action in
            var i = 0
            for activity in allActivities {
                if activity.idUser == self.currentUser.idUser && activity.idActivity == self.currentActivity.idActivity {
                    allActivities.remove(at: i)
                }
                i+=1
            }
            
        })
        let cancelActionQuitActivityAction = UIAlertAction(title: "Annuler", style: .cancel)
        optionMenuQuitActivityAction.addAction(deleteActionQuitActivityAction)
        optionMenuQuitActivityAction.addAction(cancelActionQuitActivityAction)
        self.present(optionMenuQuitActivityAction, animated: true )
    }
    
    @IBAction func sentComment(_ sender: Any) {
        if commentText.text != ""{
            sentCommentButton.backgroundColor = UIColor.gray
            let comment = Comment(idActivity: currentActivity.idActivity, pseudo: currentUser.pseudo, country: currentUser.nationality, dateComment: Date(), comment: commentText.text!)
            commentOnActivity = [comment] + commentOnActivity
            commentText.text = ""
            
            allComments.insert(comment, at: 0)
            
            self.commentOnActivity = []
            for comment in allComments {
                if comment.idActivity == currentActivity.idActivity {
                    commentOnActivity.append(comment)
                }
            }
            
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            self.tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: UITableView.ScrollPosition.none)
            self.commentTextNb.setTitle("\(commentOnActivity.count) Commentaires", for: .normal)
            self.view.endEditing(true)
        }
    }
    
    @IBAction func textFieldEditingDidChange(_ sender: Any) {
        if commentText.text == ""{
             sentCommentButton.backgroundColor = UIColor.gray
        }else {
            sentCommentButton.backgroundColor = enterActivityButton.backgroundColor
        }
    }

    //tableView
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentOnActivity.count
    }
    
    
    
    @IBAction func openMaps(_ sender: Any) {
        
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentTableViewCell
      
        let dateFormateur       = DateFormatter()
        dateFormateur.dateStyle = .medium
        dateFormateur.timeStyle = .medium
        dateFormateur.locale    = Locale(identifier: "FR-fr")
        
        
        cell.commentPeudo?.text = commentOnActivity[indexPath.row].pseudo
        cell.commentDate?.text = dateFormateur.string(from: commentOnActivity[indexPath.row].dateComment)
        cell.commentComment?.text = commentOnActivity[indexPath.row].comment
        cell.commentImageUser?.image = UIImage(named: "IMG_default_user")
        cell.commentImageFlag?.image = UIImage(named: commentOnActivity[indexPath.row].country)
        if (cell.commentPeudo?.text == currentUser.pseudo) {
            cell.commentDeleteButton.isHidden = false
        }else{
            cell.commentDeleteButton.isHidden = true
        }
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if (commentOnActivity[indexPath.row].pseudo == currentUser.pseudo) {
            return true
        }else{
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            let optionMenu = UIAlertController(title: nil, message: "Voulez vous vraiment supprimer votre commentaire ?", preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "Oui", style: .default, handler: { action in
                if (editingStyle == .delete){
                    let remove = self.commentOnActivity[indexPath.row]
                    var i = 0
                    var indexx = -1
                    for comment in self.commentOnActivity {
                        if comment.comment == remove.comment && comment.idActivity == remove.idActivity && comment.pseudo == remove.pseudo {
                            indexx = i
                        }
                        i += 1
                    }
                    allComments.remove(at: indexx)
                    self.commentOnActivity = []
                    for comment in allComments {
                        if comment.idActivity == self.currentActivity.idActivity {
                            self.commentOnActivity.append(comment)
                        }
                    }
                    self.tableView.reloadData()
                    self.commentTextNb.setTitle("\(self.commentOnActivity.count) Commentaires", for: .normal)
                }
            })
            let cancelAction = UIAlertAction(title: "Annuler", style: .cancel)
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(cancelAction)
            self.present(optionMenu, animated: true )
        }
    }
    
    
    @IBAction func showAllComments(_ sender: Any) {
        performSegue(withIdentifier: "showComments", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as? ShowCommentsTableViewController
        destinationViewController?.commentOnActivity = commentOnActivity
    }
    
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    

    @IBAction func adressActivityGoMap(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Vous êtes sur le point d'être redirigé vers plans", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Continuer", style: .default, handler: { action in
            let x = self.currentActivity.gpsx
            let y = self.currentActivity.gpsy
            
            let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: x, longitude: y)))
            source.name = self.currentActivity.nameActivity
            
            
            MKMapItem.openMaps(with: [source], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        })
        let cancelAction = UIAlertAction(title: "Annuler", style: .cancel)
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true )
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height - 25)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    

//    override func viewWillAppear(_ animated: Bool) {
//        print("hello")
//        commentOnActivity = []
//        for comment in allComments {
//            if comment.idActivity == currentActivity.idActivity {
//                commentOnActivity.append(comment)
//            }
//        }
//
//        super.viewWillAppear(animated)
//
//    }


}
