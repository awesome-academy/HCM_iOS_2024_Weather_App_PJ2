//
//  LocationRepository.swift
//  Weather_App
//
//  Created by ho.bao.an on 14/05/2024.
//

import Foundation
import MapKit
import RxSwift

protocol LocationSearchRepositoryType {
    func getSearchResults(for searchText: String) -> Observable<MKMapItem>
}

final class LocationSearchRepository: LocationSearchRepositoryType {
    func getSearchResults(for searchText: String) -> Observable<MKMapItem> {
        return Observable.create { observer in
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = searchText
            let search = MKLocalSearch(request: request)
            search.start { responseSearch, error in
                if let error = error {
                    observer.onError(error)
                } else if let responseSearch = responseSearch {
                    if let firstMapItem = responseSearch.mapItems.first {
                        observer.onNext(firstMapItem)
                        observer.onCompleted()
                    }
                }
            }
            return Disposables.create {
                search.cancel()
            }
        }
    }
}
