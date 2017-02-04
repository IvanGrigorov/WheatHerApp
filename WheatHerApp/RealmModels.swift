//
//  RealmModels.swift
//  WheatHerApp
//
//  Created by Student on 1/30/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class User: Object {
    
    var name: String? = nil
    var age   = 0
    var clothingStyle: String? = nil
    
}
