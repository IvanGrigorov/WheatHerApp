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
    internal var created: String
    private(set) var location: String
    private(set) var wind: String
    private(set) var atmosphere: String
    private(set) var imageURL: URL
    private(set) var forecast: [DailyWeatherModel]
    
    
    init(title: String, created: String, location: String, wind: String, atmosphere: String, imageURL: URL, forecast: [DailyWeatherModel]) {
        self.title = title
        self.created = created
        self.wind = wind
        self.location = location
        self.imageURL = imageURL
        self.forecast = forecast
        self.atmosphere = atmosphere
    }
    
}
