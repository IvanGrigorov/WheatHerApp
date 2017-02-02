//
//  UserInformationController.swift
//  WheatHerApp
//
//  Created by Student on 1/30/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import UIKit

class UserController: ViewController
{
    @IBAction func submitData(_ sender: UIButton) {
        RealmWriter.writeUser(name: nameText.text!, age: Int(ageText.text!)!, clothingStyle: clothingStyleText.text!)
    }
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var clothingStyleText: UITextField!
    
}
