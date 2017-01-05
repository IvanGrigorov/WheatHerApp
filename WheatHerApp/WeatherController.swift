//
//  WeatherController.swift
//  WheatHerApp
//
//  Created by Student on 1/2/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import UIKit

class WeatherController :  ViewController
{
    var dailyWeather : [DailyWeatherModel]?
    var weather : WeatherModel?
        @IBOutlet weak var frontImageView: UIImageView!
        
        var image : URL? {
            didSet {
                do {
                    self.frontImageView.image = try UIImage(data: Data(contentsOf : image!))
                    //self.frontImageView.startAnimating()
                }
                catch  {
                    fatalError("Wrong Image URL")
                }
            }
        }
        
        
        @IBOutlet weak var Atmosphere: UILabel!
        
        var customAtmosphere : String? {
            didSet {
                self.Atmosphere.text = self.customAtmosphere! + " %(Humidity)"
            }
        }
        
        @IBOutlet weak var Wind: UILabel!
        
        var customWind: String? {
            didSet {
                self.Wind.text = self.customWind! + " km/h"
            }
        }
        
        
        @IBOutlet weak var Location: UILabel!
        
        var customLocation: String? {
            didSet {
                self.Location.text = self.customLocation
            }
        }

    @IBOutlet weak var embeddedView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var jsonParser = JSONCustomPaser.getInstance()
        jsonParser.rowJSON = JSONDeliverer.deliverJSONFromFile(filePath: "WhetherData")
        jsonParser.parseJSONToObject(modelType: "WeatherModel")
        
    
        self.customAtmosphere = self.weather!.atmosphere
        self.customLocation = self.weather!.location
        self.customWind = self.weather!.wind
        self.image = self.weather!.imageURL

        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.prepareDataForView()
        switch(segue.identifier!) {
            case "table":
                let destiantion = segue.destination as! CustomTableViewController
                let destinationTitle = self.title!
            destiantion.viewData = self.dailyWeather![Int(destinationTitle)! - 1]
            default: return
        }
    }
    
    private func prepareDataForView() {
        var jsonParser = JSONCustomPaser.getInstance()
        jsonParser.rowJSON = JSONDeliverer.deliverJSONFromFile(filePath: "WhetherData")
        jsonParser.parseJSONToObject(modelType: "WeatherModel")
        self.weather = jsonParser.parsedJSON as? WeatherModel
        self.dailyWeather  = self.weather!.forecast

    }
    
}
