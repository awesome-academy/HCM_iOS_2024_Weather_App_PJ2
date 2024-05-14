//
//  SearchAssembler.swift
//  Weather_App
//
//  Created by ho.bao.an on 14/05/2024.
//

import Foundation
import UIKit
import CoreLocation
import RxSwift

protocol SearchAssembler {
    func resolve(navigationController: UINavigationController, searchText: String, location: PublishSubject<CLLocation>) -> SearchViewController
    func resolve(navigationController: UINavigationController, searchText: String, location: PublishSubject<CLLocation>) -> SearchViewModel
    func resolve(navigationController: UINavigationController) -> SearchNavigatorType
    func resolve() -> SearchUseCaseType
}

extension SearchAssembler {
    func resolve(navigationController: UINavigationController, searchText: String, location: PublishSubject<CLLocation>) -> SearchViewController {
        let viewController = SearchViewController()
        let viewModel: SearchViewModel = resolve(navigationController: navigationController, searchText: searchText, location: location)
        viewController.bindViewModel(to: viewModel)
        return viewController
    }

    func resolve(navigationController: UINavigationController, searchText: String, location: PublishSubject<CLLocation>) -> SearchViewModel {
        return SearchViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve(), 
            delegate: location,
            searchText: searchText
        )
    }
}

extension SearchAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> SearchNavigatorType {
        return SearchNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> SearchUseCaseType {
        return SearchUseCase(locationGateway: resolve())
    }
}

