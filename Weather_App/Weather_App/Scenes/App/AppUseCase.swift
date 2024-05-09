//
//  AppUseCase.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import Foundation
import RxSwift

protocol AppUseCaseType {
    func deleteEntitiesNotUseWeatherCurrent() -> Observable<Void>
    func deleteEntitiesNotUseWeatherForecast() -> Observable<Void>
}

struct AppUseCase: AppUseCaseType, WeatherUseCase {
    var weatherGateway: WeatherGatewayType
    
    func deleteWeatherCurrent() -> Observable<Void> {
        return deleteEntitiesNotUseWeatherCurrent()
    }
    
    func deleteWeatherForecast() -> Observable<Void> {
        return deleteEntitiesNotUseWeatherForecast()
    }
}
