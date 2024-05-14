//
//  locationGateway.swift
//  Weather_App
//
//  Created by ho.bao.an on 14/05/2024.
//

import Foundation
import RxSwift
import CoreData
import MapKit

protocol LocationGatewayType {
    func getSearchResults(for searchText: String) -> Observable<MKMapItem>
}

struct LocationGateway : LocationGatewayType {
    private let locationSearchRepository: LocationSearchRepositoryType

    init(locationSearchRepository: LocationSearchRepositoryType) {
        self.locationSearchRepository = locationSearchRepository
    }

    func getSearchResults(for searchText: String) -> Observable<MKMapItem> {
        return locationSearchRepository.getSearchResults(for: searchText)
    }
}
