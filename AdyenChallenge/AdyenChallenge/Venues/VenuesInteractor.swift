//
//  VenuesInteractor.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 05/02/2023.
//

import Foundation

/// Interacts with services to get data
protocol VenuesInteractorProtocol {
    
    func getVenues(_ command: CommandOf<GetVenuesResult>)
    
}

final class VenuesInteractor: VenuesInteractorProtocol {
    
    
    let location: Coordinate2D
    var radius: Int
    let networkService: GetVenuesServiceProtocol

    init(location: Coordinate2D,
         radius: Int? = nil,
         networkService: GetVenuesServiceProtocol? = nil) {
        self.location = location
        self.radius = radius ?? 1000
        self.networkService = networkService ?? GetVenuesService()
    }
    
    func getVenues(_ command: CommandOf<GetVenuesResult>) {
        networkService.getVenues(around: location,
                                 in: radius,
                                 onComplete: command)
    }

}
