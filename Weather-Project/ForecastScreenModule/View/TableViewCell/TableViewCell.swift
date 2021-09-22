//
//  TableViewCell.swift
//  Weather-Project
//
//  Created by Влад Артемкин on 20.09.21.
//

import UIKit

class TableViewCell: UITableViewCell {

    var weatherImageView = UIImageView()
    var timeLabel = UILabel()
    var descriptionLabel = UILabel()
    var mainStackView = UIStackView()
    var temperatureLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = UIColor(named: "background-color")
        setupAddSubview()
        setupComponents()
        setupConstraints()
    }
    
    private func setupComponents() {
        setWeatherImageView()
        setTimeLabel()
        setDescriptionLabel()
        setMainStackView()
        setTemperatureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: Set Components, Constraints and Subviews
extension TableViewCell {
    private func setWeatherImageView() {
        weatherImageView.preferredSymbolConfiguration = .init(pointSize: 50.0)
        weatherImageView.tintColor = .systemYellow
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setTimeLabel() {
        timeLabel.text = "--:--"
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDescriptionLabel() {
        descriptionLabel.text = "-"
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setMainStackView() {
        mainStackView.addArrangedSubview(timeLabel)
        mainStackView.addArrangedSubview(descriptionLabel)
        mainStackView.axis = .vertical
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setTemperatureLabel() {
        temperatureLabel.text = "--"
        temperatureLabel.font = UIFont(descriptor: UIFontDescriptor(), size: 30)
        temperatureLabel.textColor = .link
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        weatherImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        weatherImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        mainStackView.leftAnchor.constraint(equalTo: weatherImageView.rightAnchor, constant: 20).isActive = true
        mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        temperatureLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        temperatureLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func setupAddSubview() {
        self.addSubview(weatherImageView)
        self.addSubview(mainStackView)
        self.addSubview(temperatureLabel)
    }
}
