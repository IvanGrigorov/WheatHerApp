//
//  JSONDeliverer.swift
//  WheatHerApp
//
//  Created by Student on 12/25/16.
//  Copyright © 2016 Student. All rights reserved.
//

import Foundation
import UIKit


 public   class JSONDeliverer {
    
    
    private static let URLRequestString  = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22sofia%2C%20bg%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
    
    static func  deliverJSONFromFile(filePath: String) -> Data  {
        guard let path = Bundle.main.path(forResource: filePath, ofType: "json") else {
            fatalError("Cannot read JSON fom file")
        }
        var json : NSData
        do {
            json = try NSData(contentsOfFile: path, options: .mappedIfSafe)
        }
        catch {
            fatalError("Cannot read JSON fom file")
        }

        return (json as Data)
    }
    

    // Currently not implemented
    static func deliverWebJSON() throws -> Data {
        let url = URL(string: URLRequestString)
        var result: Data?

        // We are using the web JSON in the first view 
        // That is why we are blocking the main thread until we recieve it 
        
        let semaphore = DispatchSemaphore(value: 0)
        
        // This is asynchroneous 
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error)   in
            guard let recieved = data else {
                return
            }
            result = recieved
            // Signal to unblock it
            semaphore.signal()
                
        }
        task.resume()
        
        // Blocking it
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        
        guard let returnedData =  result
            else {
               throw NetworkDataErrors.TroubleGettingData(errorMsg: "Cannot recieve Data")
        }
        return returnedData
    }
}
