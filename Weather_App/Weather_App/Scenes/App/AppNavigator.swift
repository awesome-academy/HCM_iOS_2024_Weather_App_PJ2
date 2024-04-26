//
//  AppNavigator.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import UIKit

protocol AppNavigatorType {
    func toMain()
}

struct AppNavigator: AppNavigatorType {
    unowned let assembler: Assembler
    unowned let window: UIWindow

    func toMain() {
        let navigationController = UINavigationController()
        let tabbarViewController: TabbarViewController = assembler.resolve(navigationController: navigationController)
        window.rootViewController = tabbarViewController
        window.makeKeyAndVisible()
    }
}
