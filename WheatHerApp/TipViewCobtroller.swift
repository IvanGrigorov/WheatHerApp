//
//  TipViewCobtroller.swift
//  WheatHerApp
//
//  Created by Student on 2/3/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import UIKit

class TipViewController : ViewController {
    
     var viewData : WeatherModel? {
        didSet {
            if viewData!.imageURL.path != "rain" ||
            viewData!.imageURL.path != "snow"
            {
                self.Tip.text = "Prepare for rain/snow today"
            }
            else {
                self.Tip.text = "Prepare the clear today"
                
            }
            guard let user = RealmReader.readUser() else {
                self.DetailTip.text = "No active user."
                return
            }
            if user.clothingStyle == "informal" {
                if Double(viewData!.apparentTemp!)! < 10.00 {
                    self.DetailTip.text = "Get a warm sweatshirt, it is not going to be warm. "
                }
                else {
                    self.DetailTip.text = "Get a t - shirt and enjoy the hot weather."
                    
                }
            }
            if user.clothingStyle == "formal" {
                if Double(viewData!.apparentTemp!)! < 10.00 {
                    self.DetailTip.text = "Get a warm jacket, it is not going to be warm. "
                }
                else {
                    self.DetailTip.text = "Get a thin shirt and enjoy the hot weather."
                    
                }
            }
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: //self.view.bounds.width, height: self.view.bounds.height))
        //imageViewBackground.image = UIImage(named: "idea")
        //imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        
        self.DetailTip.isHidden =  true
        self.Tip.isHidden = true
        self.Header.isHidden = true
       // self.view.backgroundColor = UIColor(patternImage: imageViewBackground.image!)
        
    }
    
    @IBOutlet weak var Header: UILabel!
    @IBOutlet weak var DetailTip: UILabel!
    @IBOutlet weak var Tip: UILabel!
    

}
