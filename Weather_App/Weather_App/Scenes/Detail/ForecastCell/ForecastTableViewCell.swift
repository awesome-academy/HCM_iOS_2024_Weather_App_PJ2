//
//  ForecastTableViewCell.swift
//  Weather_App
//
//  Created by ho.bao.an on 15/05/2024.
//

import UIKit
import Reusable

final class ForecastTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak private var cellView: UIView!
    @IBOutlet weak private var dateTimeLabel: UILabel!
    @IBOutlet weak private var statusView: UIView!
    @IBOutlet weak private var temperatureLabel: UILabel!
    @IBOutlet weak private var statusImageView: UIImageView!
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        cellView.layer.cornerRadius = Constants.cornerRadius
        cellView.addShadow()
        statusView.layer.cornerRadius = Constants.cornerRadius
        statusView.addShadow()
    }
}

extension ForecastTableViewCell {
    func bind(weatherForecastData: WeatherForecastData) {
        dateTimeLabel.text = weatherForecastData.dateString
        temperatureLabel.text = weatherForecastData.temperatureInCelsius
        descriptionLabel.text = weatherForecastData.description
        statusImageView.loadImage(withIcon: weatherForecastData.weatherIcon)
    }
}
