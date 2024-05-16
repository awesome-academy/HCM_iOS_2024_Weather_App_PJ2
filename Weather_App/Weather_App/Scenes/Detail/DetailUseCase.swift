//
//  DetailUseCase.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailUseCaseType {
    func getWeatherForecastData(latitude: Double, longitude: Double) -> Observable<WeatherForecast>
}

struct DetailUseCase: DetailUseCaseType, WeatherUseCase {
    var weatherGateway: WeatherGatewayType
    
    func getWeatherForecastData(latitude: Double, longitude: Double) -> Observable<WeatherForecast> {
        return getWeatherForecast(latitude: latitude, longitude: longitude)
    }
}
