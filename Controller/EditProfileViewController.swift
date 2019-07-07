//
//  EditProfileViewController.swift
//  TripHunters
//
//  Created by Simon Chevalier on 03/07/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit

class EditProfileViewController: UITableViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var pseudoTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!

    
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
        if let image = myUser.imageProfil{
            imgProfile.maskCircle(anyImage: image)
        }
    }
    
    private func pickAnImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func checkIfDifference() -> Bool{
        if (pseudoTextField.text != userAtStart.pseudo || lastNameTextField.text != userAtStart.lastName || firstNameTextField.text != userAtStart.firstName || emailTextField.text != userAtStart.email || imgProfile.image != userAtStart.imageProfil){
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
        var i = 0
        var isEdited : Bool = false
        while (i < allUsers.count || isEdited == false){
            if (allUsers[i].idUser == myUser.idUser){
                allUsers[i].pseudo = pseudoTextField.text!
                allUsers[i].firstName = firstNameTextField.text!
                allUsers[i].lastName = lastNameTextField.text!
                allUsers[i].email = emailTextField.text!
                allUsers[i].imageProfil = imgProfile.image
                isEdited = true
            }
            i += 1
        }
    }
    
    @IBAction func addImage(_ sender: Any) {
        pickAnImage()
    }
    
    @IBAction func backToProfile(_ sender: Any) {
        if (checkIfDifference()){
            let alert = UIAlertController(title: "Edition Profil", message: "Vous avez modifié des informations. \n Souhaitez vous annuler vos modifications ?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Oui", style: .default, handler: { action in
                self.navigationController?.popViewController(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Non", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func validateEdition(_ sender: Any) {
        if (checkIfEmpty()){
            let alert = UIAlertController(title: "Edition Profil", message: "Vous n'avez pas rempli tous les champs nécessaires.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
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


extension EditProfileViewController: UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgProfile.maskCircle(anyImage: image)
        }
        dismiss(animated: true, completion: nil)
    }
}
