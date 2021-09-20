//
//  ForecastScreenPresenter.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import Foundation
import CoreLocation

protocol ForecastViewProtocol: AnyObject {
    func success(navigationBarTitle: String)
    func failure(error: Error)
}

protocol ForecastViewPresenterProtocol: AnyObject {
    var modelForecastOnSections: [String:[Forecast]] { get set }
    init(view: ForecastViewProtocol, networkServices: NetworkServiceProtocol, locationService: LocationServiceProtocol)
    func setSection(_ section: Int) -> String
    func getNetworkResponse()
    func setComponents()
}

class ForecastPresenter: ForecastViewPresenterProtocol {
    weak var view: ForecastViewProtocol?
    let networkServices: NetworkServiceProtocol!
    let locationService: LocationServiceProtocol!
    var modelForecastOnSections = [String:[Forecast]]()
    private var coordinate: CLLocationCoordinate2D!
    private var cityName: String!
    private var calendar = Calendar(identifier: .gregorian)
    
    required init(view: ForecastViewProtocol, networkServices: NetworkServiceProtocol, locationService: LocationServiceProtocol) {
        self.view = view
        self.networkServices = networkServices
        self.locationService = locationService
        DispatchQueue.main.async {
            self.getNetworkResponse()
        }
    }
    
    func getNetworkResponse() {
        let latitude = self.locationService.coordinate.latitude
        let longitude = self.locationService.coordinate.longitude
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
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        formatter.timeZone = TimeZone.current // указатель временной зоны
        var forecastDate = formatter.string(from: Date())
        
        var indexSection = 0
        markIndexSection: while model.list.count > 0  {
            
            if modelForecastOnSections["\(indexSection)"] == nil {
                modelForecastOnSections["\(indexSection)"] = []
            } else {
                
                for forecastResponse in model.list {
                    let forecastResponseDateIndex = forecastResponse.dt_txt.firstIndex(of: " ") ??
                        forecastResponse.dt_txt.endIndex
                    let forecastResponseDate = String(forecastResponse.dt_txt[..<forecastResponseDateIndex])
                    
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
    }

    func setSection(_ section: Int) -> String {
        guard let weatherFromSection = modelForecastOnSections["\(section)"]?[0] else {
            return "Error"
        }
        let weatherDateIndex = weatherFromSection.dt_txt.firstIndex(of: " ") ?? weatherFromSection.dt_txt.endIndex
        let weatherDateInSection = String(weatherFromSection.dt_txt[..<weatherDateIndex])
        let weatherDateArray = weatherDateInSection.components(separatedBy: "-")
        
        var dateComponents = DateComponents()
        dateComponents.year = Int(weatherDateArray[0])
        dateComponents.month = Int(weatherDateArray[1])
        dateComponents.day = Int(weatherDateArray[2])
        
        let weatherDate = calendar.date(from: dateComponents)!
        let numberWeekDay = calendar.component(.weekday, from: weatherDate)
        return setSectionOnDate(numberWeekDay)
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
    
    func setComponents() {
        view?.success(navigationBarTitle: cityName)
    }
}
