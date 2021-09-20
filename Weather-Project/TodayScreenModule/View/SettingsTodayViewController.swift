//
//  SettingsTodayViewController.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 19.09.21.
//

import UIKit

extension TodayViewController {
    func setNavigationBar() -> UINavigationBar {
        let navBar = UINavigationBar()
        navBar.prefersLargeTitles = false
        navBar.isTranslucent = false
        navBar.barTintColor = .systemBackground
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let navItem = UINavigationItem(title: "Today")
        navBar.setItems([navItem], animated: true);
        return navBar
    }
    
    func setImageWeatherView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: "sun.min"))
        imageView.preferredSymbolConfiguration = .init(pointSize: CGFloat(120))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow
        return imageView
    }
    
    func setNameCountryLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "--"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func setTemperatureLabel() -> UILabel {
        let label = UILabel(frame: CGRect(origin: CGPoint(), size: CGSize(width: view.frame.width, height: 50)))
        label.textAlignment = .center
        label.text = "--"
        label.font = UIFont(descriptor: UIFontDescriptor(), size: 26)
        label.textColor = .link
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func setMainTopStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [imageWeatherView, nameCountryLabel, temperatureLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }
    
    func setHumidityLabel() -> UILabel {
        let label = UILabel()
        label.text = "--"
        label.textAlignment = .center
        label.font = UIFont(descriptor: UIFontDescriptor(), size: 10)
        return label
    }
    
    func setHumidityStackView() -> UIStackView {
        let imageView = UIImageView()
        imageView.preferredSymbolConfiguration = .init(pointSize: CGFloat(20))
        imageView.image = UIImage(systemName: "cloud.heavyrain")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow

        let stackView = UIStackView(arrangedSubviews: [imageView, humidityLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }
    
    func setCloudsLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "--"
        label.font = UIFont(descriptor: UIFontDescriptor(), size: 10)
        return label
    }
    
    func setCloudyStackView() -> UIStackView {
        let imageView = UIImageView()
        imageView.preferredSymbolConfiguration = .init(pointSize: CGFloat(20))
        imageView.image = UIImage(systemName: "smoke")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow

        let stackView = UIStackView(arrangedSubviews: [imageView, cloudsLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }
    
    func setPressureLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "--"
        label.font = UIFont(descriptor: UIFontDescriptor(), size: 10)
        return label
    }
    
    
    func setPressureStackView() -> UIStackView {
        let imageView = UIImageView()
        imageView.preferredSymbolConfiguration = .init(pointSize: CGFloat(20))
        imageView.image = UIImage(systemName: "thermometer")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow

        let stackView = UIStackView(arrangedSubviews: [imageView, pressureLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }
    
    func setFirstMiddleStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [humidityStackView, cloudyStackView, pressureStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .center
        return stackView
    }
    
    func setWindLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "--"
        label.font = UIFont(descriptor: UIFontDescriptor(), size: 10)
        return label
    }
    
    func setWindStackView() -> UIStackView {
        let imageView = UIImageView()
        imageView.preferredSymbolConfiguration = .init(pointSize: CGFloat(20))
        imageView.image = UIImage(systemName: "wind")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow

        let stackView = UIStackView(arrangedSubviews: [imageView, windLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }
    
    func setPolesLabel() -> UILabel {
        let label = UILabel()
        label.text = "--"
        label.textAlignment = .center
        label.font = UIFont(descriptor: UIFontDescriptor(), size: 10)
        return label
    }
    
    func setPolesStackView() -> UIStackView {
        let imageView = UIImageView()
        imageView.preferredSymbolConfiguration = .init(pointSize: CGFloat(20))
        imageView.image = UIImage(systemName: "safari")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow

        let stackView = UIStackView(arrangedSubviews: [imageView, polesLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }
    
    func setSecondMiddleStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [windStackView, polesStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .center
        return stackView
    }
    
    func setMainMiddleStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [firstMiddleStackView, secondMiddleStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }
    
    func setShareButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

// MARK: setupSubviews and setupConstraint
extension TodayViewController {
    func setupSubviews() {
        self.view.addSubview(navigationBar)
        self.view.addSubview(mainTopStackView)
        self.view.addSubview(mainMiddleStackView)
        self.view.addSubview(shareButton)
    }
    
    func setupConstraints() {
        navigationBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        mainTopStackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 70).isActive = true
        mainTopStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainTopStackView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        mainMiddleStackView.topAnchor.constraint(equalTo: mainTopStackView.bottomAnchor, constant: 70).isActive = true
        mainMiddleStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        mainMiddleStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        mainMiddleStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        mainMiddleStackView.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true

        humidityStackView.widthAnchor.constraint(equalToConstant: (view.frame.width - 40) / 3).isActive = true
        cloudyStackView.widthAnchor.constraint(equalToConstant: (view.frame.width - 40) / 3).isActive = true
        pressureStackView.widthAnchor.constraint(equalToConstant: (view.frame.width - 40) / 3).isActive = true
        
        secondMiddleStackView.widthAnchor.constraint(equalToConstant: view.frame.width - 150).isActive = true
        
        windStackView.widthAnchor.constraint(equalToConstant: (view.frame.width - 150) / 2).isActive = true
        polesStackView.widthAnchor.constraint(equalToConstant: (view.frame.width - 150) / 2).isActive = true
        
        shareButton.topAnchor.constraint(equalTo: mainMiddleStackView.bottomAnchor, constant: 50).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
