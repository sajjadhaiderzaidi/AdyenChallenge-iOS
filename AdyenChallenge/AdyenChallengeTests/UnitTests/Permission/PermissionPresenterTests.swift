//
//  PermissionPresenterTests.swift
//  AdyenChallengeTests
//
//  Created by Sajjad Haider Zaidi on 06/02/2023.
//

import XCTest
@testable import AdyenChallenge

class PermissionPresenterTests: XCTestCase {

    private var presenter: PermissionPresenter!
    private lazy var interactor = MockPermission.Interactor()
    private lazy var router = MockPermission.Router()
    private lazy var view = MockPermission.View()
    
    override func setUp() {
        super.setUp()
        presenter = .init(interactor: interactor, router: router)
        presenter.view = view
    }
    
    func test_onLoad_viewRendersCorrectly() {
        presenter.loadData()
        XCTAssertEqual(view.viewModel.text, "Please grant location access to view venues near you.")
        XCTAssertEqual(view.viewModel.ctaText, "Enable")
    }
    
    func test_whenPermissionNotGranted_viewIsNotLoading() {
        presenter.loadData()
        XCTAssertEqual(view.isLoading, false)
    }
    
    func test_whenPermissionAlreadyGranted_viewIsLoading() {
        interactor.isPermissionGranted = true
        presenter.loadData()
        XCTAssertEqual(view.isLoading, true)
    }
    
    func test_whenRequestingPermission_viewIsLoading() {
        presenter.loadData()
        view.viewModel.ctaAction.execute()
        XCTAssertEqual(view.isLoading, true)
    }
    
    func test_whenPermissionRequestFails_viewIsNotLoading() {
        presenter.loadData()
        view.viewModel.ctaAction.execute()
        interactor.requestPermissionCommand.execute(with: false)
        XCTAssertEqual(view.isLoading, false)
    }

    func test_whenPermissionRequestSucceeds_viewIsLoading() {
        presenter.loadData()
        view.viewModel.ctaAction.execute()
        interactor.requestPermissionCommand.execute(with: true)
        XCTAssertEqual(view.isLoading, true)
    }
    
    func test_whenGetLocationRequestFails_viewIsNotLoading() {
        presenter.loadData()
        view.viewModel.ctaAction.execute()
        interactor.requestPermissionCommand.execute(with: true)
        interactor.getCurrentLocationCommand.execute(with: .failure(.noLocation))
        XCTAssertEqual(view.isLoading, false)
    }
    
    func test_whenGetLocationRequestSucceeds_routeToVenues() {
        presenter.loadData()
        view.viewModel.ctaAction.execute()
        interactor.requestPermissionCommand.execute(with: true)
        let location: Coordinate2D = .init(latitude: 0, longitude: 0)
        interactor.getCurrentLocationCommand.execute(with: .success(location))
        XCTAssertEqual(router.location, location)
    }

}

