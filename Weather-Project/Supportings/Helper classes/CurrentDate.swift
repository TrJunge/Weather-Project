//
//  CurrentDate.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 20.09.21.
//

import Foundation

class CurrentDate {
    static func getFormatterDate(dateFormat: String) -> String {
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = TimeZone.current
        let formattedDate = formatter.string(from: time as Date)
        return formattedDate
    }
}
