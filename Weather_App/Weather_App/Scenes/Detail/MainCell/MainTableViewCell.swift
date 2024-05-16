//
//  MainTableViewCell.swift
//  Weather_App
//
//  Created by ho.bao.an on 15/05/2024.
//

import UIKit
import Reusable

final class MainTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak private var cellView: UIView!
    @IBOutlet weak private var nameCityLabel: UILabel!
    @IBOutlet weak private var dateTimeLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var statusView: UIView!
    @IBOutlet weak private var statusImageView: UIImageView!
    @IBOutlet weak private var temperatureLabel: UILabel!
    
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

extension MainTableViewCell {
    func bind(weatherCurrentEntity: WeatherCurrentEntity) {
        nameCityLabel.text = weatherCurrentEntity.nameCity
        dateTimeLabel.text = weatherCurrentEntity.dateString
        descriptionLabel.text = weatherCurrentEntity.descriptionStatus
        temperatureLabel.text = weatherCurrentEntity.temperatureInCelsius
        if let icon = weatherCurrentEntity.weatherIcon {
            statusImageView.loadImage(withIcon: icon)
        } else {
            statusImageView.image = UIImage.wifiSlashImage
        }
    }
}
