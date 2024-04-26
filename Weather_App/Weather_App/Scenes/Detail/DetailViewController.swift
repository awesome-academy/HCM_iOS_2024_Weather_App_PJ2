//
//  DetailViewController.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import UIKit
import RxSwift

final class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModel!
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DetailViewController: Bindable {
    func bindViewModel() {
    }
}
