//
//  WeatherCurrent.swift
//  Weather_App
//
//  Created by An Bảo on 29/04/2024.
//

import Foundation
import ObjectMapper
import Then

struct WeatherCurrent {
    var longitude: Double
    var latitude: Double
    var description: String
    var weatherIcon: String
    var temperature: Double
    var humidity: Int
    var windSpeed: Double
    var clouds: Int
    var dateTime: Int
    var timeOfSunrise: Int
    var timeOfSunset: Int
    var nameCity: String
}

extension WeatherCurrent: Mappable {
    init?(map: Map) {
        longitude = 0.0
        latitude = 0.0
        description = ""
        weatherIcon = ""
        temperature = 0.0
        humidity = 0
        windSpeed = 0.0
        clouds = 0
        dateTime = 0
        timeOfSunrise = 0
        timeOfSunset = 0
        nameCity = ""
    }
    
    mutating func mapping(map: Map) {
        longitude <- map["coord.lon"]
        latitude <- map["coord.lat"]
        description <- map["weather.0.description"]
        weatherIcon <- map["weather.0.icon"]
        temperature <- map["main.temp"]
        humidity <- map["main.humidity"]
        windSpeed <- map["wind.speed"]
        clouds <- map["clouds.all"]
        dateTime <- map["dt"]
        timeOfSunrise <- map["sys.sunrise"]
        timeOfSunset <- map["sys.sunset"]
        nameCity <- map["name"]
    }
}


