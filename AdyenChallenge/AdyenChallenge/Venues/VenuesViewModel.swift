//
//  VenuesViewModel.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 05/02/2023.
//

import Foundation

struct VenuesViewModel {

    let loadingText: String
    let venues: [Venue]
    
    init(loadingText: String = "",
         venues: [Venue] = []) {
        self.loadingText = loadingText
        self.venues = venues
    }
    
}


