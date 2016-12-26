//
//  MappingDataJSONToModel.swift
//  WheatHerApp
//
//  Created by Student on 12/20/16.
//  Copyright © 2016 Student. All rights reserved.
//

import Foundation

protocol PMappingDataJSONToModel {
    

    var rowJSON : Data {get set}
    //var json : Array<AnyObject>? {get set}
    init()
    func parseJSONToObject(model: PAbstractModel) -> Void
}

extension PMappingDataJSONToModel {
    
    private var this: PMappingDataJSONToModel? {
        get {
            return self.this
        }
        set(newValue) {
            if (self.this == nil) {
                self.this = newValue
            }
        }
    }

    init(_ JSON: Data ) {
        self.init()
        self.rowJSON = JSON
    }
    
    public func getInstance() -> PMappingDataJSONToModel {
        return self.this!
    }
}
