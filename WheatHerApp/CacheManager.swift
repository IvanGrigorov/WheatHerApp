//
//  CacheManager.swift
//  WheatHerApp
//
//  Created by Student on 1/7/17.
//  Copyright © 2017 Student. All rights reserved.
//

import Foundation

public class CachedManager  {
    

    private static var instance : CachedManager?
    public static func getInstance() -> CachedManager {
        guard let unwrappedInstance = instance else {
            instance = CachedManager()
            return self.instance!
        }
        return unwrappedInstance
    }
    
    private  var cached : Double?
    private  var deliveryCache : Double?

    
    public func toCacheOrNotToCache() -> Bool {
        guard let unwrappedTime = cached else {
            self.cached = NSDate().timeIntervalSince1970
            return false
        }
        if unwrappedTime + 180  < NSDate().timeIntervalSince1970 {
            self.cached = NSDate().timeIntervalSince1970
            return false
        }
        return true
    }
    
    public func toCacheOrNotToCacheDelivery() -> Bool {
        guard let unwrappedTime = deliveryCache else {
            self.deliveryCache = NSDate().timeIntervalSince1970
            return false
        }
        if unwrappedTime + 180  < NSDate().timeIntervalSince1970 {
            self.deliveryCache = NSDate().timeIntervalSince1970
            return false
        }
        return true
    }
}
