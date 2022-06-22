//
//  CityWeatherTableCell.swift
//  wanted_pre_onboarding
//
//  Created by jamescode on 2022/06/21.
//

import UIKit

class CityWeatherTableCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "cityWeatherTableCell"
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var humidityIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "humidity.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let humidityIcon = UIImage(named: "humidity.fill")
    
    lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Life Cycle
    
    //초기화 코드
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CityWeatherTableCell {
    func setUpCell(cityWeather: WeatherData) {
        backgroundColor = .clear
        cityLabel.text = cityWeather.name
        tempLabel.text = "\(String(format: "%.0f", cityWeather.main.temp))°"
        humidityLabel.text = "\(cityWeather.main.humidity)%"
        
        guard let iconID = cityWeather.weather.first?.icon else { return }
        let iconUrl = "http://openweathermap.org/img/wn/\(iconID)@2x.png"
        iconImageView.setImageUrl(iconUrl)
        
    }
    
    func configureUI() {
        contentView.addSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        ])
        
        contentView.addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            iconImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        contentView.addSubview(tempLabel)
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor),
            tempLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor)
        ])
        
        contentView.addSubview(humidityIconImageView)
        NSLayoutConstraint.activate([
            humidityIconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            humidityIconImageView.leadingAnchor.constraint(equalTo: tempLabel.trailingAnchor, constant: 70),
            humidityIconImageView.widthAnchor.constraint(equalToConstant: 30),
            humidityIconImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        contentView.addSubview(humidityLabel)
        NSLayoutConstraint.activate([
            humidityLabel.centerXAnchor.constraint(equalTo: humidityIconImageView.centerXAnchor),
            humidityLabel.topAnchor.constraint(equalTo: humidityIconImageView.bottomAnchor, constant: 10)
        ])
        
    }
    
}
