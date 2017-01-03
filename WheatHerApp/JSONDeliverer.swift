//
//  JSONDeliverer.swift
//  WheatHerApp
//
//  Created by Student on 12/25/16.
//  Copyright © 2016 Student. All rights reserved.
//

import Foundation


 public   class JSONDeliverer {
    
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
    static func deliverWebJSON() -> Data {
        // Code
        return Data()
    }
}
