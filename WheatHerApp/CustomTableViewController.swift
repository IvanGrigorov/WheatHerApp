//
//  CustomTableView.swift
//  WheatHerApp
//
//  Created by Student on 1/3/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import UIKit

class CustomTableViewController : UITableViewController {
    
    var viewData: WeatherModel? {
        didSet {
            self.customDate = viewData!.date
            self.customDay = viewData!.day
            self.customDescription = viewData!.prediction
            self.customMaxTemp = viewData!.temp
            self.customMinTemp = viewData!.apparentTemp

        }
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        guard let data = viewData else {
            return
        }
        
        self.customDate = data.date
        self.customDay = data.day
        self.customDescription = data.prediction
        self.customMaxTemp = data.temp
        self.customMinTemp = data.apparentTemp
    

    }
    
    @IBOutlet weak var Date: UILabel!
    
    var customDate : String? {
        didSet {
            self.Date.text = self.customDate
        }
    }
    
    @IBOutlet weak var Day: UILabel!
    
    var customDay : String? {
        didSet {
            self.Day.text = self.customDay
        }
    }
    
    @IBOutlet weak var MaxTemp: UILabel!
    
    var customMaxTemp : String? {
    didSet {
    self.MaxTemp.text = self.customMaxTemp! + " C\u{00B0}"
        }
    }
    
    @IBOutlet weak var MinTemop: UILabel!
    
    var customMinTemp : String? {
    didSet {
    self.MinTemop.text = self.customMinTemp! + " C\u{00B0}"
        }
    }
    @IBOutlet weak var Description: UILabel!
    
    var customDescription : String? {
    didSet {
    self.Description.text = self.customDescription
        self.Description.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.Description.numberOfLines = 0
        
    }
    }
}
