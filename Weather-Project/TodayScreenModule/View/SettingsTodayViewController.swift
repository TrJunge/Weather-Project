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
        navBar.barTintColor = UIColor(named: "background-color")
        navBar.translatesAutoresizingMaskIntoConstraints = false
        let navItem = UINavigationItem(title: "Today")
        navBar.setItems([navItem], animated: true);
        return navBar
    }
    
    func setImageWeatherView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: "sun.min"))
        imageView.preferredSymbolConfiguration = .init(pointSize: CGFloat(120))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "image-color")
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
        let label = UILabel()
        label.textAlignment = .center
        label.text = "--"
        label.font = UIFont(descriptor: UIFontDescriptor(), size: 26)
        label.textColor = UIColor(named: "temperature-label-color")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func setMainTopStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [imageWeatherView, nameCountryLabel, temperatureLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
        imageView.tintColor = UIColor(named: "image-color")

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
        imageView.tintColor = UIColor(named: "image-color")

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
        imageView.tintColor =  UIColor(named: "image-color")

        let stackView = UIStackView(arrangedSubviews: [imageView, pressureLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }
    
    func setFirstMiddleStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [humidityStackView, cloudyStackView, pressureStackView])
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
        imageView.tintColor = UIColor(named: "image-color")

        let stackView = UIStackView(arrangedSubviews: [imageView, windLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func setWindDirectionLabel() -> UILabel {
        let label = UILabel()
        label.text = "--"
        label.textAlignment = .center
        label.font = UIFont(descriptor: UIFontDescriptor(), size: 10)
        return label
    }
    
    func setWindDirectionStackView() -> UIStackView {
        let imageView = UIImageView()
        imageView.preferredSymbolConfiguration = .init(pointSize: CGFloat(20))
        imageView.image = UIImage(systemName: "safari")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "image-color")

        let stackView = UIStackView(arrangedSubviews: [imageView, windDirectionLabel])
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func setSecondMiddleStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [windStackView, windDirectionStackView])
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func setMainMiddleStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [firstMiddleStackView, secondMiddleStackView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func setShareButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: Selector(("share")), for: .touchUpInside)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

// MARK: setupSubviews and setupConstraint
extension TodayViewController {
    func setupSubviews() {
        view.addSubview(navigationBar)
        view.addSubview(mainTopStackView)
        view.addSubview(mainMiddleStackView)
        view.addSubview(shareButton)
    }
    
    func setupConstraints() {
        let indentForMainBlocks = view.frame.height/15
  
        navigationBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        mainTopStackView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: indentForMainBlocks).isActive = true
        mainTopStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainTopStackView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        mainMiddleStackView.topAnchor.constraint(equalTo: mainTopStackView.bottomAnchor, constant: indentForMainBlocks).isActive = true
        mainMiddleStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainMiddleStackView.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true

        humidityStackView.widthAnchor.constraint(equalToConstant: (view.frame.width - 40) / 3).isActive = true
        cloudyStackView.widthAnchor.constraint(equalToConstant: (view.frame.width - 40) / 3).isActive = true
        pressureStackView.widthAnchor.constraint(equalToConstant: (view.frame.width - 40) / 3).isActive = true
        
        secondMiddleStackView.widthAnchor.constraint(equalToConstant: view.frame.width - 150).isActive = true
        
        windStackView.widthAnchor.constraint(equalToConstant: (view.frame.width - 150) / 2).isActive = true
        windDirectionStackView.widthAnchor.constraint(equalToConstant: (view.frame.width - 150) / 2).isActive = true
        
        shareButton.topAnchor.constraint(equalTo: mainMiddleStackView.bottomAnchor, constant: indentForMainBlocks).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
