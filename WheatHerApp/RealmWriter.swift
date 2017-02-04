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
    
    static let realm = try! Realm()
    
    public static func writeUser(name: String, age: Int, clothingStyle: String) {
        try! realm.write() {
            let user = User(value: ["name": name, "age": age, "clothingStyle": clothingStyle])
            realm.add(user)
        }
    }
}
