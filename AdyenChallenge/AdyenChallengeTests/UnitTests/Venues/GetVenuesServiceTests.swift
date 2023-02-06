//
//  GetVenuesServiceTests.swift
//  AdyenChallengeTests
//
//  Created by Sajjad Haider Zaidi on 06/02/2023.
//

import XCTest
@testable import AdyenChallenge

class GetVenuesServiceTests: XCTestCase {

    private var service: GetVenuesService!
    private var networkService = MockNetworkService()
    
    override func setUp() {
        super.setUp()
        service = .init(service: networkService)
    }
    
    func test_whenGetVenuesRequested_andDataIsServed_providesVenues() {
        let expectation = XCTestExpectation(description: "Venues received.")
        let block: CommandOf<GetVenuesResult> = CommandOf { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.presentableMessage)
            }
        }
        service.getVenues(around: .mock, in: 1000, onComplete: block)
        let data = networkService.convertJsonToData(filename: "get-venues-sample")
        XCTAssertNotNil(data)
        networkService.requestCommand.execute(with: .success(data!))
        wait(for: [expectation], timeout: 4)   
    }

    func test_whenGetVenuesRequested_andNotServed_propagatesError() {
        let expectation = XCTestExpectation(description: "Error")
        let block: CommandOf<GetVenuesResult> = CommandOf { result in
            switch result {
            case .success:
                XCTFail()
            case .failure:
                expectation.fulfill()
            }
        }
        service.getVenues(around: .mock, in: 1000, onComplete: block)
        networkService.requestCommand.execute(with: .failure(.apiFailure))
        wait(for: [expectation], timeout: 4)
    }
    
}
