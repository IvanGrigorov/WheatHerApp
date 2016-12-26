//
//  JSONCustomParser.swift
//  WheatHerApp
//
//  Created by Student on 12/20/16.
//  Copyright © 2016 Student. All rights reserved.
//

import Foundation

public final class JSONCustomPaser : PMappingDataJSONToModel {
    
    var rowJSON: Data {
        get {
            return self.rowJSON
        }
        set(newValue) {
            self.rowJSON = newValue
        }
    }
    
    // Parse the incomming Json to coresponding Model 
    func parseJSONToObject(model: PAbstractModel) -> Void {
        switch (model) {
        case (model is WeatherModel):
            self.parseWhetherJSON(model: model)
        default:
            fatalError("Invalid model dependency.")
            
        }
    }
    
    




    private func parseWhetherJSON(model: PAbstractModel) -> Void {
        var parsedJSON : Dictionary<String, Any>?
        do {
             parsedJSON = try JSONSerialization.jsonObject(with: self.rowJSON, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
        }
        catch {
            fatalError("Invalid json input. ")
        }
        guard parsedJSON != nil else  {
            fatalError("Invalid JSON Structue.  ")
        }
    
    }
}
