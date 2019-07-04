//
//  ShowCommentsTableViewController.swift
//  TripHunters
//
//  Created by oscar Amzalag on 02/07/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit

class allCommentTableViewCell: UITableViewCell {
    @IBOutlet weak var commentImageUser_: UIImageView!
    @IBOutlet weak var commentPseudo_: UILabel!
    @IBOutlet weak var commentDate_: UILabel!
    @IBOutlet weak var commentComment_: UILabel!
    @IBOutlet weak var commentDeleteButton_: UIButton!
    @IBOutlet weak var commentImageFlag_: UIImageView!
}

class ShowCommentsTableViewController: UITableViewController {
    
    
    
    var commentOnActivity : [Comment]!
    
    var currentUser = User(idUser: 1, pseudo: "TripCodeur", firstName: "Trip", lastName: "Hunters", description: nil, email: "triphunters@hotmail.com", password: "password", nationality: "FranceTest", imageProfil: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    
        navigationItem.title = "\(commentOnActivity.count) Commentaires"
    }

    @IBAction func goProfilPseudo(_ sender: Any) {
        var superview = (sender as AnyObject).superview
        while let view = superview, !(view is UITableViewCell) {
            superview = view?.superview
        }
        guard let cell = superview as? UITableViewCell else {
            let optionMenu = UIAlertController(title: nil, message: "button is not contained in a table view cell", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Annuler", style: .cancel)
            optionMenu.addAction(cancelAction)
            self.present(optionMenu, animated: true )
            return
        }
        guard let indexPath = tableView.indexPath(for: cell) else {
            let optionMenu = UIAlertController(title: nil, message: "button is not contained in a table view cell", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Annuler", style: .cancel)
            optionMenu.addAction(cancelAction)
            self.present(optionMenu, animated: true )
            print("failed to get index path for cell containing button")
            return
        }
        // We've got the index path for the cell that contains the button, now do something with it.
        let optionMenu = UIAlertController(title: nil, message: commentOnActivity[indexPath.row].pseudo, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Annuler", style: .cancel)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true )
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return commentOnActivity.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "allcommentCell", for: indexPath) as! allCommentTableViewCell
        
        let dateFormateur       = DateFormatter()
        dateFormateur.dateStyle = .medium
        dateFormateur.timeStyle = .medium
        dateFormateur.locale    = Locale(identifier: "FR-fr")
        
        
        cell.commentPseudo_?.text = commentOnActivity[indexPath.row].pseudo
        cell.commentDate_?.text = dateFormateur.string(from: commentOnActivity[indexPath.row].dateComment)
        cell.commentComment_?.text = commentOnActivity[indexPath.row].comment
        cell.commentImageUser_?.image = UIImage(named: "IMG_default_user")
        cell.commentImageFlag_?.image = UIImage(named: commentOnActivity[indexPath.row].country)
        if (cell.commentPseudo_?.text == currentUser.pseudo) {
            cell.commentDeleteButton_.isHidden = false
        }else{
            cell.commentDeleteButton_.isHidden = true
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if (commentOnActivity[indexPath.row].pseudo == currentUser.pseudo) {
            return true
        }else{
            return false
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            let optionMenu = UIAlertController(title: nil, message: "Voulez vous vraiment supprimer votre commentaire ?", preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "Oui", style: .default, handler: { action in
                if (editingStyle == .delete){
                    let remove = self.commentOnActivity[indexPath.row]
                    self.commentOnActivity.remove(at: indexPath.row)
                    var i = 0
                    var indexx = -1
                    for comment in allComments {
                        if comment.comment == remove.comment && comment.idActivity == remove.idActivity && comment.pseudo == remove.pseudo {
                            indexx = i
                        }
                        i += 1
                    }
                    allComments.remove(at: indexx)
                    self.tableView.reloadData()
                    self.navigationItem.title = "\(self.commentOnActivity.count) Commentaires"
                }
            })
            let cancelAction = UIAlertAction(title: "Annuler", style: .cancel)
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(cancelAction)
            self.present(optionMenu, animated: true )
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
