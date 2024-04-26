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

struct MapViewModel {
    let navigator: MapNavigatorType
    let useCase: MapUseCaseType
}

extension MapViewModel: ViewModelType {
    struct Input {
    }
    
    struct Output {
    }

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        return Output()
    }
}
