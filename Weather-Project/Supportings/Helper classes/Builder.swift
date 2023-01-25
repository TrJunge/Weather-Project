//
//  Builder.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import UIKit
import CoreLocation

protocol Builder {
    static func createMainTabBarController() -> UITabBarController
    static func createTodayViewController(model: Today?) -> UIViewController
    static func createForecastViewController(model: ForecastList?) -> UIViewController
}

class ModuleBuilder: Builder {
    static func createMainTabBarController() -> UITabBarController {
        let view = MainTabBarController()
        let networkService = NetworkService()
        let locationService = LocationService()
        let presenter = MainTabBarPresenter(view: view, networkService: networkService, locationService: locationService)
        locationService.mainTabBarDelegate = presenter
        view.presenter = presenter
        return view
    }
    
    static func createTodayViewController(model: Today?) -> UIViewController {
        let view = TodayViewController()
        _ = TodayPresenter(view: view, model: model)
        return view
    }
    
    static func createForecastViewController(model: ForecastList?) -> UIViewController {
        let view = ForecastViewController()
        let presenter = ForecastPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}
