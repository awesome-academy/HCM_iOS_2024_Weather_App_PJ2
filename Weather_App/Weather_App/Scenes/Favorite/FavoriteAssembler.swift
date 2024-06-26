//
//  FavoriteAssembler.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import Foundation
import UIKit

protocol FavoriteAssembler {
    func resolve(navigationController: UINavigationController) -> FavoriteViewController
    func resolve(navigationController: UINavigationController) -> FavoriteViewModel
    func resolve(navigationController: UINavigationController) -> FavoriteNavigatorType
    func resolve() -> FavoriteUseCaseType
}

extension FavoriteAssembler {
    func resolve(navigationController: UINavigationController) -> FavoriteViewController {
        let viewController = FavoriteViewController()
        let viewModel: FavoriteViewModel = resolve(navigationController: navigationController)
        viewController.bindViewModel(to: viewModel)
        return viewController
    }

    func resolve(navigationController: UINavigationController) -> FavoriteViewModel {
        return FavoriteViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension FavoriteAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> FavoriteNavigatorType {
        return FavoriteNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> FavoriteUseCaseType {
        return FavoriteUseCase()
    }
}
