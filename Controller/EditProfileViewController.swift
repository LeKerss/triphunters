//
//  EditProfileViewController.swift
//  TripHunters
//
//  Created by Simon Chevalier on 03/07/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit

class EditProfileViewController: UITableViewController{
    
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
    
    @IBAction func validateEdition(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
