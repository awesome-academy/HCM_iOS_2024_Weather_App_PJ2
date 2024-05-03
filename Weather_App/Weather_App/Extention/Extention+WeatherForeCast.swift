//
//  Extention+WeatherForeCast.swift
//  Weather_App
//
//  Created by An Bảo on 05/05/2024.
//

import Foundation
import CoreData
import Then

extension WeatherForecast {
    func map(from objectContext: NSManagedObjectContext) -> WeatherForecastEntity {
        let weatherForecastEntity = WeatherForecastEntity(context: objectContext).then {
            $0.isFavorite = false
            $0.userLocation = false
            $0.dayForecast = Int16(dayForecast)
            $0.nameCity = nameCity
        }
        let weatherForecastDataEntities = weatherForecastDatas.map { weatherForecastData in
            return WeatherForecastDataEntity(context: objectContext).then {
                $0.dateTime = Int16(weatherForecastData.dateTime)
                $0.descriptionStatus = weatherForecastData.description
                $0.temperature = weatherForecastData.temperature
                $0.weatherIcon = weatherForecastData.weatherIcon
                $0.weatherforecast = weatherForecastEntity
            }
        }
        weatherForecastEntity.weatherforecastdata = NSSet(array: weatherForecastDataEntities)
        return weatherForecastEntity
    }
}
