//
//  TipViwController.swift
//  WheatHerApp
//
//  Created by Student on 2/3/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation
import UIKit


class TipViewController : UIView {
    
    var initialHeight = 0.0
    var initialWidth = 0.0
    static var isEnlarged = false

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.animateinStart(sender:)))
        self.view.addGestureRecognizer(gesture)
        self.initialHeight = Double(self.view.frame.height)
        self.initialWidth = Double(self.view.frame.width)

    }
    
    @objc private   func animateinStart(sender: UITapGestureRecognizer) {
        if !TipViewController.isEnlarged {
            return
        }
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
                
                let hightToResize = self.initialHeight
                let widthToResize = self.initialWidth
                
                self.view.frame = CGRect(x: 0,y:  0, width:  widthToResize, height: hightToResize)
            }, completion : nil)
        TipViewController.isEnlarged = false
    }
}
