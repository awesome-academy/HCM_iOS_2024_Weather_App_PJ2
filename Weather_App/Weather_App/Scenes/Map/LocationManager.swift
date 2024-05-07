//
//  LocationManager.swift
//  Weather_App
//
//  Created by ho.bao.an on 06/05/2024.
//

import Foundation
import CoreLocation
import MapKit
import RxSwift
import RxCocoa
import Then

final class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    private var currentLocationSubject = PublishSubject<CLLocation>()
    private var authorizationStatusSubject = BehaviorSubject<CLAuthorizationStatus>(value: .notDetermined)
    
    private override init() {
        super.init()
        locationManager.do {
            $0.delegate = self
            $0.requestWhenInUseAuthorization()
            $0.desiredAccuracy = kCLLocationAccuracyBest
            $0.distanceFilter = kCLDistanceFilterNone
        }
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func getCurrentLocation() -> Observable<CLLocation> {
        return currentLocationSubject.asObservable()
    }
    
    func getAuthorizationStatus() -> Observable<CLAuthorizationStatus> {
        return authorizationStatusSubject.asObservable()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatusSubject.onNext(status)
        if status == .authorizedWhenInUse {
            startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocationSubject.onNext(location)
        }
    }
    
    func setRegion(on mapView: MKMapView,
                   center: CLLocationCoordinate2D,
                   latitudinalMeters: CLLocationDistance,
                   longitudinalMeters: CLLocationDistance) {
        let region = MKCoordinateRegion(
            center: center,
            latitudinalMeters: latitudinalMeters,
            longitudinalMeters: longitudinalMeters
        )
        mapView.setRegion(region, animated: true)
    }
    
    func requestBackgroundLocationAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
    
    func getLocationInBackground() -> Observable<CLLocation> {
        guard CLLocationManager.locationServicesEnabled() else {
            print("Location services are not enabled")
            return Observable.empty()
        }
        locationManager.startMonitoringSignificantLocationChanges()
        return Observable.deferred { [weak self] in
            guard let self = self else { return Observable.empty() }
            if let location = self.locationManager.location {
                return Observable.just(location)
            } else {
                return self.getCurrentLocation().take(1)
            }
        }
    }
}
