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
    func failure(failureType: FailureResponse, error: Error?)
}

protocol MainTabBarPresenterProtocol: AnyObject {
    init(view: MainTabBarViewProtocol, networkService: NetworkServiceProtocol, locationService: LocationServiceProtocol)
    
    func successLocation(coordinate: CLLocationCoordinate2D)
    func failureLocation(failureType: FailureResponse.Location, error: Error?)
}

class MainTabBarPresenter: MainTabBarPresenterProtocol {
    private weak var view: MainTabBarViewProtocol?
    private let networkServices: NetworkServiceProtocol
    private let locationService: LocationServiceProtocol
    
    required init(view: MainTabBarViewProtocol, networkService: NetworkServiceProtocol, locationService: LocationServiceProtocol) {
        self.view = view
        self.networkServices = networkService
        self.locationService = locationService
    }
    
    private func getTodayModuleNetworkResponse(_ coordinate: CLLocationCoordinate2D) {
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        
        self.networkServices.request(latitude: latitude.description, longitude: longitude.description, responseOn: TodayResponse.self) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let modelTodayModule = Today(model: response)
                    self.getForecastModuleNetworkResponse(coordinate, modelTodayModule)
                case .failure(let error):
                    self.view?.failure(failureType: .internet(.connection), error: error)
                }
            }
        }
    }
    
    private func getForecastModuleNetworkResponse(_ coordinate: CLLocationCoordinate2D, _ modelTodayModule: Today) {
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        
        self.networkServices.request(latitude: latitude.description, longitude: longitude.description, responseOn: ForecastResponseList.self) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let modelForecastModule = ForecastList(model: response)
                    self.view?.success(modelTodayModule: modelTodayModule, modelForecastModule: modelForecastModule)
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
    
    func failureLocation(failureType: FailureResponse.Location, error: Error?) {
        view?.failure(failureType: .location(failureType), error: error)
    }
}
