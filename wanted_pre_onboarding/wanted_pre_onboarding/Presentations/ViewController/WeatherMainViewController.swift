//
//  ViewController.swift
//  wanted_pre_onboarding
//
//  Created by jamescode on 2022/06/20.
//

import UIKit

class WeatherMainViewController: UIViewController {
    
    // MARK: - Properties
    private let cityModel = CityModel()
    private var cityWeather: [WeatherData] = []
    
    private lazy var citiesWeatherTableView: UITableView = {
       let tableView = UITableView()
        tableView.layer.cornerRadius = 15
        tableView.backgroundColor = UIColor.clear
        let blur = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = self.view.bounds
        tableView.backgroundView = blurView
        
        tableView.register(CityWeatherTableCell.classForCoder(), forCellReuseIdentifier: CityWeatherTableCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
     configureUI()
    fetchData(citiesList: cityModel.citiesList)
    }
}

extension WeatherMainViewController {
    private func configureUI() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
         navigationController?.navigationBar.shadowImage = UIImage()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.gray.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
       
        view.addSubview(citiesWeatherTableView)
        
        NSLayoutConstraint.activate([
            citiesWeatherTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            citiesWeatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            citiesWeatherTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            citiesWeatherTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
        ])
    }
    
    private func fetchData(citiesList: [String]) {
        
        let group = DispatchGroup()
        
        for city in citiesList {
            //Dispatch Group에 들어가며, task를 +1
            group.enter()
            WeatherManager.shared.fetchWeather(cityName: city) { res in
                switch res {
                case .success(let weatherData):
                    DispatchQueue.global().async(group: group) {
                        self.cityWeather.append(weatherData)
                        //Dispatch Group에서 나오며, task를 -1
                        group.leave()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        //task가 0이 되었을 때 실행
        group.notify(queue: .main) {
            self.citiesWeatherTableView.reloadData()
        }
    }
}

extension WeatherMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension WeatherMainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityWeather.count
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citiesWeatherTableView.dequeueReusableCell(withIdentifier: CityWeatherTableCell.identifier, for: indexPath) as! CityWeatherTableCell
        cell.setUpCell(cityWeather: cityWeather[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(WeatherDetailViewController(), animated: true)
    }
}
