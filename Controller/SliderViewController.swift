//
//  SliderViewController.swift
//  TripHunters
//
//  Created by Annas Saker on 01/07/2019.
//  Copyright © 2019 oscar Amzalag. All rights reserved.
//

import UIKit

struct FilterStruct {
    var type: ActivityType
    var filter: UIView
}

class SliderViewController: UIViewController {

    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var handleLine: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sportsFilter: UIView!
    
    @IBOutlet weak var explorationFilter: UIView!
    
    @IBOutlet weak var cultureFilter: UIView!
    
    @IBOutlet weak var nightFilter: UIView!
    
    @IBOutlet weak var gastronomyFilter: UIView!
    @IBOutlet weak var entertainementFilter: UIView!
    @IBOutlet weak var freakyFilter: UIView!
    
    var filters = [FilterStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleLine.layer.cornerRadius = 3
        // Do any additional setup after loading the view.
        initFilters()
    }
    
    func initFilters() {
        self.filters = [
            FilterStruct(type: .Sports, filter: sportsFilter),
        FilterStruct(type: .Cultural, filter: cultureFilter),
        FilterStruct(type: .Entertainement, filter: entertainementFilter),
        FilterStruct(type: .Exploration, filter: explorationFilter),
        FilterStruct(type: .Freaky, filter: freakyFilter),
        FilterStruct(type: .Gastronomy, filter: gastronomyFilter),
        FilterStruct(type: .NightLife, filter: nightFilter)]
    
        for f in filters {
        f.filter.layer.cornerRadius = 25
            f.filter.layer.backgroundColor = f.type.color.cgColor
        }
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
