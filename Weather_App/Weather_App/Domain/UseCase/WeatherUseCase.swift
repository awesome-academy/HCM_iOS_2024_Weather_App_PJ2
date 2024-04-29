//
//  WeatherUseCase.swift
//  Weather_App
//
//  Created by ho.bao.an on 02/05/2024.
//

import Foundation
import RxSwift

protocol WeatherUseCase {
    var weatherGateway: WeatherGateway { get }
}

extension WeatherUseCase {
    func getWeatherCurrent(latitude: Double, longitude: Double) -> Observable<WeatherCurrent> {
        return weatherGateway.getWeatherCurrent(latitude: latitude, longitude: longitude)
    }
    
    func getWeatherForecast(latitude: Double, longitude: Double) -> Observable<WeatherForecast> {
        return weatherGateway.getWeatherForecast(latitude: latitude, longitude: longitude)
    }
}
