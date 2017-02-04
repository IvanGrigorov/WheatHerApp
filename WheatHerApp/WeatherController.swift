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
    private var embedTipController : TipViewController?

    
    private var destination : String?
    private var initialHeight = 0.0
    
    private var initialWidth = 0.0
    private var isEnlrged = false
    private var initialPositionX : Double = 0.0   {
        didSet {
            if oldValue != 0.0 {
                initialPositionX = oldValue
            }
        }
    }

    private var initialPositionY : Double = 0.0  {
        didSet {
            if oldValue != 0.0 {
                initialPositionY = oldValue
            }
        }
    }



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
        guard let tipView = self.TipView else {
            return
        }
        self.initialHeight = Double(tipView.frame.height)
        self.initialWidth = Double(tipView.frame.width)
        self.initialPositionX = Double(tipView.frame.origin.x)
        self.initialPositionY = Double(tipView.frame.origin.y)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.animateinStart(sender:)))
        tipView.addGestureRecognizer(gesture)

    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
            

        }

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.prepareDataForView()
        self.embedController!.viewData = self.dailyWeather![Int(self.destination!)! - 1]
        guard let embeded = self.embedTipController else {
            return
        }
        embeded.viewData = self.weather

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
            case "tipSegue":
                let destiantionController = segue.destination as! TipViewController
                self.embedTipController = destiantionController

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
    
    @IBOutlet weak var TipView: UIView!
    


    
    @objc private func animateinStart( sender: UITapGestureRecognizer) {
        if self.isEnlrged {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
                
                self.TipView.frame = CGRect(x: self.initialPositionX - Double(self.TipView.constraintsAffectingLayout(for: UILayoutConstraintAxis.horizontal)[1].constant), y:  self.initialPositionY - Double(self.TipView.constraintsAffectingLayout(for: UILayoutConstraintAxis.vertical)[0].constant), width: self.initialWidth, height: self.initialHeight)
            }, completion : nil)
            self.embedTipController?.DetailTip.isHidden = true
            self.embedTipController?.Tip.isHidden = true
            self.embedTipController?.Header.isHidden = true

            

            self.isEnlrged = false
        }
        else {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
                
                let screenview = UIScreen.main.bounds
                let hightToExpand = screenview.height - self.TipView.frame.height
                let widthToExpand = screenview.width - self.TipView.frame.width
                
                self.TipView.frame = CGRect(x: 0.0, y:  0.0, width:  Double(self.TipView.frame.width + widthToExpand), height: Double(self.TipView.frame.height  + hightToExpand))
            }, completion : nil)
            self.embedTipController?.DetailTip.isHidden =  false
            self.embedTipController?.Tip.isHidden = false
            self.embedTipController?.Header.isHidden = false
            self.isEnlrged = true
        }
    }
    
    
    
}
