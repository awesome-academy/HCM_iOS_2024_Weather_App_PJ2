//
//  MapNavigator.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import Foundation
import UIKit
import CoreLocation
import RxSwift
import RxCocoa

protocol MapNavigatorType {
    func toSearchViewController(searchText: String) -> Driver<CLLocation>
    func toWeatherDetailViewController(weatherCurrentEntity: WeatherCurrentEntity)
}

struct MapNavigator: MapNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toSearchViewController(searchText: String) -> Driver<CLLocation> {
        let delegate = PublishSubject<CLLocation>()
        let vc: SearchViewController = assembler.resolve(navigationController: navigationController, 
                                                         searchText: searchText,
                                                         location: delegate)
        navigationController.present(vc, animated: true)
        return delegate.asDriverOnErrorJustComplete()
    }
    
    func toWeatherDetailViewController(weatherCurrentEntity: WeatherCurrentEntity) {
        let vc: DetailViewController = assembler.resolve(navigationController: navigationController,
                                                         weatherCurrentEntity: weatherCurrentEntity)
        navigationController.pushViewController(vc, animated: true)
    }
}
