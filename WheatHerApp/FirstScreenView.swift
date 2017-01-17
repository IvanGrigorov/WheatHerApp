//
//  FirstScreenView.swift
//  WheatHerApp
//
//  Created by Student on 12/18/16.
//  Copyright © 2016 Student. All rights reserved.
//

import Foundation
import UIKit

public class  FirstScreenView :  UIView {
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    var image : URL? {
        didSet {
            do {
                self.frontImageView.image = try UIImage(data: Data(contentsOf : image!))
            }
            catch  {
                fatalError("Wrong Image URL")
            }
        }
    }
    
    
    @IBOutlet weak var Atmosphere: UILabel!

    var customAtmosphere : String? {
        didSet {
            self.Atmosphere.text = self.customAtmosphere
        }
    } 
    
    @IBOutlet weak var Wind: UILabel!

    var customWind: String? {
       didSet {
        self.Wind.text = self.customWind
        }
    }
    
    
    @IBOutlet weak var Location: UILabel!
    
    var customLocation: String? {
        didSet {
            self.Location.text = self.customLocation
        }
    }
    



    
}
