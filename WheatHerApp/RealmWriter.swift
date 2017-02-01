//
//  RealmWriter.swift
//  WheatHerApp
//
//  Created by Student on 1/30/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


class RealmWriter {
    
    private static let realm = try! Realm()
    
    public static func writeUser(name: String, age: Int, clothingStyle: String) {
        try! realm.write() {
            let _ = realm.create(User.self, value: [name, age, clothingStyle])
        }
    }
}
