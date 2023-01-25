//
//  MainTabBarController.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import UIKit
import CoreLocation

class MainTabBarController: UITabBarController {
    private var locationService: LocationServiceProtocol?
    private var coordinate: CLLocationCoordinate2D?
    var presenter: MainTabBarPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "background-color")
    }
    
    func setTabBarController(_ modelTodayModule: Today?, _ modelForecastModule: ForecastList?) {
        let todayViewController = ModuleBuilder.createTodayViewController(model: modelTodayModule)
        let forecastViewController = ModuleBuilder.createForecastViewController(model: modelForecastModule)
        setViewControllers([todayViewController, forecastViewController], animated: true)
        setTabBarItems()
    }
    
    private func setTabBarItems() {
        let tabBarItem1 = self.tabBar.items?[0]
        tabBarItem1?.image = UIImage(systemName: "sun.max")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        tabBarItem1?.selectedImage = UIImage(systemName: "sun.max")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        tabBarItem1?.title = "Today"

        let tabBarItem2 = self.tabBar.items?[1]
        tabBarItem2?.image = UIImage(systemName: "cloud.moon.rain")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        tabBarItem2?.selectedImage = UIImage(systemName: "cloud.moon.rain")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        tabBarItem2?.title = "Forecast"
    }
    
    private func warningFailureLocationGeolocation(_ message: String) {
        let alertController = UIAlertController(title: "Geolocation failure", message: "\(message)\nPlease, check geolocation is enabled or not.", preferredStyle: .alert)
        let alertActionOk = UIAlertAction(title: "Ок", style: .default) { _ in
            self.setTabBarController(nil, nil)
        }
        alertController.addAction(alertActionOk)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func warningFailureLocationAuthorization() {
        let alertController = UIAlertController(title: "Geolocation failure", message: "Your location was not found. Maybe it is disabled, please check and try again.", preferredStyle: .alert)
        let alertActionOk = UIAlertAction(title: "Ок", style: .default) { _ in
            self.setTabBarController(nil, nil)
        }
        let alertActionSettings = UIAlertAction(title: "Settings", style: .cancel) { action in
            if let url = URL(string: UIApplication.openSettingsURLString){
                if UIApplication.shared.canOpenURL(url) {
                   UIApplication.shared.open(url, options: [:])
                }
            }
        }
        alertController.addAction(alertActionSettings)
        alertController.addAction(alertActionOk)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func warningFailureNetworkResponse(_ message: String) {
        let alertController = UIAlertController(title: "Error network response", message: "\(message). Please check the interneet connection.", preferredStyle: .alert)
        let alertActionOk = UIAlertAction(title: "Ок", style: .default) { _ in
            self.setTabBarController(nil, nil)
        }
        alertController.addAction(alertActionOk)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension MainTabBarController: MainTabBarViewProtocol {
    func success(modelTodayModule: Today, modelForecastModule: ForecastList) {
        setTabBarController(modelTodayModule, modelForecastModule)
    }
    
    func failure(failureType: FailureResponse) {
        switch failureType {
        case .location(.geolocationConnection(let message)):
            warningFailureLocationGeolocation(message)
        case .location(.privacyAuthorization(_)):
            warningFailureLocationAuthorization()
        case .internet(.connection(let message)),
             .internet(.unknown(message: let message)),
             .internet(.data(message: let message)):
            warningFailureNetworkResponse(message)
        }
    }
}
