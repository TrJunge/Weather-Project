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
    lazy var windDirectionLabel: UILabel = setWindDirectionLabel()
    lazy var windDirectionStackView: UIStackView = setWindDirectionStackView()
    lazy var secondMiddleStackView: UIStackView = setSecondMiddleStackView()
    lazy var mainMiddleStackView: UIStackView = setMainMiddleStackView()
    lazy var shareButton: UIButton = setShareButton()
    
    var presenter: TodayViewPresenterProtocol!
    
    private var textToShare = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "background-color")
        setupSubviews()
        setupConstraints()
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
    
    private func failureNetworkResponse(_ error: Error!) {
        let alertController = UIAlertController(title: "Error network response", message: "\(error.localizedDescription). Please check the interneet connection&", preferredStyle: .alert)
        let alertActionOk = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alertController.addAction(alertActionOk)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension TodayViewController: TodayViewProtocol {
    func success(imageName: String, country: (name: String, shortName: String), temperature: (degrees: String, description: String), humidity: String, clouds: String, pressure: String, wind: String, windDirection: String, textToShare: String) {
        
        imageWeatherView.image = UIImage(systemName: imageName)
        nameCountryLabel.text = "\(country.name), \(country.shortName)"
        temperatureLabel.text =  "\(temperature.degrees)°C | \("\(temperature.description)")"
        humidityLabel.text = "\(humidity)%"
        cloudsLabel.text = "\(clouds)%"
        pressureLabel.text = "\(pressure) hPa"
        windLabel.text = "\(wind) km/h"
        windDirectionLabel.text = windDirection
        shareButton.isEnabled = true
        self.textToShare = textToShare
    }
    
    func failure(error: Error!) {
        imageWeatherView.image = UIImage(systemName: "sun.max")
        nameCountryLabel.text = "-"
        temperatureLabel.text =  "--"
        humidityLabel.text = "-%"
        cloudsLabel.text = "-%"
        pressureLabel.text = "- hPa"
        windLabel.text = "- km/h"
        windDirectionLabel.text = "-"
        failureNetworkResponse(error)
    }
}
