//
//  UserDataController.swift
//  WheatHerApp
//
//  Created by Student on 1/28/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import UIKit

class UserDataController : ViewController
{
    @IBOutlet weak var userInfo: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var clothingStyle: UITextField!
    
    @IBAction func getText () {
        
        var nameText = name.text
        var agetext = age.text
        var clothingStyleText = clothingStyle.text
        
        
    }
    
}
