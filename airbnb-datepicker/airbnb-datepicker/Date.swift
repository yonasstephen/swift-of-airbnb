//
//  Date.swift
//  airbnb-datepicker
//
//  Created by Yonas Stephen on 24/2/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import Foundation

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}

