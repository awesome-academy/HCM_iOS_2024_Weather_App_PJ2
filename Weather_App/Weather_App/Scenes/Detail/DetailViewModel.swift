//
//  DetailViewModel.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import RxSwift
import RxCocoa
import UIKit

enum WeatherCellType {
    case mainCell(WeatherCurrentEntity)
    case detailCell(WeatherCurrentEntity)
    case forecastCell(WeatherForecastData)
}

struct DetailViewModel {
    let navigator: DetailNavigatorType
    let useCase: DetailUseCaseType
    let weatherCurrentEntity: WeatherCurrentEntity
}

extension DetailViewModel: ViewModelType {
    struct Input {
        let getForecastWeatherDataTrigger: Driver<Void>
    }
    
    struct Output {
        let cells: Driver<[WeatherCellType]>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let cells = input.getForecastWeatherDataTrigger
            .flatMapLatest {
                return self.useCase.getWeatherForecastData(latitude: weatherCurrentEntity.latitude,
                                                           longitude: weatherCurrentEntity.longitude)
                .map { forecastData in
                    var cells: [WeatherCellType] = [
                        .mainCell(weatherCurrentEntity),
                        .detailCell(weatherCurrentEntity)
                    ]
                    cells.append(contentsOf: forecastData.weatherForecastDatas.map { .forecastCell($0) })
                    return cells
                }
                .trackError(errorTracker)
                .trackIndicator(activityIndicator)
                .asDriverOnErrorJustComplete()
            }
        return Output(cells: cells)
    }
}
