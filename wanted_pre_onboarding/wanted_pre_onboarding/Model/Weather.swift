//
//  WeatherData.swift
//  wanted_pre_onboarding
//
//  Created by jamescode on 2022/06/21.
//

import Foundation

struct WeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let name: String //도시이름
}

struct Weather: Codable {
    
    let id: Int
    //날씨, 날씨 설명, 아이콘
    let main, weatherDescription, icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

struct Main: Codable {
    
    // 현재기온, 체감기온, 최저기온, 최고기온
    let temp, feelsLike, tempMin, tempMax: Double
    //기압, 현재 습도
    let pressure, humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

struct Wind: Codable {
    //풍속
    let speed: Double
}
