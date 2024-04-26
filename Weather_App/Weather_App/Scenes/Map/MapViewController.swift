//
//  MapViewController.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import UIKit
import RxSwift

final class MapViewController: UIViewController {

    var viewModel: MapViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MapViewController: Bindable {
    func bindViewModel() {
    }
}

