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
    
    var viewData: DailyWeatherModel? = nil

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        guard let data = viewData else {
            fatalError("Data for daily forecast is not provided")
        }
        
        self.customDate = data.date
        self.customDay = data.day
        self.customDescription = data.desc
        self.customMaxTemp = data.maxTemp
        self.customMinTemp = data.minTemp
    

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
    self.MaxTemp.text = self.customMaxTemp! + " F"
        }
    }
    
    @IBOutlet weak var MinTemop: UILabel!
    
    var customMinTemp : String? {
    didSet {
    self.MinTemop.text = self.customMinTemp! + " F"
        }
    }
    @IBOutlet weak var Description: UILabel!
    
    var customDescription : String? {
    didSet {
    self.Description.text = self.customDescription
    }
    }
}
