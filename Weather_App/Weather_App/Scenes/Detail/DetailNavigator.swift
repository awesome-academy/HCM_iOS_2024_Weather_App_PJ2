//
//  DetailNavigator.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import Foundation
import UIKit

protocol DetailNavigatorType {
}

struct DetailNavigator: DetailNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
