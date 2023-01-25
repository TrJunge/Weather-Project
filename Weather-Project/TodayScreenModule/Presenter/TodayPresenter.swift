//
//  TodayScreenPresenter.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import UIKit
import CoreLocation
import Foundation

protocol TodayViewProtocol: AnyObject {
    func success(imageName: String, country: (name: String, shortName: String), temperature: (degrees: String, description: String), humidity: String, clouds: String, pressure: String, wind: String, windDirection: String, textToShare: String)
    func failure()
}

protocol TodayViewPresenterProtocol: AnyObject{
    init(view: TodayViewProtocol, model: Today?)
}

class TodayPresenter: TodayViewPresenterProtocol {
    private weak var view: TodayViewProtocol?
    private var model: Today?
    
    required init(view: TodayViewProtocol, model: Today?) {
        self.view = view
        self.model = model
        setComponents()
    }

    private func setComponents() {
        guard let model = model else { view?.failure(); return }
        view?.success(
            imageName: model.weather.icon,
            country: (model.name, model.sys.country),
            temperature: (model.main.temp, model.weather.main),
            humidity: model.main.humidity,
            clouds: model.clouds.all,
            pressure: model.main.pressure,
            wind: model.wind.speed,
            windDirection: model.wind.direction,
            textToShare: model.shareButton.text
        )
    }
}
