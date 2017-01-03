//
//  JSONCustomParser.swift
//  WheatHerApp
//
//  Created by Student on 12/20/16.
//  Copyright © 2016 Student. All rights reserved.
//

import Foundation

final class JSONCustomPaser : PMappingDataJSONToModel {
    
    private init() {
        
    }
    
    //var this: JSONCustomPaser?
    private static var instance = JSONCustomPaser()

    
    static func getInstance() -> PMappingDataJSONToModel {
        return self.instance
    }
    
    
    
    static var rowJSON: Data?
    
    private(set) var parsedJSON : PAbstractModel?
    
    // Parse the incomming Json to coresponding Model 
    func parseJSONToObject(modelType: String) -> Void {
        switch (modelType) {
        case "WeatherModel":
            self.parsedJSON  = self.parseWhetherJSON()
        default:
            fatalError("Invalid model dependency.")
            
        }
    }
    
    




    private func parseWhetherJSON() -> PAbstractModel {
        var parsedJSON : Dictionary<String, Any>?
        do {
             parsedJSON = try JSONSerialization.jsonObject(with: JSONCustomPaser.rowJSON!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, AnyObject>
        }
        catch {
            fatalError("Invalid json input. ")
        }
        guard let unwrappedParsedJSON = parsedJSON else  {
            fatalError("Invalid JSON Structue.  ")
        }
        
        guard let jsonQuery = unwrappedParsedJSON["query"] as? Dictionary< String, AnyObject> else {
            fatalError("Invalid JSON Structue.  ")

        }
        guard let createdDate = jsonQuery["created"] as? String, let resultsRecieved = jsonQuery["results"] as? Dictionary<String, AnyObject> else {
            fatalError("Invalid JSON Structue.  ")
            
        }
        guard let results = resultsRecieved["channel"] as? Dictionary<String, AnyObject> else {
            fatalError("Invalid JSON Structue.  ")

        }
        guard let location = results["location"]!["city"] as? String,
            let wind = results["wind"]!["speed"] as? String,
            let atmosphere = results["atmosphere"]!["humidity"] as? String,
            let imageURL = results["image"]!["url"] as? String,
            let forecastJSON = results["item"]!["forecast"] as? Array<Dictionary<String, AnyObject>> else {
                fatalError("Wrong JSON Input")
        }
        let imageURLConverted = URL(string: imageURL)
        
        //forecastJSON = JSONSerialization.jsonObject(with)
            
        var forecast = [DailyWeatherModel?](repeating: nil, count: 7)
    
        
        for (index, _) in forecast.enumerated() {
            guard let day = forecastJSON[index]["day"] as? String, let date = forecastJSON[index]["date"] as? String, let minTemp = forecastJSON[index]["low"] as? String, let maxTemp = forecastJSON[index]["high"] as? String, let desc = forecastJSON[index]["text"] as? String else {
                fatalError("Cannot parse daily forecast. ")
            }
            forecast[index] = DailyWeatherModel(date: date, day: day, maxTemp: maxTemp, minTemp: minTemp, desc: desc)
    
        }
        
        return WeatherModel(title: "Forecast", created: createdDate,  location: location, wind: wind, atmosphere: atmosphere, imageURL: imageURLConverted!, forecast: forecast as! [DailyWeatherModel])
    
    }
}
