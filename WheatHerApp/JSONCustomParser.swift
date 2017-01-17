//
//  JSONCustomParser.swift
//  WheatHerApp
//
//  Created by Student on 12/20/16.
//  Copyright © 2016 Student. All rights reserved.
//

import Foundation

final class JSONCustomPaser : PMappingDataJSONToModel {
    


    private var timer = Timer()
    
    private init() {
        
    }
    
    //var this: JSONCustomPaser?
    private static var instance = JSONCustomPaser()

    
    static func getInstance() -> PMappingDataJSONToModel {
        return self.instance
    }
    
    var cachedModel: PAbstractModel?
    
    var rowJSON: Data?
    
    var parsedJSON : PAbstractModel?
    
    // Parse the incomming Json to coresponding Model 
    func parseJSONToObject(modelType: String) -> Void {
        //guard self.rowJSON != nil else {
            // Tha Data is still not downloaded async
            //self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: "timerAction", userInfo: ["delivered": self.rowJSON, "modelType": modelType]  , //repeats: true)
        //    parseJSONToObject(modelType: modelType)
        //    return
        //}
        switch (modelType) {
        case "WeatherModel":
            self.parsedJSON  = self.parseWhetherJSON()
        default:
            fatalError("Invalid model dependency.")
            
        }
    }
//    private func timerAction(timer: Timer) {
//        let data = timer.userInfo as? Dictionary<String, AnyObject>
//        guard data != nil else {
//            timer.invalidate()
//            return
//        }
//        parseJSONToObject(modelType: data!["modelType"] as! String)
//
//    }
    
    




    private func parseWhetherJSON() -> WeatherModel? {
        if CachedManager.getInstance().toCacheOrNotToCache() {
            return self.cachedModel! as? WeatherModel
        }
        guard self.rowJSON != nil else {
            return nil
        }
        var tmpParsedJSON : Dictionary<String, Any>?
        do {
             tmpParsedJSON = try JSONSerialization.jsonObject(with: self.rowJSON!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, AnyObject>
        }
        catch {
            fatalError("Invalid json input. ")
        }
        guard let unwrappedParsedJSON = tmpParsedJSON else  {
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
        
        let updatedImageUrl = imageURL.replacingOccurrences(of: "http", with: "https")
        var imageURLConverted = URL(string: updatedImageUrl)
        // Reolacing because currently there is no such image 

        imageURLConverted = URL(string: "https://media.giphy.com/media/6R3boOvvH0IMw/giphy.gif")
        //forecastJSON = JSONSerialization.jsonObject(with)
            
        var forecast = [DailyWeatherModel?](repeating: nil, count: 7)
    
        
        for (index, _) in forecast.enumerated() {
            guard let day = forecastJSON[index]["day"] as? String, let date = forecastJSON[index]["date"] as? String, let minTemp = forecastJSON[index]["low"] as? String, let maxTemp = forecastJSON[index]["high"] as? String, let desc = forecastJSON[index]["text"] as? String else {
                fatalError("Cannot parse daily forecast. ")
            }
            forecast[index] = DailyWeatherModel(date: date, day: day, maxTemp: maxTemp, minTemp: minTemp, desc: desc)
    
        }
        
        let wheather = WeatherModel(title: "Forecast", created: createdDate,  location: location, wind: wind, atmosphere: atmosphere, imageURL: imageURLConverted!, forecast: forecast as! [DailyWeatherModel])
        self.cachedModel = wheather
        return wheather
    }
}
