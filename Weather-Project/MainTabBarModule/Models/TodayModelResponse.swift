//
//  TodayModel.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import Foundation

struct TodayResponse: Codable {
    var name: String
    var weather: [WeatherTodayResponse]
    var main: MainTodayResponse
    var wind: WindTodayResponse
    var clouds: CloudsTodayResponse
    var sys: CountryTodayResponse
}

struct WeatherTodayResponse: Codable {
    var main: String
    var description: String
    var icon: String
}

struct MainTodayResponse: Codable {
    var temp: Float
    var pressure: Float
    var humidity: Float
}

struct WindTodayResponse: Codable {
    var speed: Float
    var deg: Float
}

struct CloudsTodayResponse: Codable {
    var all: Float
}

struct CountryTodayResponse: Codable {
    var country: String
}
