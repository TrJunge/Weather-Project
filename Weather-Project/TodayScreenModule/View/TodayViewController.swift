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
    
    private var textToShare = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.setupSubviews()
        self.setupConstraints()
    }
    
    @objc func share() {
        let firstActivityItem = textToShare
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [firstActivityItem], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.saveToCameraRoll
        ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
}

extension TodayViewController: TodayViewProtocol {
    
    func success(imageName: String, country: (name: String, shortName: String), temperature: (degrees: String, description: String), humidity: String, clouds: String, pressure: String, wind: String, poles: String, textToShare: String) {
        self.imageWeatherView.image = UIImage(systemName: imageName)
        self.nameCountryLabel.text = "\(country.name), \(country.shortName)"
        self.temperatureLabel.text =  "\(temperature.degrees)°C | \("\(temperature.description)")"
        self.humidityLabel.text = "\(humidity)%"
        self.cloudsLabel.text = "\(clouds)%"
        self.pressureLabel.text = "\(pressure) hPa"
        self.windLabel.text = "\(wind) km/h"
        self.polesLabel.text = poles
        self.textToShare = textToShare
    }
    
    func failure(error: Error) {
        print(error)
        self.imageWeatherView.image = UIImage(systemName: "sun.max")
        self.nameCountryLabel.text = "-"
        self.temperatureLabel.text =  "-°C | -"
        self.humidityLabel.text = "-%"
        self.cloudsLabel.text = "-%"
        self.pressureLabel.text = "- hPa"
        self.windLabel.text = "- km/h"
        self.polesLabel.text = "-"
     
    }
}
