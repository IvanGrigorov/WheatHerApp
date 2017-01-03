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
    private var location: String
    private var wind: String
    private var atmosphere: String
    private var imageURL: URL
    private var forecast: [DailyWeatherModel]
    
    
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
