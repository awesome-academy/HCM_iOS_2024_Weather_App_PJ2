//
//  Constants.swift
//  Weather_App
//
//  Created by ho.bao.an on 06/05/2024.
//

import Foundation
import CoreLocation

struct Constants {
    static let cornerRadius: CGFloat = 15.0
    static let latitudinalMeters: CLLocationDistance = 3000
    static let longitudinalMeters: CLLocationDistance = 3000
    
    static let favoritedStatus = "iconStarYellow"
    static let notFavotiteStatus = "iconStar"
    
    static let identifierLocalPushNotification = "notification"
    static let hourOfNotification = 6
    static let minuteOfNotification = 30
}

