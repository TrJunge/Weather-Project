//
//  CurrentDate.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 20.09.21.
//

import Foundation

class CurrentDate {
    static func getFormatterDate() -> String {
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY | HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let formattedDate = formatter.string(from: time as Date)
        return formattedDate
    }
}
