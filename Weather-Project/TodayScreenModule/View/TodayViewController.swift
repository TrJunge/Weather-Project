//
//  TodayViewController.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import UIKit

class TodayViewController: UIViewController {
    
    lazy var navigationBar: UINavigationBar = setNavigationBar()
    lazy var imageWeatherView: UIImageView = setImageWeatherView()
    lazy var nameCountryLabel: UILabel = setNameCountryLabel()
    lazy var temperatureLabel: UILabel = setTemperatureLabel()
    lazy var mainTopStackView: UIStackView = setMainTopStackView()
    lazy var humidityLabel: UILabel = setHumidityLabel()
    lazy var humidityStackView: UIStackView = setHumidityStackView()
    lazy var cloudsLabel: UILabel = setCloudsLabel()
    lazy var cloudyStackView: UIStackView = setCloudyStackView()
    lazy var pressureLabel: UILabel = setPressureLabel()
    lazy var pressureStackView: UIStackView = setPressureStackView()
    lazy var firstMiddleStackView: UIStackView = setFirstMiddleStackView()
    lazy var windLabel: UILabel = setWindLabel()
    lazy var windStackView: UIStackView = setWindStackView()
    lazy var polesLabel: UILabel = setPolesLabel()
    lazy var polesStackView: UIStackView = setPolesStackView()
    lazy var secondMiddleStackView: UIStackView = setSecondMiddleStackView()
    lazy var mainMiddleStackView: UIStackView = setMainMiddleStackView()
    lazy var shareButton: UIButton = setShareButton()
    
    var presenter: TodayViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        self.presenter.setComponents()
        
        self.setupSubviews()
        self.setupConstraints()
    }
    
    private func setView() {
        self.view.backgroundColor = .systemBackground
    }
}

extension TodayViewController: TodayViewProtocol {
    func success(imageName: String, country: (name: String, shortName: String), temperature: (degrees: String, description: String), humidity: String, clouds: String, pressure: String, wind: String, poles: String) {
        imageWeatherView.image = UIImage(systemName: imageName)
        nameCountryLabel.text = "\(country.name), \(country.shortName)"
        temperatureLabel.text =  "\(temperature.degrees)°C | \("\(temperature.description)")"
        humidityLabel.text = "\(humidity)%"
        cloudsLabel.text = "\(clouds)%"
        pressureLabel.text = "\(pressure) hPa"
        windLabel.text = "\(wind) km/h"
        polesLabel.text = poles
    }
    
    func failure(error: Error) {
        print(error)
        imageWeatherView.image = UIImage(systemName: "sun.max")
        nameCountryLabel.text = "-"
        temperatureLabel.text =  "-°C | -"
        humidityLabel.text = "-%"
        cloudsLabel.text = "-%"
        pressureLabel.text = "- hPa"
        windLabel.text = "- km/h"
        polesLabel.text = "-"
    }
}
