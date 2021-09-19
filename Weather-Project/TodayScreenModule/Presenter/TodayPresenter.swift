//
//  TodayScreenPresenter.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import UIKit
import CoreLocation

protocol TodayViewProtocol: AnyObject {
    func success(imageName: String, country: (name: String, shortName: String), temperature: (degrees: String, description: String), humidity: String, clouds: String, pressure: String, wind: String, poles: String)
    func failure(error: Error)
}

protocol TodayViewPresenterProtocol: AnyObject {
    init(view: TodayViewProtocol, networkServices: NetworkServiceProtocol, locationService: LocationServiceProtocol)
    var modelTodayResponse: TodayResponse? { get set }
    
    func setComponents()
    func getNetworkResponse()
}

class TodayPresenter: TodayViewPresenterProtocol {
    weak var view: TodayViewProtocol?
    let networkServices: NetworkServiceProtocol!
    let locationService: LocationServiceProtocol!
    var modelTodayResponse: TodayResponse?
    
    required init(view: TodayViewProtocol, networkServices: NetworkServiceProtocol, locationService: LocationServiceProtocol) {
        self.view = view
        self.networkServices = networkServices
        self.locationService = locationService
        self.getNetworkResponse()
    }
    
    func getNetworkResponse() {
        DispatchQueue.main.async {
            let latitude = self.locationService.coordinate.latitude
            let longitude = self.locationService.coordinate.longitude
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
    }
    
    func setComponents() {
        guard let modelTodayResponse = modelTodayResponse else { return }
        view?.success(imageName: WeatherIcons.getImage(index: modelTodayResponse.weather[0].icon),
                                  country: (modelTodayResponse.name, modelTodayResponse.sys.country),
                                  temperature: (String(Int(modelTodayResponse.main.temp)), modelTodayResponse.weather[0].main),
                                  humidity: String(Int(modelTodayResponse.main.humidity)),
                                  clouds: String(Int(modelTodayResponse.clouds.all)),
                                  pressure: String(Int(modelTodayResponse.main.pressure)),
                                  wind: String(modelTodayResponse.wind.speed),
                                  poles: locationService.cardinalPoints ?? "--")
    }
}
