//
//  DetailTableViewCell.swift
//  Weather_App
//
//  Created by ho.bao.an on 15/05/2024.
//

import UIKit
import Reusable

final class DetailTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak private var cellView: UIView!
    @IBOutlet weak private var cloudLabel: UILabel!
    @IBOutlet weak private var windLabel: UILabel!
    @IBOutlet weak private var humidityLabel: UILabel!
    @IBOutlet weak private var sunRiseLabel: UILabel!
    @IBOutlet weak private var sunSetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        cellView.layer.cornerRadius = Constants.cornerRadius
        cellView.addShadow()
    }
}

extension DetailTableViewCell {
    func bind(weatherCurrentEntity: WeatherCurrentEntity) {
        cloudLabel.text = weatherCurrentEntity.cloudsString
        windLabel.text = weatherCurrentEntity.windString
        humidityLabel.text = weatherCurrentEntity.humidityString
        sunRiseLabel.text = weatherCurrentEntity.sunriseString
        sunSetLabel.text = weatherCurrentEntity.sunsetString
    }
}
