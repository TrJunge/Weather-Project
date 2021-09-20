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
        self.setupAddSubview()
        
        self.setWeatherImageView()
        self.setTimeLabel()
        self.setDescriptionLabel()
        self.setMainStackView()
        self.setTemperatureLabel()
        
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: Set Components, Constraints and Subviews
extension TableViewCell {
    func setWeatherImageView() {
        weatherImageView.preferredSymbolConfiguration = .init(pointSize: 50.0)
        weatherImageView.tintColor = .systemYellow
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setTimeLabel() {
        timeLabel.text = "--:--"
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setDescriptionLabel() {
        descriptionLabel.text = "-"
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setMainStackView() {
        mainStackView.addArrangedSubview(timeLabel)
        mainStackView.addArrangedSubview(descriptionLabel)
        mainStackView.axis = .vertical
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setTemperatureLabel() {
        temperatureLabel.text = "--"
        temperatureLabel.font = UIFont(descriptor: UIFontDescriptor(), size: 30)
        temperatureLabel.textColor = .link
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        weatherImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        weatherImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        mainStackView.leftAnchor.constraint(equalTo: weatherImageView.rightAnchor, constant: 20).isActive = true
        mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        temperatureLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        temperatureLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setupAddSubview() {
        self.addSubview(weatherImageView)
        self.addSubview(mainStackView)
        self.addSubview(temperatureLabel)
    }
}
