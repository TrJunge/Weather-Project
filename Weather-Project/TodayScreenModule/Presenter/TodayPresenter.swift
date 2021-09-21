//
//  TodayScreenPresenter.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import UIKit
import CoreLocation
import Foundation

protocol TodayViewProtocol: AnyObject {
    func success(imageName: String, country: (name: String, shortName: String), temperature: (degrees: String, description: String), humidity: String, clouds: String, pressure: String, wind: String, windDirection: String, textToShare: String)
    func failure(error: Error!)
}

protocol TodayViewPresenterProtocol: AnyObject{
    init(view: TodayViewProtocol, networkServices: NetworkServiceProtocol, coordinate: CLLocationCoordinate2D!)
    func getNetworkResponse()
    func setComponents()
}

class TodayPresenter: TodayViewPresenterProtocol {
    weak var view: TodayViewProtocol?
    let networkServices: NetworkServiceProtocol!
    let coordinate: CLLocationCoordinate2D!
    private var modelTodayResponse: TodayResponse?
    
    required init(view: TodayViewProtocol, networkServices: NetworkServiceProtocol, coordinate: CLLocationCoordinate2D!) {
        self.view = view
        self.networkServices = networkServices
        self.coordinate = coordinate
        if self.coordinate != nil {
            self.getNetworkResponse()
        }
    }

    func getNetworkResponse() {
        let latitude = self.coordinate.latitude
        let longitude = self.coordinate.longitude
        let units = "metric"
        let keyAPI = "603cbab18b03ffb19439cac48a49168e"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=\(units)&appid=\(keyAPI)"
        
        self.networkServices.request(urlString: urlString, responseOn: TodayResponse.self) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.modelTodayResponse = response
                    self.setComponents()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func setComponents() {
        guard let modelTodayResponse = modelTodayResponse else { return }
        view?.success(imageName: WeatherIcons.getImage(modelTodayResponse.weather[0].icon),
                                  country: (modelTodayResponse.name, modelTodayResponse.sys.country),
                                  temperature: (String(Int(modelTodayResponse.main.temp)), modelTodayResponse.weather[0].main),
                                  humidity: String(Int(modelTodayResponse.main.humidity)),
                                  clouds: String(Int(modelTodayResponse.clouds.all)),
                                  pressure: String(Int(modelTodayResponse.main.pressure)),
                                  wind: String(modelTodayResponse.wind.speed),
                                  windDirection: windDirection(modelTodayResponse.wind.deg),
                                  textToShare: setupTextForShare())
    }
    
    private func setupTextForShare() -> String {
        guard let modelTodayResponse = modelTodayResponse else { return ""}
        return "Weather forecast from \(modelTodayResponse.name):\nFor \(CurrentDate.getFormatterDate(dateFormat: "dd.MM.YYYY | HH:mm:ss"))\nTemperature \(Int(modelTodayResponse.main.temp))ºC | \(modelTodayResponse.weather[0].main)\n - Humidity: \(Int(modelTodayResponse.main.humidity))%\n - Clouds: \(Int(modelTodayResponse.clouds.all))%\n - Pressure: \(Int(modelTodayResponse.main.pressure)) hPa\n - Wind: \(modelTodayResponse.wind.speed) km/h\n - Poles: \(windDirection(modelTodayResponse.wind.deg))"
    }
    
    private func windDirection(_ degrees: Float) -> String {
        let directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        let i: Int = Int((degrees + 11.25)/22.5)
        return directions[i % 16]
    }
}
