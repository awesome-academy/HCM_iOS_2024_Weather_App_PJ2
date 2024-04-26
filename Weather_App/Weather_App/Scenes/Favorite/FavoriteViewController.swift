//
//  FavoriteViewController.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import UIKit
import RxSwift

final class FavoriteViewController: UIViewController {

    var viewModel: FavoriteViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FavoriteViewController: Bindable {
    func bindViewModel() {
    }
}
