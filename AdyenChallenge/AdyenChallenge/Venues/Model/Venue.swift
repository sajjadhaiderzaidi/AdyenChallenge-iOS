//
//  Venue.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 05/02/2023.
//

import Foundation

struct Venue: Equatable {
    
    let id: String
    let name: String
    let distance: Int
    let tags: [String]
    let geocode: Coordinate2D
    
}

extension Coordinate2D: Equatable {
    
    public static func == (lhs: Coordinate2D, rhs: Coordinate2D) -> Bool {
        lhs.latitude == rhs.latitude
        && lhs.longitude == lhs.longitude
    }

}
