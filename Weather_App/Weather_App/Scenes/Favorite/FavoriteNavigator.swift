//
//  FavoriteNavigator.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import Foundation
import UIKit

protocol FavoriteNavigatorType {
}

struct FavoriteNavigator: FavoriteNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
