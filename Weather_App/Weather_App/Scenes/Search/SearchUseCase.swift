//
//  SearchUseCase.swift
//  Weather_App
//
//  Created by ho.bao.an on 14/05/2024.
//

import Foundation
import RxSwift
import MapKit

protocol SearchUseCaseType {
    func getLocationResults(for searchText: String) -> Observable<MKMapItem>
}

struct SearchUseCase: SearchUseCaseType, LocationUseCase {
    var locationGateway: LocationGatewayType
    
    func getLocationResults(for searchText: String) -> Observable<MKMapItem> {
        return getSearchResults(for: searchText)
    }
}
