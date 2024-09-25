//
//  Model.swift
//  jsonTest
//
//  Created by Bayram Yeleç on 25.09.2024.
//

import Foundation

struct Model : Codable {
    
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let category: String?
    let image: String?
    let rating: Derecelendirme?
    
}

struct Derecelendirme: Codable {
    let rate: Double?
    let count: Int?
}


