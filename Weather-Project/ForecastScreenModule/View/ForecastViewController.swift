//
//  ForecastViewController.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import UIKit
import CoreLocation

class ForecastViewController: UIViewController {
    
    lazy var navigationBar: UINavigationBar = setNavigationBar()
    lazy var tableView: UITableView = setTableView()
    
    var presenter: ForecastViewPresenterProtocol!
    
    let cellIdentifier = "MyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.setupView()
        
        self.setupSubview()
        self.setupConstraint()
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemBackground
    }
}

extension ForecastViewController: ForecastViewProtocol {
    func success(navigationBarTitle: String) {
        guard let navItem = navigationBar.items?[0] else { return }
        navItem.title = navigationBarTitle
        tableView.reloadData()
    }
    
    func failure(error: Error) {
    
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.modelForecastOnSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.setSection(section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countRow = presenter.modelForecastOnSections[String(section)]?.count else { return 0 }
        return countRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weathersInSections = presenter.modelForecastOnSections["\(indexPath.section)"] else {
            return UITableViewCell()
        }
        let weatherItem = weathersInSections[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        return configurateCell(cell, weatherItem)
    }
    
    private func configurateCell(_ cell: TableViewCell, _ weatherItem: Forecast) -> UITableViewCell {
        let iconFromWeather = weatherItem.weather[0].icon
        cell.weatherImageView.image = UIImage(systemName: WeatherIcons.getImage(index: iconFromWeather))
        let weatherForecastTimeIndex = weatherItem.dt_txt.index(after: weatherItem.dt_txt.firstIndex(of: " ") ?? weatherItem.dt_txt.endIndex)
        var weatherForecastTime = String(weatherItem.dt_txt[weatherForecastTimeIndex...])
        weatherForecastTime.removeLast(3)
        cell.timeLabel.text = weatherForecastTime
        cell.descriptionLabel.text = weatherItem.weather[0].description
        cell.temperatureLabel.text = "\(Int(weatherItem.main.temp))Cº"
        return cell
    }
}
