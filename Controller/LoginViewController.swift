
//
//  ViewController.swift
//  TripHunters
//
//  Created by oscar Amzalag on 28/06/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var mdpTextfield: UITextField!
    @IBOutlet weak var pseudoTextfield: UITextField!
    @IBAction func retourToLoginViewController(_ segue: UIStoryboardSegue) {
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        pseudoTextfield.resignFirstResponder()
        mdpTextfield.resignFirstResponder()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func forgetPswword(_ sender: Any) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Reinitialisation du mot de passe", message: "veuillez renseigner votre email", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "email"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler:nil ))
        
        alert.addAction(UIAlertAction(title: "Envoyez", style: .default, handler: nil))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
}

