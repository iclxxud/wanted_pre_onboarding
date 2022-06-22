//
//  WeatherManager.swift
//  wanted_pre_onboarding
//
//  Created by jamescode on 2022/06/21.
//

import Foundation

struct WeatherManager {
    static let shared = WeatherManager()
    
    let weatherBaseURL = "http://api.openweathermap.org/data/2.5/weather?"
    let appid = Bundle.main.apiKey
    
    func fetchWeather(cityName: String, completion: @escaping (Result<WeatherData, Error>) -> ()) {
        guard let url = URL(string:  "\(weatherBaseURL)q=\(cityName)&appid=\(appid)&units=metric&lang=KR") else {
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!)
                return
            }
            
            if let safeData = data {
                let jsonSafeData =  try? JSONDecoder().decode(WeatherData.self, from: safeData)
                guard let weatherData = jsonSafeData else {
                    return
                }
                completion(.success(weatherData))
            }
        }
        task.resume()
    }
}
