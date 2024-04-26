//
//  DetailAssembler.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import Foundation
import UIKit

protocol DetailAssembler {
    func resolve(navigationController: UINavigationController) -> DetailViewController
    func resolve(navigationController: UINavigationController) -> DetailViewModel
    func resolve(navigationController: UINavigationController) -> DetailNavigatorType
    func resolve() -> DetailUseCaseType
}

extension DetailAssembler {
    func resolve(navigationController: UINavigationController) -> DetailViewController {
        let viewController = DetailViewController()
        let viewModel: DetailViewModel = resolve(navigationController: navigationController)
        viewController.bindViewModel(to: viewModel)
        return viewController
    }

    func resolve(navigationController: UINavigationController) -> DetailViewModel {
        return DetailViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension DetailAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> DetailNavigatorType {
        return DetailNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> DetailUseCaseType {
        return DetailUseCase()
    }
}
