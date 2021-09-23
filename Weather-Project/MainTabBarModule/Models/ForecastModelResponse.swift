//
//  ForecastModel.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import Foundation

struct ForecastResponseList: Codable {
    var list: [ForecastResponse]
    var city: CityForecastResponse
}
struct ForecastResponse: Codable {
    var weather: [WeatherForecastResponse]
    var main: MainForecastResponse
    var dt_txt: String
}

struct WeatherForecastResponse: Codable {
    var main: String
    var description: String
    var icon: String
}

struct MainForecastResponse: Codable {
    var temp: Float
    var pressure: Float
    var humidity: Float
}

struct CityForecastResponse: Codable {
    var name: String
}
