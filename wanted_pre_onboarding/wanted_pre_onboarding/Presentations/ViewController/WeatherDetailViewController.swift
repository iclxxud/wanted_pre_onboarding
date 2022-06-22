//
//  WeatherDetailViewController.swift
//  wanted_pre_onboarding
//
//  Created by jamescode on 2022/06/21.
//

import UIKit

//- 두번째 화면(선택한 도시의 현재 날씨 상세 정보)
//1.도시이름, 2.날씨 아이콘, 3.현재기온, 4.헌재습도
//5.체감기온(main > feels_like),
//6.최저기온(main > temp_min),
//7.최고기온(main > temp_max),
//8.기압(main > pressure),
//9.풍속(wind > speed),
//10.날씨설명(weather > description)

class WeatherDetailViewController: UIViewController {
    // MARK: - Properties
    let weatherInfo: WeatherData
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 50)
        label.text = "\(weatherInfo.name)"
        return label
    }()
    
    private lazy var weatherDescLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        label.text = "\(weatherInfo.weather.first?.weatherDescription.description ?? "")"
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        label.text = "현재 기온: \(String(format: "%.0f", weatherInfo.main.temp))°"
        return label
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        label.text = "현재 습도: \(weatherInfo.main.humidity)%"
        return label
    }()
    
    private lazy var feelsTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        label.text = "체감 기온: \(weatherInfo.main.feelsLike)"
        return label
    }()
    
    private lazy var minTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.text = "최저 기온: \(String(format: "%.0f", weatherInfo.main.tempMin))°"
        return label
    }()
    
    private lazy var maxTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.text = "최고 기온: \(String(format: "%.0f", weatherInfo.main.tempMax))°"
        
        return label
    }()
    
    private lazy var pressureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.text = "기압: \(weatherInfo.main.pressure)"
        return label
    }()
    
    private lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.text = "풍속: \(weatherInfo.wind.speed)"
        return label
    }()
    
    
    // MARK: - Life Cycle
    init(weatherInfo: WeatherData) {
        self.weatherInfo = weatherInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setIcon()
    }
    
}

// MARK: - Methods
extension WeatherDetailViewController {
    private func configureUI() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.gray.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 100),
            iconImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
        
        stackView.addArrangedSubview(cityNameLabel)
        stackView.addArrangedSubview(weatherDescLabel)
        stackView.addArrangedSubview(tempLabel)
        stackView.addArrangedSubview(humidityLabel)
        stackView.addArrangedSubview(feelsTempLabel)
        stackView.addArrangedSubview(minTempLabel)
        stackView.addArrangedSubview(maxTempLabel)
        stackView.addArrangedSubview(pressureLabel)
        stackView.addArrangedSubview(windSpeedLabel)
        
    }
    
    private func setIcon() {
        guard let iconID = weatherInfo.weather.first?.icon else { return }
        let iconUrl = "http://openweathermap.org/img/wn/\(iconID)@2x.png"
        iconImageView.setImageUrl(iconUrl)
    }
}
