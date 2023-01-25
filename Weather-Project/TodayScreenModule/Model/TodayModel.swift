//
//  TodayModel.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 23.09.21.
//

import Foundation

struct Today {
    var name: String
    var weather: WeatherToday
    var main: MainToday
    var wind: WindToday
    var clouds: CloudsToday
    var sys: CountryToday
    var shareButton: ShareButton
    
    init(model: TodayResponse) {
        name = model.name
        weather = WeatherToday(model: model.weather[0])
        main = MainToday(model: model.main)
        wind = WindToday(model: model.wind)
        clouds = CloudsToday(model: model.clouds)
        sys = CountryToday(model: model.sys)
        shareButton = ShareButton(name: name, modelWeather: weather, modelMain: main, modelWind: wind, modelClouds: clouds)
    }
}

struct WeatherToday {
    var main: String
    var description: String
    var icon: String
    
    init(model: WeatherTodayResponse) {
        main = model.main
        description = model.description
        icon = WeatherIcons.getImage(model.icon)
    }
}

struct MainToday {
    var temp: String
    var pressure: String
    var humidity: String
    
    init(model: MainTodayResponse) {
        temp = String(Int(model.temp))
        pressure = String(Int(model.pressure))
        humidity = String(Int(model.humidity))
    }
}

struct WindToday {
    var speed: String
    var direction: String = ""
    
    init(model: WindTodayResponse) {
        self.speed = String(model.speed)
        self.direction = setWindDirection(model.deg)
    }
    
    private func setWindDirection(_ degrees: Float) -> String {
        let directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        let i: Int = Int((degrees + 11.25)/22.5)
        return directions[i % 16]
    }
}

struct CloudsToday {
    var all: String
    
    init(model: CloudsTodayResponse) {
        self.all = String(Int(model.all))
    }
}

struct CountryToday {
    var country: String
    
    init(model: CountryTodayResponse) {
        self.country = model.country
    }
}

struct ShareButton {
    var text: String = ""
    
    init(name: String, modelWeather: WeatherToday, modelMain: MainToday, modelWind:WindToday, modelClouds: CloudsToday) {
        self.text =  setTextForShare(name, modelWeather, modelMain, modelWind, modelClouds)
    }
    
    private func setTextForShare(_ name: String, _ modelWeather: WeatherToday, _ modelMain: MainToday, _ modelWind:WindToday, _ modelClouds: CloudsToday) -> String {
        return "Weather forecast from \(name):\nFor \(CurrentDate.getFormatterDate(dateFormat: "dd.MM.YYYY | HH:mm:ss"))\nTemperature \(modelMain.temp)ºC | \(modelWeather.main)\n - Humidity: \(modelMain.humidity)%\n - Clouds: \(modelClouds.all)%\n - Pressure: \(modelMain.pressure) hPa\n - Wind: \(modelWind.speed) km/h\n - Wind direction: \(modelWind.direction)"
    }
}
