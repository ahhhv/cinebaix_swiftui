//
//  Utils.swift
//  cinebaix
//
//  Created by Alex on 30/10/21.
//

import Foundation

enum Constants {
    static let url = "https://cinebaix-api.herokuapp.com/"
//    static let url = "http://localhost:8000"
}

enum CError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
