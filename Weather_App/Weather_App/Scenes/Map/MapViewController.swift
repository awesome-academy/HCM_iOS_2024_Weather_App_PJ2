//
//  MapViewController.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import UIKit
import RxSwift
import MapKit
import RxCocoa

final class MapViewController: UIViewController {
    
    @IBOutlet weak private var mapView: MKMapView!
    @IBOutlet weak private var weatherView: UIView!
    @IBOutlet weak private var statusView: UIView!
    @IBOutlet weak private var statusImageView: UIImageView!
    @IBOutlet weak private var nameCityLabel: UILabel!
    @IBOutlet weak private var temperatureLabel: UILabel!
    
    private var searchController = UISearchController()
    private let locationManager = LocationManager.shared
    
    var viewModel: MapViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        bindViewModel()
    }
    
    private func setUpUI() {
        weatherView.layer.cornerRadius = Constants.cornerRadius
        weatherView.addShadow()
        statusView.layer.cornerRadius = Constants.cornerRadius
        statusView.addShadow()
        navigationItem.searchController = searchController
        customizeNavigationController()
        customizeSearchController(searchController: searchController)
        definesPresentationContext = true
    }
}

extension MapViewController: Bindable {
    func bindViewModel() {
        let input = MapViewModel.Input(getCurrentLocationTrigger: Driver.just(()))
        let output = viewModel.transform(input: input, disposeBag: disposeBag)
        
        output.currentLocation
            .drive(locationUpdateBinder)
            .disposed(by: disposeBag)
    }
}

extension MapViewController {
    private var locationUpdateBinder: Binder<CLLocation> {
        return Binder(self) { vc, location in
            vc.updateMapRegion(location)
        }
    }
}

extension MapViewController {
    private func updateMapRegion(_ location: CLLocation) {
        locationManager.setRegion(on: mapView,
                                  center: location.coordinate,
                                  latitudinalMeters: Constants.latitudinalMeters,
                                  longitudinalMeters: Constants.longitudinalMeters)
    }
}
