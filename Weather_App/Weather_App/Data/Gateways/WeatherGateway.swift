//
//  WeatherCurrentGateway.swift
//  Weather_App
//
//  Created by An Bảo on 29/04/2024.
//

import Foundation
import RxSwift
import CoreData

protocol WeatherGatewayType {
    
    func getWeatherCurrent(latitude: Double, longitude: Double) -> Observable<WeatherCurrent>
    func getWeatherForecast(latitude: Double, longitude: Double) -> Observable<WeatherForecast>
    
    func getContext() -> NSManagedObjectContext
    func fetchWeatherCurrentEntities(predicate: NSPredicate?) -> Observable<[WeatherCurrentEntity]>
    func saveWeatherCurrentEntity(entity: WeatherCurrentEntity) -> Observable<Void>
    func deleteWeatherCurrentEntity(entity: WeatherCurrentEntity) -> Observable<Void>
    func fetchWeatherForecastEntities(predicate: NSPredicate?) -> Observable<[WeatherForecastEntity]>
    func saveWeatherForecastEntity(entity: WeatherForecastEntity) -> Observable<Void>
    func deleteWeatherForecastEntity(entity: WeatherForecastEntity) -> Observable<Void>
}

struct WeatherGateway : WeatherGatewayType {
    
    // MARK: - Get Data from API
    func getWeatherCurrent(latitude: Double, longitude: Double) -> Observable<WeatherCurrent> {
        let url = WeatherURLs.shared.getWeatherCurrentURLs(latitude: latitude, longitude: longitude)
        return APIService.shared.request(url: url)
    }
    
    func getWeatherForecast(latitude: Double, longitude: Double) -> Observable<WeatherForecast> {
        let url = WeatherURLs.shared.getWeatherForecastURLs(latitude: latitude, longitude: longitude)
        return APIService.shared.request(url: url)
    }
    
    // MARK: - Handle Weather Data from Coredata
    
    func getContext() -> NSManagedObjectContext {
        return CoreDataService.shared.context
    }
    
    func fetchWeatherCurrentEntities(predicate: NSPredicate? = nil) -> Observable<[WeatherCurrentEntity]> {
        return CoreDataService.shared.fetchEntities(predicate: predicate)
    }
    
    func saveWeatherCurrentEntity(entity: WeatherCurrentEntity) -> Observable<Void> {
        return CoreDataService.shared.saveEntity(entity: entity)
    }
    
    func deleteWeatherCurrentEntity(entity: WeatherCurrentEntity) -> Observable<Void> {
        return CoreDataService.shared.deleteEntity(entity: entity)
    }
    
    func fetchWeatherForecastEntities(predicate: NSPredicate? = nil) -> Observable<[WeatherForecastEntity]> {
        return CoreDataService.shared.fetchEntities(predicate: predicate)
    }
    
    func saveWeatherForecastEntity(entity: WeatherForecastEntity) -> Observable<Void> {
        return CoreDataService.shared.saveEntity(entity: entity)
    }
    
    func deleteWeatherForecastEntity(entity: WeatherForecastEntity) -> Observable<Void> {
        return CoreDataService.shared.deleteEntity(entity: entity)
    }
}
