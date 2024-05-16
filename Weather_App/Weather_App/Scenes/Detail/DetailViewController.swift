//
//  DetailViewController.swift
//  Weather_App
//
//  Created by ho.bao.an on 25/04/2024.
//

import UIKit
import RxSwift
import RxCocoa
import Then

final class DetailViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    private var tableViewCells = [WeatherCellType]()
    
    var viewModel: DetailViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationController()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.do {
            $0.dataSource = self
            $0.register(cellType: MainTableViewCell.self)
            $0.register(cellType: DetailTableViewCell.self)
            $0.register(cellType: ForecastTableViewCell.self)
        }
    }
}

extension DetailViewController: Bindable {
    func bindViewModel() {
        let input = DetailViewModel.Input(getForecastWeatherDataTrigger: Driver.just(()))
        let output = viewModel.transform(input: input, disposeBag: disposeBag)
        
        output.cells
            .drive(weatherDataUpdateBinder)
            .disposed(by: disposeBag)
    }
}

extension DetailViewController {
    private var weatherDataUpdateBinder: Binder<[WeatherCellType]> {
        return Binder(self) { vc, cells in
            vc.do {
                $0.tableViewCells = cells
                $0.tableView.reloadData()
            }
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCells.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewCells[indexPath.row]
        switch cell {
        case .mainCell(let weatherCurrentEntity):
            return tableView.dequeueReusableCell(for: indexPath, cellType: MainTableViewCell.self).then {
                $0.bind(weatherCurrentEntity: weatherCurrentEntity)
            }
        case .detailCell(let weatherCurrentEntity):
            return tableView.dequeueReusableCell(for: indexPath, cellType: DetailTableViewCell.self).then {
                $0.bind(weatherCurrentEntity: weatherCurrentEntity)
            }
        case .forecastCell(let weatherForecastData):
            return tableView.dequeueReusableCell(for: indexPath, cellType: ForecastTableViewCell.self).then {
                $0.bind(weatherForecastData: weatherForecastData)
            }
        }
    }
}
