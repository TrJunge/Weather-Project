//
//  ForecastModel.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import Foundation

struct ForecastResponseList: Codable {
    var list: [Forecast]
    var city: City
}
struct Forecast: Codable {
    var weather: [WeatherForecast]
    var main: MainForecast
    var dt_txt: String
}

struct WeatherForecast: Codable {
    var main: String
    var description: String
    var icon: String
}

struct MainForecast: Codable {
    var temp: Float
    var pressure: Float
    var humidity: Float
}

struct City: Codable {
    var name: String
}
