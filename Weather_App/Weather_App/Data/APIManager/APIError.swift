//
//  APIError.swift
//  Weather_App
//
//  Created by ho.bao.an on 02/05/2024.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case noData
}
