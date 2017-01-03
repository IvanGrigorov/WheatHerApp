//
//  MappingDataJSONToModel.swift
//  WheatHerApp
//
//  Created by Student on 12/20/16.
//  Copyright © 2016 Student. All rights reserved.
//

import Foundation

protocol PMappingDataJSONToModel {
    

    static var rowJSON : Data? {get set}
    //var json : Array<AnyObject>? {get set}
    //init()
    func parseJSONToObject(modelType: String ) -> Void
    static func getInstance() -> PMappingDataJSONToModel
}
