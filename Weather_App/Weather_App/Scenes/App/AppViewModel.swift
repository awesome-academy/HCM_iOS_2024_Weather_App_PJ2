//
//  AppViewModel.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import RxSwift
import RxCocoa
import UIKit

struct AppViewModel {
    let navigator: AppNavigatorType
    let useCase: AppUseCaseType
}

extension AppViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }

    struct Output {
    }

    func transform(input: AppViewModel.Input, disposeBag: DisposeBag) -> Output {
        let toMain = input.loadTrigger
            .drive(onNext: navigator.toMain)
            .disposed(by: disposeBag)
        return Output()
    }
}
