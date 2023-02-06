//
//  APIModels.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 05/02/2023.
//

import Foundation

/// Venue model in API response
struct APIVenue: Codable {
    
    let id: String
    let name: String
    let distance: Int
    let categories: [APICategory]
    let geocodes: APIGeocodes
    
    enum CodingKeys: String, CodingKey {
        case id = "fsq_id"
        case name
        case distance
        case categories
        case geocodes
    }
    
}

/// Category model in API response
struct APICategory: Codable {
    
    let id: Int
    let name: String
    
}

/// Geocodes model in API response
struct APIGeocodes: Codable {
    
    let main: APIGeocode
    let roof: APIGeocode?
    
}

/// Geocode model in API response
struct APIGeocode: Codable {
    
    let latitude: Double
    let longitude: Double
    
}

/// API model to data model conversion
extension APIVenue {
    
    var model: Venue {
        .init(id: id,
              name: name,
              distance: distance,
              tags: categories.compactMap { $0.name },
              geocode: geocodes.main.model)
    }
    
}

/// API model to data model conversion
extension APIGeocode {
    
    var model: Coordinate2D {
        .init(latitude: latitude,
              longitude: longitude)
    }
    
}
