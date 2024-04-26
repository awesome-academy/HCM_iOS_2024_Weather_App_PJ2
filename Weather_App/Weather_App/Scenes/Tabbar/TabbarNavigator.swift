//
//  TabbarNavigator.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import UIKit

protocol TabbarNavigatorType {
    func loadMap(navigationController: UINavigationController)
    func loadFavorite(navigationController: UINavigationController)
}

struct TabbarNavigator: TabbarNavigatorType {

    unowned let assembler: Assembler
    unowned let tabbarController: TabbarViewController

    func loadMap(navigationController: UINavigationController) {
        let vc: MapViewController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func loadFavorite(navigationController: UINavigationController) {
        let vc: FavoriteViewController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(vc, animated: false)
    }
}
