//
//  Utility.swift
//  airbnb-datepicker
//
//  Created by Yonas Stephen on 2/3/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import Foundation

class Utility {
    
    static var calendar: Calendar {
        get {
            var c = Calendar.current
            c.timeZone = TimeZone(abbreviation: "GMT")!
            return c
        }
    }
    
}
