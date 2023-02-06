//
//  VenuesInteractorTests.swift
//  AdyenChallengeTests
//
//  Created by Sajjad Haider Zaidi on 06/02/2023.
//

import XCTest
@testable import AdyenChallenge

class VenuesInteractorTests: XCTestCase {

    private var interactor: VenuesInteractor!
    private var networkService = MockVenues.GetVenuesService()
    
    override func setUp() {
        super.setUp()
        interactor = .init(location: .mock, networkService: networkService)
    }
    
    func test_whenVenuesFetched_requestIsMade() {
        let block: CommandOf<GetVenuesResult> = CommandOf { result in }
        interactor.getVenues(block)
        XCTAssertEqual(networkService.getVenuesCommand, block)
    }
    
}
