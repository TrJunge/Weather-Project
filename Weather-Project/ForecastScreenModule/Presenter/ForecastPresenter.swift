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
    func failure(error: Error!)
}

protocol ForecastViewPresenterProtocol: AnyObject {
    var sectionCount: Int! { get set }
    
    init(view: ForecastViewProtocol, networkServices: NetworkServiceProtocol, coordinate: CLLocationCoordinate2D!)
    
    func numberOfRowsIn(section: Int) -> Int
    func setSectionTitle(_ section: Int) -> String
    func setCell(_ cell: TableViewCell, _ indexPath: IndexPath) -> UITableViewCell
}

class ForecastPresenter: ForecastViewPresenterProtocol {
    private weak var view: ForecastViewProtocol?
    private let networkServices: NetworkServiceProtocol!
    private var modelForecastOnSections = [String:[Forecast]]()
    var sectionCount: Int!
    private var coordinate: CLLocationCoordinate2D!
    private var cityName: String!
    private var calendar = Calendar(identifier: .gregorian)
    
    required init(view: ForecastViewProtocol, networkServices: NetworkServiceProtocol, coordinate: CLLocationCoordinate2D!) {
        self.view = view
        self.networkServices = networkServices
        self.coordinate = coordinate
        if self.coordinate != nil {
            getNetworkResponse()
        }
    }
    
    private func getNetworkResponse() {
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        let units = "metric"
        let keyAPI = "603cbab18b03ffb19439cac48a49168e"
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&units=\(units)&appid=\(keyAPI)"
        
        self.networkServices.request(urlString: urlString, responseOn: ForecastResponseList.self) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.setupModelForecastOnSections(model: response)
                    self.cityName = response.city.name
                    self.setComponents()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    private func setupModelForecastOnSections(model modelForecastResponseList: ForecastResponseList) {
        var model = modelForecastResponseList
        var forecastDate = CurrentDate.getFormatterDate(dateFormat: "YYYY-MM-dd")
        var indexSection = 0
        markIndexSection: while model.list.count > 0  {
            
            if modelForecastOnSections["\(indexSection)"] == nil {
                modelForecastOnSections["\(indexSection)"] = []
            } else {
                
                for forecastResponse in model.list {
                    let index = forecastResponse.dt_txt.firstIndex(of: " ") ?? forecastResponse.dt_txt.endIndex
                    let forecastResponseDate = String(forecastResponse.dt_txt[..<index])
                    
                    if forecastDate == forecastResponseDate {
                        modelForecastOnSections["\(indexSection)"]?.append(forecastResponse)
                        model.list.removeFirst()
                    } else {
                        forecastDate = forecastResponseDate
                        indexSection += 1
                        continue markIndexSection
                    }
                
                }
                
            }
            
        }
        sectionCount = modelForecastOnSections.count
    }
    
    func numberOfRowsIn(section: Int) -> Int {
        guard let countRow = modelForecastOnSections[String(section)]?.count else { return 0 }
        return countRow
    }
    
    func setCell(_ cell: TableViewCell, _ indexPath: IndexPath) -> UITableViewCell {
        guard let weathersInSections = modelForecastOnSections["\(indexPath.section)"] else {
            return UITableViewCell()
        }
        let weatherItem = weathersInSections[indexPath.row]
        return configurateCell(cell, weatherItem)
    }
    
    private func configurateCell(_ cell: TableViewCell, _ weatherItem: Forecast) -> UITableViewCell {
        cell.weatherImageView.image = UIImage(systemName: WeatherIcons.getImage(weatherItem.weather[0].icon))
        cell.timeLabel.text = setTimeCell(weatherItem.dt_txt)
        cell.descriptionLabel.text = setDescriptionCell(weatherItem.weather[0].description)
        cell.temperatureLabel.text = "\(Int(weatherItem.main.temp))Cº"
        return cell
    }
    
    private func setTimeCell(_ date: String) -> String {
        let index = date.index(after: date.firstIndex(of: " ") ?? date.endIndex)
        var weatherForecastTime = String(date[index...])
        weatherForecastTime.removeLast(3)
        return weatherForecastTime
    }
    
    private func setDescriptionCell(_ description: String) -> String {
        let splitedDescription = description.split(separator: " ")
        var newDescription = ""
        splitedDescription.forEach { desc in
            let decsFirstUpperChar = desc.first!.uppercased()
            newDescription += decsFirstUpperChar + desc[desc.index(desc.startIndex, offsetBy: 1)...] + " "
        }
        return newDescription
    }
    
    func setSectionTitle(_ section: Int) -> String {
        guard let weatherFromSection = modelForecastOnSections["\(section)"]?[0] else {
            return "Error"
        }
        let index = weatherFromSection.dt_txt.firstIndex(of: " ") ?? weatherFromSection.dt_txt.endIndex
        let weatherDateInSection = String(weatherFromSection.dt_txt[..<index])
        let weatherDateArray = weatherDateInSection.components(separatedBy: "-")
        
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
        view?.success(navigationBarTitle: cityName)
    }
}
