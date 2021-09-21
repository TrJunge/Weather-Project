//
//  Builder.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import UIKit
import CoreLocation

protocol Builder {
    static func createTodayViewController(coordinate: CLLocationCoordinate2D!) -> UIViewController
    static func createForecastViewController(coordinate: CLLocationCoordinate2D!) -> UIViewController
}

class ModuleBuilder: Builder {
    static func createTodayViewController(coordinate: CLLocationCoordinate2D!) -> UIViewController {
        let view = TodayViewController()
        let networkServices = NetworkService()
        let presenter = TodayPresenter(view: view, networkServices: networkServices, coordinate: coordinate)
        view.presenter = presenter
        return view
    }
    
    static func createForecastViewController(coordinate: CLLocationCoordinate2D!) -> UIViewController {
        let view = ForecastViewController()
        let networkServices = NetworkService()
        let presenter = ForecastPresenter(view: view, networkServices: networkServices, coordinate: coordinate)
        view.presenter = presenter
        return view
    }
}
