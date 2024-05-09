//
//  WeatherUseCase.swift
//  Weather_App
//
//  Created by ho.bao.an on 02/05/2024.
//

import Foundation
import RxSwift
import CoreData

protocol WeatherUseCase {
    var weatherGateway: WeatherGatewayType { get }
}

// MARK: - Get Data from API

extension WeatherUseCase {
    func getWeatherCurrent(latitude: Double, longitude: Double) -> Observable<WeatherCurrent> {
        return weatherGateway.getWeatherCurrent(latitude: latitude, longitude: longitude)
    }
    
    func getWeatherForecast(latitude: Double, longitude: Double) -> Observable<WeatherForecast> {
        return weatherGateway.getWeatherForecast(latitude: latitude, longitude: longitude)
    }
}

// MARK: - Handle Weather Current data from coredata

extension WeatherUseCase {
    func fetchCityWeatherCurrentEntity(forCity nameCity: String) -> Observable<WeatherCurrentEntity?> {
        let predicate = NSPredicate(format: "nameCity == %@", nameCity)
        return weatherGateway.fetchWeatherCurrentEntities(predicate: predicate)
            .map { $0.first }
    }
    
    func fetchFavoriteWeatherCurrentEntities() -> Observable<[WeatherCurrentEntity]> {
        let predicate = NSPredicate(format: "isFavorite == true")
        return weatherGateway.fetchWeatherCurrentEntities(predicate: predicate)
    }
    
    func fetchUserLocationWeatherCurrentEntities() -> Observable<[WeatherCurrentEntity]> {
        let predicate = NSPredicate(format: "userLocation == true")
        return weatherGateway.fetchWeatherCurrentEntities(predicate: predicate)
    }
    
    func saveWeatherCurrentEntity(weatherCurrent: WeatherCurrent) -> Observable<Void> {
        let context = weatherGateway.getContext()
        let mappedEntity = weatherCurrent.map(from: context)
        return weatherGateway.saveWeatherCurrentEntity(entity: mappedEntity)
    }
    
    func updateIsFavoriteWeatherCurrent(for cityName: String, isFavorite: Bool) -> Observable<Void> {
        let predicate = NSPredicate(format: "nameCity == %@", cityName)
        return weatherGateway.fetchWeatherCurrentEntities(predicate: predicate)
            .flatMap { entities -> Observable<Void> in
                guard let entity = entities.first else {
                    return Observable.error(CoreDataError.entityNotFound)
                }
                entity.setValue(isFavorite, forKey: "isFavorite")
                return weatherGateway.saveWeatherCurrentEntity(entity: entity)
            }
    }
    
    func updateUserLocationWeatherCurrent(for cityName: String, userLocation: Bool) -> Observable<Void> {
        let predicate = NSPredicate(format: "nameCity == %@", cityName)
        return weatherGateway.fetchWeatherCurrentEntities(predicate: predicate)
            .flatMap { entities -> Observable<Void> in
                guard let entity = entities.first else {
                    return Observable.error(CoreDataError.entityNotFound)
                }
                entity.setValue(userLocation, forKey: "userLocation")
                return weatherGateway.saveWeatherCurrentEntity(entity: entity)
            }
    }
    
    func deleteWeatherCurrentEntity(_ entity: WeatherCurrentEntity) -> Observable<Void> {
        return weatherGateway.deleteWeatherCurrentEntity(entity: entity)
    }
    
    func deleteCurrentUserLocationWeatherCurrent() -> Observable<Void> {
        let predicate = NSPredicate(format: "isFavorite == false AND userLocation == true")
        return weatherGateway.fetchWeatherCurrentEntities(predicate: predicate)
            .flatMap { entities -> Observable<Void> in
                if (entities.isEmpty) {
                    return Observable.just(())
                } else {
                    return Observable.from(entities.map { weatherGateway.deleteAllWeatherCurrent(entity: $0) }).merge()
                }
            }
    }
    
    func deleteEntitiesNotUseWeatherCurrent() -> Observable<Void> {
        let predicate = NSPredicate(format: "isFavorite == false AND userLocation == false")
        return weatherGateway.fetchWeatherCurrentEntities(predicate: predicate)
            .flatMap { entities -> Observable<Void> in
                if (entities.isEmpty) {
                    return Observable.just(())
                } else {
                    return Observable.from(entities.map { weatherGateway.deleteAllWeatherCurrent(entity: $0) }).merge()
                }
            }
    }
}

// MARK: - Handle Weather Forecast data from coredata

extension WeatherUseCase {
    func fetchCityWeatherForecastEntity(forCity nameCity: String) -> Observable<WeatherForecastEntity?> {
        let predicate = NSPredicate(format: "nameCity == %@", nameCity)
        return weatherGateway.fetchWeatherForecastEntities(predicate: predicate)
            .map { $0.first }
    }
    
    func fetchFavoriteWeatherForecastEntities() -> Observable<[WeatherForecastEntity]> {
        let predicate = NSPredicate(format: "isFavorite == true")
        return weatherGateway.fetchWeatherForecastEntities(predicate: predicate)
    }
    
    func fetchUserLocationWeatherForecastEntities() -> Observable<[WeatherForecastEntity]> {
        let predicate = NSPredicate(format: "userLocation == true")
        return weatherGateway.fetchWeatherForecastEntities(predicate: predicate)
    }
    
    func saveWeatherForecastEntity(weatherForecast: WeatherForecast) -> Observable<Void> {
        let context = weatherGateway.getContext()
        let mappedEntity = weatherForecast.map(from: context)
        return weatherGateway.saveWeatherForecastEntity(entity: mappedEntity)
    }
    
    func updateIsFavoriteWeatherForecast(for cityName: String, isFavorite: Bool) -> Observable<Void> {
        let predicate = NSPredicate(format: "nameCity == %@", cityName)
        return weatherGateway.fetchWeatherForecastEntities(predicate: predicate)
            .flatMap { entities -> Observable<Void> in
                guard let entity = entities.first else {
                    return Observable.error(CoreDataError.entityNotFound)
                }
                entity.setValue(isFavorite, forKey: "isFavorite")
                return weatherGateway.saveWeatherForecastEntity(entity: entity)
            }
    }
    
    func updateUserLocationWeatherForecast(for cityName: String, userLocation: Bool) -> Observable<Void> {
        let predicate = NSPredicate(format: "nameCity == %@", cityName)
        return weatherGateway.fetchWeatherForecastEntities(predicate: predicate)
            .flatMap { entities -> Observable<Void> in
                guard let entity = entities.first else {
                    return Observable.error(CoreDataError.entityNotFound)
                }
                entity.setValue(userLocation, forKey: "userLocation")
                return weatherGateway.saveWeatherForecastEntity(entity: entity)
            }
    }
    
    func deleteWeatherForecastEntity(_ entity: WeatherForecastEntity) -> Observable<Void> {
        return weatherGateway.deleteWeatherForecastEntity(entity: entity)
    }
    
    func deleteCurrentUserLocationWeatherForecast() -> Observable<Void> {
        let predicate = NSPredicate(format: "isFavorite == false AND userLocation == true")
        return weatherGateway.fetchWeatherForecastEntities(predicate: predicate)
            .flatMap { entities -> Observable<Void> in
                if (entities.isEmpty) {
                    return Observable.just(())
                } else {
                    return Observable.from(entities.map { weatherGateway.deleteAllWeatherForecast(entity: $0) }).merge()
                }
            }
    }
    
    func deleteEntitiesNotUseWeatherForecast() -> Observable<Void> {
        let predicate = NSPredicate(format: "isFavorite == false AND userLocation == false")
        return weatherGateway.fetchWeatherForecastEntities(predicate: predicate)
            .flatMap { entities -> Observable<Void> in
                if (entities.isEmpty) {
                    return Observable.just(())
                } else {
                    return Observable.from(entities.map { weatherGateway.deleteAllWeatherForecast(entity: $0) }).merge()
                }
            }
    }
}
