//
//  WeatherForecast.swift
//  Weather_App
//
//  Created by An Bảo on 29/04/2024.
//

import Foundation
import ObjectMapper

struct WeatherForecast {
    var nameCity: String
    var dayForecast: Int
    var WeatherForecastDatas: [WeatherForecastData] = []
}

extension WeatherForecast: Mappable {
    init?(map: Map) {
        nameCity = ""
        dayForecast = 0
    }
    
    mutating func mapping(map: Map) {
        nameCity <- map["city.name"]
        dayForecast <- map["cnt"]
        WeatherForecastDatas <- map["list"]
    }
}
