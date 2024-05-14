//
//  RepositoryAssembler.swift
//  Weather_App
//
//  Created by ho.bao.an on 15/05/2024.
//

import Foundation

protocol RepositoryAssembler {
    func resolve() -> LocationSearchRepositoryType
}

extension RepositoryAssembler where Self: DefaultAssembler {
    func resolve() -> LocationSearchRepositoryType {
        return LocationSearchRepository()
    }
}
