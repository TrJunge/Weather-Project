//
//  WeatherIcons.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

class WeatherIcons {
    // провести тесты!
    // уточнить про static
    static func getImage(_ iconIndex: String) -> String {
        switch iconIndex {
        case "01n":
            return "moon.stars"
        case "01d":
            return "sun.max"
        case "02n":
            return "cloud.moon"
        case "02d":
            return "cloud.sun"
        case "03n", "03d":
            return "cloud"
        case "04n", "04d":
            return "smoke"
        case "09n", "09d":
            return "cloud.heavyrain"
        case "10n":
            return "cloud.moon.rain"
        case "10d":
            return "cloud.sun.rain"
        case "11n", "11d":
            return "cloud.bolt"
        case "13n", "13d":
            return "snow"
        case "50n", "50d":
            return "cloud.fog"
        default:
            return "sun.max"
        }
    }
}
