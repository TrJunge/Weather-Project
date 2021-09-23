//
//  MainTabBarPresenter.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 23.09.21.
//

import Foundation
import CoreLocation
import UIKit

protocol MainTabBarViewProtocol: AnyObject {
    func success(modelTodayModule: Today, modelForecastModule: ForecastList)
    func failure(failureType: FailureResponse, error: Error!)
}

protocol MainTabBarPresenterProtocol: AnyObject {
    init(view: MainTabBarViewProtocol, networkService: NetworkServiceProtocol, locationService: LocationServiceProtocol!)
    
    func successLocation(coordinate: CLLocationCoordinate2D)
    func failureLocation(failureType: FailureResponse.Location, error: Error!)
}

class MainTabBarPresenter: MainTabBarPresenterProtocol {
    private weak var view: MainTabBarViewProtocol?
    private let networkServices: NetworkServiceProtocol!
    private let locationService: LocationServiceProtocol!
    
    var modelTodayModule: Today!
    var modelForecastModule: ForecastList!
    
    required init(view: MainTabBarViewProtocol, networkService: NetworkServiceProtocol, locationService: LocationServiceProtocol!) {
        self.view = view
        self.networkServices = networkService
        self.locationService = locationService
    }
    
    private func getTodayModuleNetworkResponse(_ coordinate: CLLocationCoordinate2D) {
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        let units = "metric"
        let keyAPI = "603cbab18b03ffb19439cac48a49168e"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=\(units)&appid=\(keyAPI)"
        
        networkServices.request(urlString: urlString, responseOn: TodayResponse.self) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.modelTodayModule = Today(model: response)
                    self.getForecastModuleNetworkResponse(coordinate)
                case .failure(let error):
                    self.view?.failure(failureType: .internet(.connection), error: error)
                }
            }
        }
    }
    
    private func getForecastModuleNetworkResponse(_ coordinate: CLLocationCoordinate2D) {
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        let units = "metric"
        let keyAPI = "603cbab18b03ffb19439cac48a49168e"
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&units=\(units)&appid=\(keyAPI)"
        
        self.networkServices.request(urlString: urlString, responseOn: ForecastResponseList.self) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.modelForecastModule = ForecastList(model: response)
                    self.view?.success(modelTodayModule: self.modelTodayModule, modelForecastModule: self.modelForecastModule)
                case .failure(let error):
                    self.view?.failure(failureType: .internet(.connection), error: error)
                }
            }
        }
    }
    
    private func getNetworkRespones(coordinate: CLLocationCoordinate2D) {
        getTodayModuleNetworkResponse(coordinate)
    }
    
    func successLocation(coordinate: CLLocationCoordinate2D) {
        getNetworkRespones(coordinate: coordinate)
    }
    
    func failureLocation(failureType: FailureResponse.Location, error: Error!) {
        view?.failure(failureType: .location(failureType), error: error)
    }
}

