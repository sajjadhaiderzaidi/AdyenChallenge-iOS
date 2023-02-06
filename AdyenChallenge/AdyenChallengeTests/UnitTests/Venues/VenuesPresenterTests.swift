//
//  VenuesPresenterTests.swift
//  AdyenChallengeTests
//
//  Created by Sajjad Haider Zaidi on 06/02/2023.
//

import XCTest
@testable import AdyenChallenge

class VenuesPresenterTests: XCTestCase {

    private var presenter: VenuesPresenter!
    private lazy var interactor = MockVenues.Interactor()
    private lazy var router = MockVenues.Router()
    private lazy var view = MockVenues.View()
    
    override func setUp() {
        super.setUp()
        presenter = .init(interactor: interactor, router: router)
        presenter.view = view
    }
    
    func test_onLoad_viewRendersCorrectly() {
        presenter.loadData()
        XCTAssertEqual(view.viewModel.loadingText, "Loading venues nearby...")
        XCTAssertEqual(view.isLoading, true)
    }
    
    func test_onLoad_getVenuesRequestIsMade() {
        presenter.loadData()
        XCTAssertNotEqual(interactor.getVenuesCommand, .nop)
    }
    
    func test_onLoad_getVenuesRequestIsMade_viewIsLoading() {
        presenter.loadData()
        XCTAssertEqual(view.state, .showSpinner)
    }
    
    func test_whenGetVenuesRequestFails_retryIsRendered() {
        presenter.loadData()
        interactor.getVenuesCommand.execute(with: .failure(.unknown))
        XCTAssertEqual(view.state, .showRetry)
    }
    
    func test_whenNoInternet_correspondingMessageIsShown() {
        presenter.loadData()
        interactor.getVenuesCommand.execute(with: .failure(.noInternet))
        XCTAssertEqual(view.viewModel.loadingText, "Unable to connect to internet...")
    }
    
    func test_whenGetVenuesRequestFails_correspondingMessageIsShown() {
        presenter.loadData()
        interactor.getVenuesCommand.execute(with: .failure(.unknown))
        XCTAssertEqual(view.viewModel.loadingText, "Something went wrong, please try again!")
    }
    
    func test_whenGetVenuesRequestSucceeds_viewIsNotLoading() {
        presenter.loadData()
        interactor.getVenuesCommand.execute(with: .success([.mock]))
        XCTAssertEqual(view.state, .showData)
    }
    
}
