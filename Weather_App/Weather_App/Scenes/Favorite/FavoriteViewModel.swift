//
//  FavoriteViewModel.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import RxSwift
import RxCocoa
import UIKit

struct FavoriteViewModel {
    let navigator: FavoriteNavigatorType
    let useCase: FavoriteUseCaseType
}

extension FavoriteViewModel: ViewModelType {
    struct Input {
    }
    
    struct Output {
    }

    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        return Output()
    }
}
