//
//  MainTabBarController.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import UIKit
import CoreLocation

protocol MainTabBarDelegate: AnyObject {
    func successLocation(coordinate: CLLocationCoordinate2D!)
    func failureLocation(failureType: FailureResponse.Location, error: Error!)
}

class MainTabBarController: UITabBarController {
    private var locationService: LocationServiceProtocol!
    private var coordinate: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLocationService()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "background-color")
    }
    
    private func setupLocationService() {
        locationService = LocationService()
        locationService.mainTabBarDelegate = self
    }
    
    private func setTabBarController() {
        let todayViewController = ModuleBuilder.createTodayViewController(coordinate: coordinate)
        let forecastViewController = ModuleBuilder.createForecastViewController(coordinate: coordinate)
        setViewControllers([todayViewController, forecastViewController], animated: true)
        setTabBarItems()
    }
    
    private func setTabBarItems() {
        let tabBarItem1 = self.tabBar.items![0]
        tabBarItem1.image = UIImage(systemName: "sun.max")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        tabBarItem1.selectedImage = UIImage(systemName: "sun.max")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        tabBarItem1.title = "Today"

        let tabBarItem2 = self.tabBar.items![1]
        tabBarItem2.image = UIImage(systemName: "cloud.moon.rain")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        tabBarItem2.selectedImage = UIImage(systemName: "cloud.moon.rain")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        tabBarItem2.title = "Forecast"
    }
    
    private func warningFailureLocationGeolocation(_ error: Error) {
        let alertController = UIAlertController(title: "Geolocation failure", message: "\(error.localizedDescription). Please, check geolocation is enabled or not.", preferredStyle: .alert)
        let alertActionOk = UIAlertAction(title: "Ок", style: .default) { action in
            self.setTabBarController()
        }
        alertController.addAction(alertActionOk)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func warningFailureLocationAuthorization() {
        let alertController = UIAlertController(title: "Geolocation failure", message: "Your location was not found. Maybe it is disabled, please check and try again.", preferredStyle: .alert)
        let alertActionOk = UIAlertAction(title: "Ок", style: .default) { action in
            self.setTabBarController()
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
}

extension MainTabBarController: MainTabBarDelegate {
    func successLocation(coordinate: CLLocationCoordinate2D!) {
        self.coordinate = coordinate
        setTabBarController()
    }
    
    func failureLocation(failureType: FailureResponse.Location, error: Error!) {
        switch failureType {
        case .geolocationConnection:
            warningFailureLocationGeolocation(error)
        case .privacyAuthorization:
            warningFailureLocationAuthorization()
        }
    }
}
