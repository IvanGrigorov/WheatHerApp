//
//  RealmReader.swift
//  WheatHerApp
//
//  Created by Student on 2/3/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import RealmSwift

class RealmReader {
    

    static let realm = try! Realm()
    
    static func readUser() -> User? {
        let user = realm.objects(User.self).first
        return user
    }
}
