//
//  DailyWeatherModel .swift
//  WheatHerApp
//
//  Created by Student on 12/28/16.
//  Copyright © 2016 Student. All rights reserved.
//

import Foundation

class DailyWeatherModel  {
    
    private(set) var date : String
    private(set) var day : String
    private(set) var maxTemp : String
    private(set)  var   minTemp : String
    private(set) var desc : String
    
    init (date: String, day: String, maxTemp: String, minTemp: String, desc: String ) {
        self.date = date
        self.day = day
        self.desc = desc
        self.maxTemp = maxTemp
        self.minTemp = minTemp
    }
}
