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
            $0.isFavorite = false
            $0.userLocation = false
            $0.latitude = latitude
            $0.longitude = longitude
            $0.nameCity = nameCity
            $0.temperature = temperature
            $0.descriptionStatus = description
            $0.weatherIcon = weatherIcon
            $0.humidity = Int64(humidity)
            $0.clouds = Int64(clouds)
            $0.windSpeed = windSpeed
            $0.dateTime = Int64(dateTime)
            $0.timeOfSunrise = Int64(timeOfSunrise)
            $0.timeOfSunset = Int64(timeOfSunset)
        }
    }
}
