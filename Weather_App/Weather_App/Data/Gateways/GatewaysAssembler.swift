//
//  GatewaysAssembler.swift
//  Weather_App
//
//  Created by An Bảo on 29/04/2024.
//

import Foundation

protocol GatewaysAssembler {
    func resolve() -> WeatherGatewayType
}

extension GatewaysAssembler where Self: DefaultAssembler {
    func resolve() -> WeatherGatewayType {
        return WeatherGateway()
    }
}
