//
//  PermissionPresenter.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 05/02/2023.
//

import Foundation

/// Pesents location permission screen
protocol PermissionPresenterProtocol {
    
    var view: PermissionViewProtocol? { get set }
    func loadData()

}

final class PermissionPresenter: PermissionPresenterProtocol {
    
    private let interactor: PermissionInteractorProtocol
    private let router: RouterProtocol
    var view: PermissionViewProtocol?
    
    init(interactor: PermissionInteractorProtocol,
         router: RouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func loadData() {
        let viewModel: PermissionViewModel = .init(
            text: "Please grant location access to view venues near you.",
            ctaText: "Enable",
            ctaAction: requestAuthorizationAction()
        )
        view?.render(viewModel: viewModel)
        if interactor.isPermissionGranted {
            getLocationAndProceed()
        } else {
            view?.setLoadingState(isLoading: false)
        }
    }
    
}

//MARK: - private methods
private extension PermissionPresenter {
    
    func requestAuthorizationAction() -> Command {
        Command { [weak self] in
            self?.view?.setLoadingState(isLoading: true)
            self?.getAuthorizationAndProceed()
        }
    }
    
    func getAuthorizationAndProceed() {
        interactor.requestPermission(CommandOf { [weak self] granted in
            guard granted else {
                self?.view?.setLoadingState(isLoading: false)
                return
            }
            self?.getLocationAndProceed()
        })
    }
    
    func getLocationAndProceed() {
        interactor.getCurrentLocation(CommandOf { [weak self] result in
            switch result {
            case .success(let location):
                self?.router.openVenuesScreen(location)
            case .failure(_):
                self?.view?.setLoadingState(isLoading: false)
            }
        })
    }
    
}
