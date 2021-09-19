//
//  TodayModel.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import Foundation

struct TodayResponse: Codable {
    var name: String
    var weather: [WeatherToday]
    var main: MainToday
    var wind: WindToday
    var clouds: CloudsToday
    var sys: CountryToday
}

struct WeatherToday: Codable {
    var main: String
    var description: String
    var icon: String
}

struct MainToday: Codable {
    var temp: Float
    var pressure: Float
    var humidity: Float
}

struct WindToday: Codable {
    var speed: Float
}

struct CloudsToday: Codable {
    var all: Float
}

struct CountryToday: Codable {
    var country: String
}
