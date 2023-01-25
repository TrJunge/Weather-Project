//
//  TodayModel.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 23.09.21.
//

import Foundation

struct Today {
    var name: String = ""
    var weather: WeatherToday
    var main: MainToday
    var wind: WindToday
    var clouds: CloudsToday
    var sys: CountryToday
    var shareButton: ShareButton
    
    init(model: ForecastResponseList) {
        name = model.city.name
        if let forecastModel = model.list.first {
            weather = WeatherToday(model: forecastModel.weather[0])
            main = MainToday(model: forecastModel.main)
            wind = WindToday(model: forecastModel.wind)
            clouds = CloudsToday(model: forecastModel.clouds)
            sys = CountryToday(model: model.city)
            shareButton = ShareButton(name: name, modelWeather: weather, modelMain: main, modelWind: wind, modelClouds: clouds)
        } else {
            weather = WeatherToday()
            main = MainToday()
            wind = WindToday()
            clouds = CloudsToday()
            sys = CountryToday()
            shareButton = ShareButton(name: name, modelWeather: weather, modelMain: main, modelWind: wind, modelClouds: clouds)
        }
    }
}

struct WeatherToday {
    var main: String = ""
    var description: String = ""
    var icon: String = ""
    
    init() {}
    
    init(model: WeatherForecastResponse) {
        main = model.main
        description = model.description
        icon = WeatherIcons.getImage(model.icon)
    }
}

struct MainToday {
    var temp: String = ""
    var pressure: String = ""
    var humidity: String = ""
    
    init() {}
    
    init(model: MainForecastResponse) {
        temp = String(model.temp)
        pressure = String(model.pressure)
        humidity = String(model.humidity)
    }
}

struct WindToday {
    var speed: String = ""
    var direction: String = ""
    
    init() {}
    
    init(model: WindTodayResponse) {
        self.speed = String(model.speed)
        self.direction = setWindDirection(model.deg)
    }
    
    private func setWindDirection(_ degrees: Int) -> String {
        let directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        let i = Int((Double(degrees) + 11.25)/22.5)
        return directions[i % 16]
    }
}

struct CloudsToday {
    var all: String = ""
    
    init() {}
    
    init(model: CloudsTodayResponse) {
        self.all = String(Int(model.all))
    }
}

struct CountryToday {
    var country: String = ""
    
    init() {}
    
    init(model: CityForecastResponse) {
        self.country = model.country
    }
}

struct ShareButton {
    var text: String = ""
    
    init() {}
    
    init(name: String, modelWeather: WeatherToday, modelMain: MainToday, modelWind: WindToday, modelClouds: CloudsToday) {
        self.text = setTextForShare(name, modelWeather, modelMain, modelWind, modelClouds)
    }
    
    private func setTextForShare(_ name: String, _ modelWeather: WeatherToday, _ modelMain: MainToday, _ modelWind:WindToday, _ modelClouds: CloudsToday) -> String {
        return "Weather forecast from \(name):\nFor \(CurrentDate.getFormatterDate(dateFormat: "dd.MM.YYYY | HH:mm:ss"))\nTemperature \(modelMain.temp)ºC | \(modelWeather.main)\n - Humidity: \(modelMain.humidity)%\n - Clouds: \(modelClouds.all)%\n - Pressure: \(modelMain.pressure) hPa\n - Wind: \(modelWind.speed) km/h\n - Wind direction: \(modelWind.direction)"
    }
}
