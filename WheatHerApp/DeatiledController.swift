//
//  CustomTableView.swift
//  WheatHerApp
//
//  Created by Student on 1/3/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import UIKit

class DetailedController : UITableViewController {
    
    var viewData: WeatherModel? {
        didSet {
            self.customWind = viewData!.wind
            self.customAtmosphere = viewData!.atmosphere
            
        }
    }
    
 
    
    @IBOutlet weak var Wind: UILabel!
    
    var customWind : String? {
        didSet {
            self.Wind.text = self.customWind
        }
    }
    
    @IBOutlet weak var Atmsphere: UILabel!
    
    var customAtmosphere : String? {
        didSet {
            self.Atmsphere.text = self.customAtmosphere
        }
    }
    

    
  
}
