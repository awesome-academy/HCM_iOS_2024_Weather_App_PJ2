//
//  CustomShadow.swift
//  Weather_App
//
//  Created by ho.bao.an on 06/05/2024.
//

import UIKit

extension UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 4
    }
}

