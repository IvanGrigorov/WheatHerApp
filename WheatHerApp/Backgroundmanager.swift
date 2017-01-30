

import Foundation

public class BackgroundManager {
    
    static let  winterSpringBorder  = (22, 3)
    static let springSummerBorder = (22, 6)
    static let summerAutumnBorder = (22, 9)
    static let autumnWinterBorder = (22, 12)
    static let morningLunchBorder = 12
    
    static let lunchNightBorder =  19
    static  let nightMorningBorder = 7
    
    static  func  returnNameOfBackgroundForDateTime() -> String {
        print (BackgroundManager.autumnWinterBorder)
        
        let date = Calendar.current.dateComponents([.day,.hour,.month,], from: Date())
        // Check for winter
        if  (date.month! < self.winterSpringBorder.1 || (date.month! == winterSpringBorder.1 && date.day! <= self.winterSpringBorder.0) || (date.month! == 12 && date.day! >= self.autumnWinterBorder.0)){
            // Check for day period
            if date.hour! <= self.morningLunchBorder  && date.hour! > self.nightMorningBorder {
                return "winter_morning"
            }
            if date.hour! <= self.lunchNightBorder  && date.hour! > self.morningLunchBorder {
                return "winter_day"
            }
            else {
                return "winter_night"
            }
        }
        return  "default"
    }
}

