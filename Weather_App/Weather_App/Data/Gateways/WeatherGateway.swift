//
//  WeatherCurrentGateway.swift
//  Weather_App
//
//  Created by An Bảo on 29/04/2024.
//

import Foundation
import RxSwift

protocol WeatherGatewayType {
    func getWeatherCurrent(latitude: Double, longitude: Double) -> Observable<WeatherCurrent>
    func getWeatherForecast(latitude: Double, longitude: Double) -> Observable<WeatherForecast>
}

struct WeatherGateway: WeatherGatewayType {
    func getWeatherCurrent(latitude: Double, longitude: Double) -> Observable<WeatherCurrent> {
        let url = WeatherURLs.shared.getWeatherCurrentURLs(latitude: latitude, longitude: longitude)
        return APIService.shared.request(url: url)
    }
    
    func getWeatherForecast(latitude: Double, longitude: Double) -> Observable<WeatherForecast> {
        let url = WeatherURLs.shared.getWeatherForecastURLs(latitude: latitude, longitude: longitude)
        return APIService.shared.request(url: url)
    }
}
