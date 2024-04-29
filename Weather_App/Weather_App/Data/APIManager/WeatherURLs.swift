//
//  WeatherUrls.swift
//  Weather_App
//
//  Created by An Bảo on 02/05/2024.
//

import Foundation

final class WeatherURLs {
    static let shared = WeatherURLs()
    
    private let apiKey: String
    private let url: String
    
    private init() {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            fatalError("API_KEY is missing in Info.plist")
        }
        
        guard let url = Bundle.main.infoDictionary?["URL"] as? String else {
            fatalError("URL is missing in Info.plist")
        }
        
        self.apiKey = apiKey
        self.url = url.replacingOccurrences(of: "\\", with: "")
    }

    func getWeatherCurrentURLs(latitude: Double, longitude: Double) -> String  {
        return "\(url)/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(apiKey)"
    }
    
    func getWeatherForecastURLs(latitude: Double, longitude: Double) -> String  {
        return "\(url)/data/2.5/forecast/daily?lat=\(latitude)&lon=\(longitude)&cnt=7&units=metric&appid=\(apiKey)"
    }
}
