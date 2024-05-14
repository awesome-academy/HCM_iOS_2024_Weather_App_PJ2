//
//  SearchViewModel.swift
//  Weather_App
//
//  Created by ho.bao.an on 14/05/2024.
//

import RxSwift
import RxCocoa
import UIKit
import MapKit

struct SearchViewModel {
    let navigator: SearchNavigatorType
    let useCase: SearchUseCaseType
    let delegate: PublishSubject<CLLocation>
    var searchText: String
}

extension SearchViewModel: ViewModelType {
    struct Input {
        let getLocationResultTrigger: Driver<Void>
        let getButtonTappedTrigger: Driver<Void>
    }
    
    struct Output {
        let locationResult: Driver<MKMapItem>
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let locationResult = input.getLocationResultTrigger
            .flatMapLatest {
                return useCase.getLocationResults(for: searchText)
                    .trackError(errorTracker)
                    .trackIndicator(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
        
        let location = locationResult
            .map { coordinate in
                return CLLocation(latitude: coordinate.latitude,
                                  longitude: coordinate.longitude)
            }
        
        input.getButtonTappedTrigger
            .withLatestFrom(location)
            .drive(onNext: { location in
                navigator.dismis {
                    delegate.onNext(location)
                }
            })
            .disposed(by: disposeBag)
        return Output(locationResult: locationResult)
    }
}

