//
//  ForecastViewController.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import UIKit

class ForecastViewController: UIViewController {
    
    lazy var navigationBar: UINavigationBar = setNavigationBar()
    lazy var tableView: UITableView = setTableView()
    
    var presenter: ForecastViewPresenterProtocol!
    
    let cellIdentifier = "Cell"
    let headerIdentifier = "Header"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.setupView()
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.setupSubview()
        self.setupConstraint()
    }
}

// MARK: ForecastViewProtocol
extension ForecastViewController: ForecastViewProtocol {
    func success(navigationBarTitle: String) {
        guard let navItem = navigationBar.items?[0] else { return }
        navItem.title = navigationBarTitle
        tableView.reloadData()
    }
    
    func failure(error: Error!) {
        
    }
}

// MARK: UITableViewDelegate
extension ForecastViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.modelForecastOnSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countRow = presenter.modelForecastOnSections[String(section)]?.count else { return 0 }
        return countRow
    }
}

// MARK:  UITableViewDataSource
extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.setSection(section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) else {
            return UITableViewHeaderFooterView()
        }
        headerView.tintColor = .systemBackground
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(35.0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weathersInSections = presenter.modelForecastOnSections["\(indexPath.section)"] else {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        let weatherItem = weathersInSections[indexPath.row]
        return configurateCell(cell, weatherItem)
    }
    
    private func configurateCell(_ cell: TableViewCell, _ weatherItem: Forecast) -> UITableViewCell {
        cell.weatherImageView.image = UIImage(systemName: WeatherIcons.getImage(weatherItem.weather[0].icon))
        cell.timeLabel.text = setWeatherForecastTime(weatherItem)
        cell.descriptionLabel.text = weatherItem.weather[0].description
        cell.temperatureLabel.text = "\(Int(weatherItem.main.temp))Cº"
        return cell
    }
    
    private func setWeatherForecastTime(_ weatherItem: Forecast) -> String {
        let index = weatherItem.dt_txt.index(after: weatherItem.dt_txt.firstIndex(of: " ") ?? weatherItem.dt_txt.endIndex)
        var weatherForecastTime = String(weatherItem.dt_txt[index...])
        weatherForecastTime.removeLast(3)
        return weatherForecastTime
    }
}
