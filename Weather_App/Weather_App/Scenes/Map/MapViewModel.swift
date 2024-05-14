//
//  MapViewModel.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
import CoreLocation

struct MapViewModel {
    let navigator: MapNavigatorType
    let useCase: MapUseCaseType
}

extension MapViewModel: ViewModelType {
    struct Input {
        let getCurrentLocationTrigger: Driver<Void>
        let getWeatherCurrentTrigger: Driver<(latitude: Double, longitude: Double, statusUserLocation: Bool)>
        let getFavoriteStatusTrigger: Driver<Void>
        let getFavoriteStatusTriggerUpdated: Driver<Void>
        let updateStatusButtonTrigger: Driver<Void>
        let getSearchTextTrigger: Driver<String>
    }
    
    struct Output {
        let currentLocation: Driver<CLLocation>
        let weatherCurrentData: Driver<WeatherCurrentEntity?>
        let statusFavorite: Driver<Bool>
        let statusFavoriteUpdated: Driver<Bool>
        let locationResult: Driver<CLLocation>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        var nameCity = ""
        var statusFavorite = false
        let locationUpdated = PublishSubject<CLLocation>()
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let currentLocation = input.getCurrentLocationTrigger
            .flatMapLatest {
                return LocationManager.shared.getCurrentLocation()
                    .trackError(errorTracker)
                    .trackIndicator(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
        
        let getWeatherData = input.getWeatherCurrentTrigger
            .flatMapLatest { (latitude, longitude, statusUserLocation) -> Driver<(WeatherCurrent, Bool)> in
                return self.useCase.getWeatherCurrentData(latitude: latitude, longitude: longitude)
                    .trackError(errorTracker)
                    .trackIndicator(activityIndicator)
                    .asDriverOnErrorJustComplete()
                    .map { weatherData in
                        return (weatherData, statusUserLocation)
                    }
            }
        
        let deleteSuccess = getWeatherData
            .flatMapLatest { weatherData, statusUserLocation in
                self.useCase.deleteUserLocationDuplicate()
                    .map { (weatherData, statusUserLocation) }
                    .trackError(errorTracker)
                    .trackIndicator(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
        
        let saveSuccess = deleteSuccess
            .flatMapLatest { weatherData, statusUserLocation in
                self.useCase.saveWeatherCurrent(weatherCurrent: weatherData)
                    .map { (weatherData, statusUserLocation) }
                    .trackError(errorTracker)
                    .trackIndicator(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
        
        let updateSuccess = saveSuccess
            .flatMapLatest { weatherData, statusUserLocation in
                self.useCase.updateUserLocationStatus(for: weatherData.nameCity, userLocation: statusUserLocation)
                    .map { weatherData }
                    .trackError(errorTracker)
                    .trackIndicator(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
        
        let weatherCurrentData = updateSuccess
            .flatMapLatest { weatherData in
                nameCity = weatherData.nameCity
                return self.useCase.fetchCityWeatherCurrent(forCity: weatherData.nameCity)
                    .trackError(errorTracker)
                    .trackIndicator(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
        
        let getStatusFavorite = updateSuccess
            .flatMapLatest { weatherData in
                let cityName = weatherData.nameCity
                return self.useCase.fetchCityWeatherCurrent(forCity: cityName)
                    .trackError(errorTracker)
                    .trackIndicator(activityIndicator)
                    .asDriverOnErrorJustComplete()
                    .map { weatherCurrentEntity -> Bool in
                        guard let isFavorite = weatherCurrentEntity?.isFavorite else {
                            return false
                        }
                        statusFavorite = isFavorite
                        return isFavorite
                    }
            }
        
        let getStatusFavoriteUpdated = input.updateStatusButtonTrigger
            .flatMapLatest {
                statusFavorite.toggle()
                return self.useCase.updateFavoriteStatus(for: nameCity, isFavorite: statusFavorite)
                    .trackError(errorTracker)
                    .trackIndicator(activityIndicator)
                    .asDriverOnErrorJustComplete()
                    .map { statusFavorite }
            }
        
        input.getSearchTextTrigger
            .flatMapLatest{ searchText in
                navigator.toSearchViewController(searchText: searchText)
            }
            .drive(onNext: { location in
                locationUpdated.onNext(location)
            })
            .disposed(by: disposeBag)
        
        return Output(
            currentLocation: currentLocation,
            weatherCurrentData: weatherCurrentData,
            statusFavorite: getStatusFavorite,
            statusFavoriteUpdated: getStatusFavoriteUpdated,
            locationResult: locationUpdated.asDriverOnErrorJustComplete()
        )
    }
}
