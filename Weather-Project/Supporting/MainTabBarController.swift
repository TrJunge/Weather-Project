//
//  MainTabBarController.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import UIKit
import CoreLocation

class MainTabBarController: UITabBarController {

    var coordinate: CLLocationCoordinate2D!
    var heading: CLHeading!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarController()
    }
    
    private func setTabBarController() {
        let todayViewController = ModuleBuilder.createTodayVC()
        let forecastViewController = ForecastViewController()
        self.setViewControllers([todayViewController, forecastViewController], animated: true)
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
}

