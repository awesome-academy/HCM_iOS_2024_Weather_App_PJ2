//
//  MapUseCase.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import Foundation
import RxSwift

protocol MapUseCaseType {
    func getWeatherCurrentData(latitude: Double, longitude: Double) -> Observable<WeatherCurrent>
    func fetchCityWeatherCurrent(forCity nameCity: String) -> Observable<WeatherCurrentEntity?>
    func saveWeatherCurrent(weatherCurrent: WeatherCurrent) -> Observable<Void>
    func updateFavoriteStatus(for cityName: String, isFavorite: Bool) -> Observable<Void>
    func updateUserLocationStatus(for cityName: String, userLocation: Bool) -> Observable<Void>
    func deleteUserLocationDuplicate() -> Observable<Void>
}

struct MapUseCase: MapUseCaseType, WeatherUseCase{
    var weatherGateway: WeatherGatewayType
    
    func getWeatherCurrentData(latitude: Double, longitude: Double) -> Observable<WeatherCurrent> {
        return getWeatherCurrent(latitude: latitude, longitude: longitude)
    }
    
    func fetchCityWeatherCurrent(forCity nameCity: String) -> Observable<WeatherCurrentEntity?> {
        return fetchCityWeatherCurrentEntity(forCity: nameCity)
    }
    
    func saveWeatherCurrent(weatherCurrent: WeatherCurrent) -> Observable<Void> {
        return saveWeatherCurrentEntity(weatherCurrent: weatherCurrent )
    }
    
    func updateFavoriteStatus(for cityName: String, isFavorite: Bool) -> Observable<Void> {
        return updateIsFavoriteWeatherCurrent(for: cityName, isFavorite: isFavorite)
    }
    
    func updateUserLocationStatus(for cityName: String, userLocation: Bool) -> Observable<Void> {
        return updateUserLocationWeatherCurrent(for: cityName, userLocation: userLocation)
    }
    
    func deleteUserLocationDuplicate() -> Observable<Void> {
        return deleteCurrentUserLocationWeatherCurrent()
    }
}
