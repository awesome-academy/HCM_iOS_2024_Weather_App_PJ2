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
import Then

final class MapViewController: UIViewController {
    
    @IBOutlet weak private var mapView: MKMapView!
    @IBOutlet weak private var weatherView: UIView!
    @IBOutlet weak private var statusView: UIView!
    @IBOutlet weak private var statusImageView: UIImageView!
    @IBOutlet weak private var nameCityLabel: UILabel!
    @IBOutlet weak private var temperatureLabel: UILabel!
    @IBOutlet weak private var favoriteButton: UIButton!
    @IBOutlet weak private var detailButton: UIButton!
    
    private var searchController = UISearchController()
    private let locationManager = LocationManager.shared
    private let getWeatherCurrentTrigger = PublishSubject<(latitude: Double, longitude: Double, statusUserLocation: Bool)>()
    
    var viewModel: MapViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
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
        mapView.showsUserLocation = true
    }
}

// MARK: - Bindable

extension MapViewController: Bindable {
    func bindViewModel() {
        let input = MapViewModel.Input(
            getCurrentLocationTrigger: Driver.just(()),
            getWeatherCurrentTrigger: getWeatherCurrentTrigger.asDriverOnErrorJustComplete(),
            getFavoriteStatusTrigger: Driver.just(()),
            getFavoriteStatusTriggerUpdated: Driver.just(()),
            updateStatusButtonTrigger: favoriteButton.rx.tap.asDriverOnErrorJustComplete(),
            getSearchTextTrigger: searchController.searchBar.rx.searchButtonClicked
                .withLatestFrom(searchController.searchBar.rx.text.orEmpty)
                .filter { !$0.isEmpty }
                .asDriverOnErrorJustComplete(), 
            getDetailWeatherTrigger: detailButton.rx.tap.asDriverOnErrorJustComplete()
        )
        
        let output = viewModel.transform(input: input, disposeBag: disposeBag)
        
        output.currentLocation
            .drive(locationUpdateBinder)
            .disposed(by: disposeBag)
        
        output.weatherCurrentData
            .drive(weatherDataUpdateBinder)
            .disposed(by: disposeBag)
        
        output.statusFavorite
            .drive(statusFavoriteUpdateBinder)
            .disposed(by: disposeBag)
        
        output.statusFavoriteUpdated
            .drive(statusFavoriteUpdateBinder)
            .disposed(by: disposeBag)
        
        output.locationResult
            .drive(locationUpdateBinder)
            .disposed(by: disposeBag)
    }
}

// MARK: - Binder properties

extension MapViewController {
    private var locationUpdateBinder: Binder<CLLocation?> {
        return Binder(self) { vc, location in
            guard let location = location else { return }
            vc.do {
                $0.updateMapRegion(location)
                $0.getWeatherCurrentTrigger.onNext((location.coordinate.latitude, location.coordinate.longitude, true))
            }
        }
    }
    
    private var weatherDataUpdateBinder: Binder<WeatherCurrentEntity?> {
        return Binder(self) { vc, weatherCurrentEntity in
            vc.do {
                $0.setupUIWithData(weatherCurrentEntity: weatherCurrentEntity)
            }
        }
    }
    
    private var statusFavoriteUpdateBinder: Binder<Bool> {
        return Binder(self) { vc, isFavorite in
            vc.do {
                $0.updateFavoriteButtonImage(isFavorite: isFavorite)
            }
        }
    }
}

// MARK: - Handle UI

extension MapViewController {
    private func updateMapRegion(_ location: CLLocation) {
        locationManager.setRegion(on: mapView,
                                  center: location.coordinate,
                                  latitudinalMeters: Constants.latitudinalMeters,
                                  longitudinalMeters: Constants.longitudinalMeters)
    }
    
    private func setupUIWithData(weatherCurrentEntity: WeatherCurrentEntity?) {
        guard let weatherEntity = weatherCurrentEntity else { return }
        nameCityLabel.text = weatherEntity.nameCity
        temperatureLabel.text = weatherEntity.temperatureInCelsius
        if let icon = weatherEntity.weatherIcon {
            statusImageView.loadImage(withIcon: icon)
        } else {
            statusImageView.image = UIImage.wifiSlashImage
        }
    }
    
    private func updateFavoriteButtonImage(isFavorite: Bool) {
        let imageName = isFavorite ? Constants.favoritedStatus : Constants.notFavotiteStatus
        let image = UIImage(named: imageName)
        favoriteButton.setImage(image, for: .normal)
    }
}
