//
//  Extention+WeatherCurrent.swift
//  Weather_App
//
//  Created by ho.bao.an on 03/05/2024.
//

import Foundation
import CoreData
import Then

extension WeatherCurrent {
    func map(from objectContext: NSManagedObjectContext) -> WeatherCurrentEntity {
        return WeatherCurrentEntity(context: objectContext).then {
            $0.latitude = latitude
            $0.longitude = longitude
            $0.nameCity = nameCity
            $0.temperature = temperature
            $0.descriptionStatus = description
            $0.weatherIcon = weatherIcon
            $0.humidity = Int16(humidity)
            $0.clouds = Int16(clouds)
            $0.windSpeed = windSpeed
            $0.dateTime = Int16(dateTime)
            $0.timeOfSunrise = Int16(timeOfSunrise)
            $0.timeOfSunset = Int16(timeOfSunset)
        }
    }
}
