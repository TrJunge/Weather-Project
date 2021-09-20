//
//  Builder.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import UIKit

protocol Builder {
    static func createTodayViewController() -> UIViewController
    static func createForecastViewController() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createTodayViewController() -> UIViewController {
        let view = TodayViewController()
        let networkServices = NetworkService()
        let locationService = LocationService()
        let presenter = TodayPresenter(view: view, networkServices: networkServices, locationService: locationService)
        view.presenter = presenter
        return view
    }
    
    static func createForecastViewController() -> UIViewController {
        let view = ForecastViewController()
        let networkServices = NetworkService()
        let locationService = LocationService()
        let presenter = ForecastPresenter(view: view, networkServices: networkServices, locationService: locationService)
        view.presenter = presenter
        return view
    }
}
