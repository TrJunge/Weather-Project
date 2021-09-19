//
//  Builder.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import Foundation
import UIKit
import CoreLocation

protocol Builder {
    static func createTodayVC() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createTodayVC() -> UIViewController {
        let view = TodayViewController()
        let networkServices = NetworkService()
        let locationService = LocationService()
        let presenter = TodayPresenter(view: view, networkServices: networkServices, locationService: locationService)
        view.presenter = presenter
        return view
    }
}
