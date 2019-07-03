//
//  EditProfileViewController.swift
//  TripHunters
//
//  Created by Simon Chevalier on 03/07/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit

class EditProfileViewController: UITableViewController, UINavigationBarDelegate{
    
    @IBOutlet weak var pseudoTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var myUser : User!
    var userAtStart : User!

    override func viewDidLoad() {
        super.viewDidLoad()
        initInformations()
        userAtStart = myUser
        // Do any additional setup after loading the view.
    }
    
    func initInformations(){
        pseudoTextField.text = myUser.pseudo
        lastNameTextField.text = myUser.lastName
        firstNameTextField.text = myUser.firstName
        emailTextField.text = myUser.email
    }
    
    func checkIfDifference() -> Bool{
        if (pseudoTextField.text != userAtStart.pseudo || lastNameTextField.text != userAtStart.lastName || firstNameTextField.text != userAtStart.firstName || emailTextField.text != userAtStart.email){
            return true
        }
        return false
    }
    
    func checkIfEmpty() -> Bool{
        if (pseudoTextField.text == "" || firstNameTextField.text == "" || lastNameTextField.text == "" || emailTextField.text == ""){
            return true
        }
        return false
    }
    
    func saveUserEdition(){
        myUser.pseudo = pseudoTextField.text!
        myUser.firstName = firstNameTextField.text!
        myUser.lastName = lastNameTextField.text!
        myUser.email = emailTextField.text!
    }
    
    @IBAction func validateEdition(_ sender: Any) {
        if (checkIfEmpty()){
            let alert = UIAlertController(title: "Edition Profil", message: "Vous n'avez pas rempli tous les champs nécessaires.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            if (checkIfDifference()){
                let alert = UIAlertController(title: "Edition Profil", message: "Vous êtes sur le point de modifier votre profil, confirmer ?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Confirmer", style: .default, handler: { action in
                    self.saveUserEdition()
                    self.navigationController?.popViewController(animated: true)
                }))
                alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
