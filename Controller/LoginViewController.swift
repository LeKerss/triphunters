
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


}

