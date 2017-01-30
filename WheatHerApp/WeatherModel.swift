//
//  WeatherModel.swift
//  WheatHerApp
//
//  Created by Student on 12/27/16.
//  Copyright © 2016 Student. All rights reserved.
//

import Foundation

class WeatherModel : PAbstractModel {
    
    internal var title: String
    internal var created: String?
    internal var day: String?
    internal var date: String?
    private(set) var location: String
    private(set) var wind: String
    private(set) var atmosphere: String
    private(set) var imageURL: URL
    private(set) var forecast: [DailyWeatherModel]?
    private(set) var hourlyforecast: [WeatherModel]?
    private(set) var dailyforecast: [WeatherModel]?
    private(set) var prediction: String?
    private(set) var predictionExpectation: String?
    private(set) var nearestStormDistance: String?
    private(set) var apparentTemp: String?
    private(set) var visibility: String?
    private(set) var temp: String?





    
    
    init(title: String = "Forecast", created: String, location: String, wind: String, atmosphere: String, imageURL: URL, forecast: [DailyWeatherModel]?, prediction: String? = nil, predictionExpectation: String? = nil, nearestStormDistance: String? = nil, apparentTemp: String? = nil, visibility: String? = nil, dailyForecast: [WeatherModel]? = nil, haurlyForecast: [WeatherModel]? = nil, day : String? = nil, date: String? = nil, temp: String) {
        self.date = date
        self.day = day 
        self.title = title
        self.created = created
        self.wind = wind
        self.location = location
        self.imageURL = imageURL
        self.forecast = forecast
        self.atmosphere = atmosphere
        self.apparentTemp = apparentTemp
        self.prediction = prediction
        self.predictionExpectation = predictionExpectation
        self.nearestStormDistance = nearestStormDistance
        self.dailyforecast = dailyForecast
        self.hourlyforecast = haurlyForecast
        self.temp = temp
    }
    
}
