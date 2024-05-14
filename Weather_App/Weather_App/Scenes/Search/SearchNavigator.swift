//
//  SearchNavigator.swift
//  Weather_App
//
//  Created by ho.bao.an on 14/05/2024.
//

import Foundation
import UIKit
import CoreLocation

protocol SearchNavigatorType {
    func dismis(completion: (() -> Void)?)
}

struct SearchNavigator: SearchNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func dismis(completion: (() -> Void)?) {
        navigationController.dismiss(animated: true) {
            completion?()
        }
    }
}
