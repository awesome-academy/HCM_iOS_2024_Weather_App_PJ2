//
//  Extention+WeatherForcastDataEntity.swift
//  Weather_App
//
//  Created by ho.bao.an on 15/05/2024.
//

import Foundation

extension WeatherForecastDataEntity {
    var temperatureInCelsius: String {
        let temperatureCelsius = Int(self.temperature)
        return "\(temperatureCelsius)℃"
    }
    
    var dateString: String {
        let timestamp = TimeInterval(self.dateTime)
        let date = Date.dateFromTimestamp(timestamp)
        let dateString = date.convertToDayString()
        return dateString
    }
}
