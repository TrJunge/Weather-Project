//
//  ForecastModel.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 23.09.21.
//

import Foundation

struct ForecastList {
    var cityName: String
    var forecastBySection = [String:[Forecast]]()
    
    init(model: ForecastResponseList) {
        cityName = model.city.name
        forecastBySection = self.setModelForecastModule(model: model)
    }
    
    private func setModelForecastModule(model: ForecastResponseList) -> [String:[Forecast]] {
        var newModel = model
        var newForecastBySection = [String:[Forecast]]()
        var forecastDate = CurrentDate.getFormatterDate(dateFormat: "YYYY-MM-dd")
        var indexSection = 0
        markIndexSection: while newModel.list.count > 0  {
            if newForecastBySection["\(indexSection)"] == nil {
                newForecastBySection["\(indexSection)"] = []
            } else {
                
                for forecastResponse in newModel.list {
                    let forecast = Forecast(model: forecastResponse)
                    if forecastDate == forecast.date {
                        newForecastBySection["\(indexSection)"]?.append(forecast)
                        newModel.list.removeFirst()
                    } else {
                        forecastDate = forecast.date
                        indexSection += 1
                        continue markIndexSection
                    }
                }
                
            }
        }
        return newForecastBySection
    }
}

struct Forecast {
    var weather: WeatherForecast
    var temperature: String = ""
    var date: String = ""
    var time: String = ""
    
    init(model: ForecastResponse) {
        weather = WeatherForecast(model: model.weather[0])
        temperature = "\(Int(model.main.temp))ºC"
        date = self.setDate(model.dt_txt)
        time = self.setTime(model.dt_txt)
    }
    
    private func setDate(_ date: String) -> String {
        let index = date.firstIndex(of: " ") ?? date.endIndex
        let newDate = String(date[..<index])
        return newDate
    }
    
    private func setTime(_ date: String) -> String {
        let index = date.index(after: date.firstIndex(of: " ") ?? date.endIndex)
        var weatherForecastTime = String(date[index...])
        weatherForecastTime.removeLast(3)
        return weatherForecastTime
    }
}

struct WeatherForecast {
    var icon: String = ""
    var description: String = ""
    
    init() {}
    
    init(model: WeatherForecastResponse) {
        icon = WeatherIcons.getImage(model.icon)
        description = self.setDescription(model.description)
    }
    
    private func setDescription(_ description: String) -> String {
        let splitedDescription = description.split(separator: " ")
        var newDescription = ""
        splitedDescription.forEach { desc in
            guard let decsFirstUpperChar = desc.first?.uppercased() else { return }
            newDescription += decsFirstUpperChar + desc[desc.index(desc.startIndex, offsetBy: 1)...] + " "
        }
        return newDescription
    }
}
