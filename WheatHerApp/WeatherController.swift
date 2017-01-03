//
//  WeatherController.swift
//  WheatHerApp
//
//  Created by Student on 1/2/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation

class WeatherController :  ViewController
{
   
    override func viewWillAppear(_ animated: Bool) {
        let jsonParser = JSONCustomPaser.getInstance()
        JSONCustomPaser.rowJSON = JSONDeliverer.deliverJSONFromFile(filePath: "WhetherData")
        jsonParser.parseJSONToObject(modelType: "WeatherModel")
        //var test = "OK"
        
    }
    
}
