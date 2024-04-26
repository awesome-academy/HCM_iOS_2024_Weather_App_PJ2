//
//  ViewModelType.swift
//  Weather_App
//
//  Created by ho.bao.an on 26/04/2024.
//

import Foundation
import RxSwift

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    func transform(input: Input, disposeBag: DisposeBag) -> Output
}
