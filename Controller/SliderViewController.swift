//
//  SliderViewController.swift
//  TripHunters
//
//  Created by Annas Saker on 01/07/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController {

    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var handleLine: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        handleLine.layer.cornerRadius = 3
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
