//
//  wantedPreOnboarding++Bundle.swift
//  wanted_pre_onboarding
//
//  Created by jamescode on 2022/06/20.
//

import Foundation

extension Bundle {
    var apiKey: String {
        guard let file = self.path(forResource: "WeatherInfo", ofType: "plist") else { return "" }
        guard let resource  = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["API_KEY"] as? String else { fatalError("WeatherInfo.plist에 API_KEY를 설정해 주세요")}
        return key

    }
}
