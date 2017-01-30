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
            self.parsedJSON  = self.parseDetailedWhetherJSON()
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
        
        let wheather = WeatherModel(title: "Forecast", created: createdDate,  location: location, wind: wind, atmosphere: atmosphere, imageURL: imageURLConverted!, forecast: forecast as? [DailyWeatherModel], temp: "40")
        self.cachedModel = wheather
        return wheather
    }
    
    private func parseDetailedWhetherJSON() -> WeatherModel? {
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
        guard let currently = unwrappedParsedJSON["currently"] as? Dictionary<String, AnyObject> else {
            fatalError()
        }
        guard let desc = currently["summary"] as? String,
            let icon = currently["icon"] as? String,
            let temp = currently["temperature"] as? Double  ,
            let apparentTemp = currently["apparentTemperature"] as? Double,
            let humidity = currently["humidity"] as? Double,
            let windSpeed = currently["windSpeed"] as? Double,
            let visibility = currently["visibility"] as? Double,
            let predictionExpectation = currently["precipProbability"] as? Double,
            let time = currently["time"] as? Int else {
                fatalError()
        }
        guard let hourly = ((unwrappedParsedJSON["hourly"] as AnyObject) ["data"])! as? Array<Dictionary<String, AnyObject>> else {
            fatalError()
        }
        var hourlyForecast = Array<WeatherModel>()
        
        guard let daily = ((unwrappedParsedJSON["daily"] as AnyObject) ["data"])! as? Array<Dictionary<String, AnyObject>> else {
            fatalError()
        }
        var dailyForecast = Array<WeatherModel>()

        for forecast in hourly {
            let time = forecast["time"] as? Int
            let date = Date(timeIntervalSince1970: TimeInterval(time!))
            let dateAsYearTimeFormatter = DateFormatter()
            dateAsYearTimeFormatter.dateFormat = "dd MM YY"
            let dateAsDayTimeFormatter = DateFormatter()
            dateAsDayTimeFormatter.dateFormat = "EEE"

            hourlyForecast.append(WeatherModel(
                created: "now", location: "Sofia",
                wind: String(forecast["windSpeed"] as! Double),
                atmosphere: String(forecast["humidity"] as! Double),
                imageURL: URL(string: forecast["icon"] as! String)!,
                forecast: nil,
                prediction: String(forecast["summary"] as! String),
                predictionExpectation: String(forecast["precipProbability"]  as! Double),
                apparentTemp: String(forecast["apparentTemperature"] as! Double),
                day: dateAsDayTimeFormatter.string(from: date),
                date: dateAsYearTimeFormatter.string(from: date),
                temp: String(forecast["temperature"] as! Double)))
        }
        
        for forecast in daily {
            let time = forecast["time"] as? Int
            let date = Date(timeIntervalSince1970: TimeInterval(time!))
            let dateAsYearTimeFormatter = DateFormatter()
            dateAsYearTimeFormatter.dateFormat = "dd MM YY"
            let dateAsDayTimeFormatter = DateFormatter()
            dateAsDayTimeFormatter.dateFormat = "EEE"

            dailyForecast.append(WeatherModel(
                created: "now", location: "Sofia",
                wind: String(forecast["windSpeed"] as! Double),
                atmosphere: String(forecast["humidity"] as! Double),
                imageURL: URL(string: forecast["icon"] as! String)!,
                forecast: nil,
                prediction: String(forecast["summary"] as! String),
                predictionExpectation: String(forecast["precipProbability"]  as! Double),
                apparentTemp: String(forecast["apparentTemperatureMax"] as! Double),
                day: dateAsDayTimeFormatter.string(from: date),
                date: dateAsYearTimeFormatter.string(from: date),
                temp: String(forecast["apparentTemperatureMin"] as! Double)))
        }
        
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateAsYearTimeFormatter = DateFormatter()
        dateAsYearTimeFormatter.dateFormat = "dd MM YY"
        let dateAsDayTimeFormatter = DateFormatter()
        dateAsYearTimeFormatter.dateFormat = "EEE"


        let weather =  WeatherModel(
            created: "now", location: "Sofia", wind: String(windSpeed), atmosphere: String(humidity), imageURL: URL(string: icon)!, forecast: nil , prediction: desc, predictionExpectation: String(predictionExpectation), nearestStormDistance: nil, apparentTemp: String(apparentTemp), visibility: String(visibility),
                dailyForecast: dailyForecast,
                haurlyForecast: hourlyForecast,

                day: dateAsDayTimeFormatter.string(from: date),
                date: dateAsYearTimeFormatter.string(from: date),
                temp: String(temp))

        self.cachedModel = weather
        return weather

    }
}
