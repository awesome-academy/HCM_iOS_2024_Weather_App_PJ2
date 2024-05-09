//
//  Extention+WeatherCurrentEntity.swift
//  Weather_App
//
//  Created by ho.bao.an on 09/05/2024.
//

import Foundation

extension WeatherCurrentEntity {
    var temperatureInCelsius: String {
        let temperatureCelsius = Int(self.temperature)
        return "\(temperatureCelsius)℃"
    }
    
    var humidityString: String {
        return "\(self.humidity)%"
    }
    
    var cloudsString: String {
        return "\(self.clouds)%"
    }
    
    var windString: String {
        return "\(self.windSpeed) m/s"
    }
    
    var dateString: String {
        let timestamp = TimeInterval(self.dateTime)
        let date = Date.dateFromTimestamp(timestamp)
        let dateString = date.convertToDateString()
        return dateString
    }
    
    var sunriseString: String {
        let timestamp = TimeInterval(self.timeOfSunrise)
        let date = Date.dateFromTimestamp(timestamp)
        let timeString = date.convertToTimeString()
        return timeString
    }
    
    var sunsetString: String {
        let timestamp = TimeInterval(self.timeOfSunrise)
        let date = Date.dateFromTimestamp(timestamp)
        let timeString = date.convertToTimeString()
        return timeString
    }
}
