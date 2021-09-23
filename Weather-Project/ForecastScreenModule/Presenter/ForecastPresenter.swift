//
//  ForecastScreenPresenter.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import Foundation
import CoreLocation
import UIKit

protocol ForecastViewProtocol: AnyObject {
    func success(navigationBarTitle: String)
    func failure()
}

protocol ForecastViewPresenterProtocol: AnyObject {
    var sectionCount: Int! { get set }
    
    init(view: ForecastViewProtocol, model: ForecastList?)
    
    func numberOfRowsIn(section: Int) -> Int
    func setSectionTitle(_ section: Int) -> String
    func setCell(_ cell: TableViewCell, _ indexPath: IndexPath) -> UITableViewCell
}

class ForecastPresenter: ForecastViewPresenterProtocol {
    private weak var view: ForecastViewProtocol?
    private let model: ForecastList!
    var sectionCount: Int!
  
    private var coordinate: CLLocationCoordinate2D!
    private var calendar = Calendar(identifier: .gregorian)
    
    required init(view: ForecastViewProtocol, model: ForecastList?) {
        self.view = view
        self.model = model
        self.sectionCount = model?.forecastBySection.count ?? 0
        setComponents()
    }
    
    func numberOfRowsIn(section: Int) -> Int {
        guard let countRow = model.forecastBySection[String(section)]?.count else { return 0 }
        return countRow
    }
    
    func setCell(_ cell: TableViewCell, _ indexPath: IndexPath) -> UITableViewCell {
        guard let weathersInSections = model.forecastBySection["\(indexPath.section)"] else {
            return UITableViewCell()
        }
        let weatherItem = weathersInSections[indexPath.row]
        return configurateCell(cell, weatherItem)
    }
    
    private func configurateCell(_ cell: TableViewCell, _ weatherItem: Forecast) -> UITableViewCell {
        cell.weatherImageView.image = UIImage(systemName: weatherItem.weather.icon)
        cell.timeLabel.text = weatherItem.time
        cell.descriptionLabel.text = weatherItem.weather.description
        cell.temperatureLabel.text = weatherItem.temperature
        return cell
    }
    
    func setSectionTitle(_ section: Int) -> String {
        guard let weatherInSection = model.forecastBySection["\(section)"]?[0] else {
            return "Error"
        }
        let weatherDateArray = weatherInSection.date.components(separatedBy: "-")
        
        var dateComponents = DateComponents()
        dateComponents.year = Int(weatherDateArray[0])
        dateComponents.month = Int(weatherDateArray[1])
        dateComponents.day = Int(weatherDateArray[2])
        
        let weatherDate = calendar.date(from: dateComponents)!
        let numberWeekDay = calendar.component(.weekday, from: weatherDate)
        return setSectionOnDate(numberWeekDay).uppercased()
    }
    
    private func setSectionOnDate(_ weekDay: Int) -> String {
        switch weekDay {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return "Data error"
        }
    }
    
    private func setComponents() {
        guard model != nil else {
            view?.failure()
            return
        }
        view?.success(navigationBarTitle: model.cityName)
    }
}
