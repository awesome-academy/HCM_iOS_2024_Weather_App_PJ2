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
    }
    
    struct Output {
        let currentLocation: Driver<CLLocation>
    }

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let currentLocation = input.getCurrentLocationTrigger
            .flatMapLatest {
                return LocationManager.shared.getCurrentLocation()
                    .asDriver(onErrorJustReturn: CLLocation())
            }
        
        return Output(currentLocation: currentLocation)
    }
}
