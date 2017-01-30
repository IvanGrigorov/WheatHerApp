//
//  WeatherController.swift
//  WheatHerApp
//
//  Created by Student on 1/2/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class WeatherController :  ViewController, CLLocationManagerDelegate
{
    public static var locationManager = CLLocationManager()

    private var embedController : CustomTableViewController?
    private var destination : String?

    var dailyWeather : [WeatherModel]?
    var weather : WeatherModel?
        @IBOutlet weak var frontImageView: UIImageView!
        
        var image : URL? {
            didSet {
                self.frontImageView.image =  UIImage(named: String(describing: image!))

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

    @IBAction func DetailsAction(_ sender: UIButton) {
        // Navigate to details view
    }
    @IBOutlet weak var embeddedView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layer.contents = UIImage(named: BackgroundManager.returnNameOfBackgroundForDateTime())!.cgImage
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
            

        }

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.prepareDataForView()
        self.embedController!.viewData = self.dailyWeather![Int(self.destination!)! - 1]

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        WeatherController.locationManager = CLLocationManager()

        WeatherController.locationManager.delegate = self

        WeatherController.locationManager.requestAlwaysAuthorization()

        switch(segue.identifier!) {
            case "table":
                let destiantionController = segue.destination as! CustomTableViewController
                self.destination = self.title!
                self.embedController = destiantionController
            default: super.prepare(for: segue, sender: sender)
        }
    }
    
    private func prepareDataForView() {
        self.starstDeliveringJSON()
        var jsonParser = JSONCustomPaser.getInstance()
        jsonParser.parseJSONToObject(modelType: "WeatherModel")
        self.weather = jsonParser.parsedJSON as? WeatherModel
        self.dailyWeather  = self.weather!.dailyforecast!
        self.customAtmosphere = self.weather!.atmosphere
        self.customLocation = self.weather!.location
        self.customWind = self.weather!.wind
        self.image = self.weather!.imageURL

        

    }
    
    private func starstDeliveringJSON() {
        if CachedManager.getInstance().toCacheOrNotToCacheDelivery() {
            return
        }
        var jsonParser = JSONCustomPaser.getInstance()
        do {
            if CachedManager.getInstance().isInitialLaunch {
                try jsonParser.rowJSON = JSONDeliverer.deliverWebJSON()
            }
        
            else {
                try JSONDeliverer.deliverWebJSONAsync(parser: jsonParser)
                return
            }
        }
        catch NetworkDataErrors.TroubleGettingData(let message) {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        catch {
            fatalError("Unexpected Error")
        }
    }
    
}
