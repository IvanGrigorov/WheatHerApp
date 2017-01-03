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
    
    var image : UIImage? {
        didSet {
            self.frontImageView.image = image
        }
    }
    
    
    @IBOutlet weak var weekDayLabel: UILabel!
    
    var dayOfWeek : WeekDays? {
        didSet {
            self.weekDayLabel.text = dayOfWeek!.rawValue
            
        }
    }
}
