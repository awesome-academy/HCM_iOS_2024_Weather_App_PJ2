//
//  MapAssembler.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import Foundation
import UIKit

protocol MapAssembler {
    func resolve(navigationController: UINavigationController) -> MapViewController
    func resolve(navigationController: UINavigationController) -> MapViewModel
    func resolve(navigationController: UINavigationController) -> MapNavigatorType
    func resolve() -> MapUseCaseType
}

extension MapAssembler {
    func resolve(navigationController: UINavigationController) -> MapViewController {
        let viewController = MapViewController()
        let viewModel: MapViewModel = resolve(navigationController: navigationController)
        viewController.bindViewModel(to: viewModel)
        return viewController
    }

    func resolve(navigationController: UINavigationController) -> MapViewModel {
        return MapViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension MapAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> MapNavigatorType {
        return MapNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> MapUseCaseType {
        return MapUseCase()
    }
}
