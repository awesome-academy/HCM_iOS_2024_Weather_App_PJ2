//
//  LocationUseCase.swift
//  Weather_App
//
//  Created by ho.bao.an on 14/05/2024.
//

import Foundation
import RxSwift
import CoreData
import MapKit

protocol LocationUseCase {
    var locationGateway: LocationGatewayType { get }
}

extension LocationUseCase {
    func getSearchResults(for searchText: String) -> Observable<MKMapItem> {
        return locationGateway.getSearchResults(for: searchText)
    }
}
