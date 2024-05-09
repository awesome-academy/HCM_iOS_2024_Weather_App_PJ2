//
//  Extention+Observable.swift
//  Weather_App
//
//  Created by ho.bao.an on 09/05/2024.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {
    public func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
}
