//
//  TodayScreenPresenter.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import UIKit
import CoreLocation

protocol TodayControllerProtocol {
    func setWeatherToday(imageName: String, country: (name: String, shortName: String), temperature: (degrees: String, description: String), humidity: String, clouds: String, pressure: String, wind: String, poles: String)
}

protocol TodayViewPresenterProtocol {
    init(view: TodayControllerProtocol, modelTodayResponse: TodayResponse)
    func showWeatherToday()
}

class TodayPresenter: TodayViewPresenterProtocol {
    let view: TodayControllerProtocol
    let modelTodayResponse: TodayResponse
    
    private var coordinate: CLLocationCoordinate2D!
    private lazy var cardinalPoints: String! = "SE"
    
    required init(view: TodayControllerProtocol, modelTodayResponse: TodayResponse) {
        self.view = view
        self.modelTodayResponse = modelTodayResponse
    }
    
    func showWeatherToday() {
        self.view.setWeatherToday(imageName: WeatherIcons.getImage(index: modelTodayResponse.weather[0].icon),
                                  country: (modelTodayResponse.name, modelTodayResponse.sys.country),
                                  temperature: (String(Int(modelTodayResponse.main.temp)), modelTodayResponse.weather[0].main),
                                  humidity: String(Int(modelTodayResponse.main.humidity)),
                                  clouds: String(Int(modelTodayResponse.clouds.all)),
                                  pressure: String(Int(modelTodayResponse.main.pressure)),
                                  wind: String(modelTodayResponse.wind.speed),
                                  poles: cardinalPoints)
    }
}
