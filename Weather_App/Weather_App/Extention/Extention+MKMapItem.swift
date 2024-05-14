//
//  Extention+MKMapItem.swift
//  Weather_App
//
//  Created by ho.bao.an on 15/05/2024.
//

import Foundation
import MapKit

extension MKMapItem {
    var latitude: CLLocationDegrees {
        return self.placemark.coordinate.latitude
    }
    
    var longitude: CLLocationDegrees {
        return self.placemark.coordinate.longitude
    }
}
