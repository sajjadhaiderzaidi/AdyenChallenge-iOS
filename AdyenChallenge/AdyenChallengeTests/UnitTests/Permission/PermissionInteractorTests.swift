//
//  PermissionInteractorTests.swift
//  AdyenChallengeTests
//
//  Created by Sajjad Haider Zaidi on 06/02/2023.
//

import XCTest
@testable import AdyenChallenge

class PermissionInteractorTests: XCTestCase {

    private var interactor: PermissionInteractor!
    private lazy var locationService = MockPermission.LocationService()
    
    override func setUp() {
        super.setUp()
        interactor = .init(locationService: locationService)
    }
    
    func test_whenPermissionIsAlreadyGranted_requestIsNotMade() {
        locationService.isPermissionGranted = true
        let block: CommandOf<Bool> = CommandOf { flag in }
        interactor.requestPermission(block)
        XCTAssertNotEqual(locationService.requestLocationPermission, block)
    }
    
    func test_whenPermissionIsNotGranted_requestIsMade() {
        locationService.isPermissionGranted = false
        let block: CommandOf<Bool> = CommandOf { flag in }
        interactor.requestPermission(block)
        XCTAssertEqual(locationService.requestLocationPermission, block)
    }
    
    func test_whenUserLocationFetched_requestIsMade() {
        let block: CommandOf<LocationFetchResult> = CommandOf { result in }
        interactor.getCurrentLocation(block)
        XCTAssertEqual(locationService.getLocationCoordinates, block)
    }
    
}
