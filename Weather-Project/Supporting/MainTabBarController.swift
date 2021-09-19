//
//  MainTabBarController.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarController()
    }
    
    private func setTabBarController() {
        let todayViewController = ModuleBuilder.createTodayVC(testRequest())
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

    private func testRequest() -> TodayResponse {
         let weather = WeatherToday(main: "Clouds", description: "overcast clouds", icon: "04d")
         let main = MainToday(temp: 22.65, pressure: 1015.0, humidity: 91.0)
         let wind = WindToday(speed: 0.83)
         let clouds = CloudsToday(all: 100.0)
         let sys = CountryToday(country: "BY")
         return TodayResponse(name: "Vitebsk", weather: [weather], main: main, wind: wind, clouds: clouds, sys: sys)
     }
}

