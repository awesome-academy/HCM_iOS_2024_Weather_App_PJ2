//
//  TabbarAssembler.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import UIKit

protocol TabbarAssembler {
    func resolve(navigationController: UINavigationController) -> TabbarViewController
    func resolve(navigationController: UINavigationController) -> TabbarNavigatorType
}

extension TabbarAssembler {
    func resolve(navigationController: UINavigationController) -> TabbarViewController {
        let tabbarVC = TabbarViewController()
        
        let navigator: TabbarNavigatorType = resolve(navigationController: navigationController)
        
        let mapNavController = UINavigationController()
        mapNavController.tabBarItem = TabbarItem.map.item
        navigator.loadMap(navigationController: mapNavController)
        
        let favoriteNavController = UINavigationController()
        favoriteNavController.tabBarItem = TabbarItem.favorite.item
        navigator.loadFavorite(navigationController: favoriteNavController)

        tabbarVC.viewControllers = [mapNavController,
                                    favoriteNavController]
        return tabbarVC
    }
}

extension TabbarAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> TabbarNavigatorType {
        return TabbarNavigator(assembler: self, tabbarController: TabbarViewController())
    }
}
