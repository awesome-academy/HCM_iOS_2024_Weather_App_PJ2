//
//  SearchViewController.swift
//  Weather_App
//
//  Created by ho.bao.an on 14/05/2024.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit
import Then

final class SearchViewController: UIViewController {
    

    @IBOutlet weak private var nameCityLabel: UILabel!
    @IBOutlet weak private var latitudeLabel: UILabel!
    @IBOutlet weak private var longitudeLabel: UILabel!
    
    @IBOutlet weak private var chooseLocationButton: UIButton!
    
    var viewModel: SearchViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SearchViewController: Bindable {
    func bindViewModel() {
        let input = SearchViewModel.Input(getLocationResultTrigger: Driver.just(()),
                                          getButtonTappedTrigger: chooseLocationButton.rx.tap.asDriverOnErrorJustComplete())
        
        let output = viewModel.transform(input: input, disposeBag: disposeBag)
        
        output.locationResult
            .drive(locationDataUpdate)
            .disposed(by: disposeBag)
    }
}


extension SearchViewController {
    private var locationDataUpdate: Binder<MKMapItem> {
        return Binder(self) { vc, locationResult in
            vc.do {
                $0.nameCityLabel.text = locationResult.name
                $0.latitudeLabel.text = "\(locationResult.latitude)"
                $0.longitudeLabel.text = "\(locationResult.longitude)"
            }
        }
    }
}
