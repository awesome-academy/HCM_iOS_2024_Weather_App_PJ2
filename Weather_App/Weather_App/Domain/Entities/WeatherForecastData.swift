//
//  WeatherForecastData.swift
//  Weather_App
//
//  Created by An Bảo on 29/04/2024.
//

import Foundation
import ObjectMapper

struct WeatherForecastData {
    var dateTime: Int
    var temperature: Double
    var description: String
    var weatherIcon: String
}

extension WeatherForecastData: Mappable {
    init?(map: Map) {
        dateTime = 0
        temperature = 0.0
        description = ""
        weatherIcon = ""
    }

    mutating func mapping(map: Map) {
        dateTime <- map["dt"]
        temperature <- map["temp.day"]
        description <- map["weather.0.description"]
        weatherIcon <- map["weather.0.icon"]
    }
}
