//
//  VenuesPresenter.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 05/02/2023.
//

import Foundation

/// Presents venues screen
protocol VenuesPresenterProtocol {
    
    var view: VenuesViewProtocol? { get set }
    func loadData()

}

final class VenuesPresenter: VenuesPresenterProtocol {
    
    private let interactor: VenuesInteractorProtocol
    private let router: RouterProtocol
    var view: VenuesViewProtocol?
    
    init(interactor: VenuesInteractorProtocol,
         router: RouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func loadData() {
        updateView(for: .loading)
        interactor.getVenues(getNearbyVenuesCommand())
    }
    
    func updateView(for state: VenuesPresenterState) {
        switch state {
        case .loading:
            view?.render(
                viewModel: .init(loadingText: "Loading venues nearby...")
            )
        case .failed(let text):
            view?.render(
                viewModel: .init(loadingText: text)
            )
        case .fetched(let venues):
            view?.render(
                viewModel: .init(venues: venues)
            )
        }
        view?.updateState(state: state.viewState)
    }
    
}

//MARK: - private methods
private extension VenuesPresenter {
    
    func getNearbyVenuesCommand() -> CommandOf<GetVenuesResult> {
        CommandOf { [weak self] result in
            switch result {
            case .success(let venues):
                self?.updateView(for: .fetched(venues))
            case .failure(let error):
                self?.updateView(for: .failed(error.presentableMessage))
            }
        }
    }
    
}

extension VenuesPresenter {
    
    /// Defines presenter state
    enum VenuesPresenterState: Equatable {
        case loading, failed(String), fetched([Venue])
        
        var viewState: VenuesViewState {
            switch self {
            case .loading:
                return .showSpinner
            case .failed:
                return .showRetry
            case .fetched:
                return .showData
            }
        }
    }

}
