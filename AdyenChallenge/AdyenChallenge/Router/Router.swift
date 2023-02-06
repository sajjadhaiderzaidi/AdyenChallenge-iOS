//
//  Router.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 05/02/2023.
//

import UIKit

/// Triggers navigation routes
protocol RouterProtocol {
    
    func openVenuesScreen(_ location: Coordinate2D)

}

final class Router: RouterProtocol {

    var navigationController: UINavigationController?

}

extension Router {
    
    /// Opens Venues Screen
    /// - Parameter location: user's location coordinates
    func openVenuesScreen(_ location: Coordinate2D) {
        let interactor = VenuesInteractor(location: location)
        let presenter = VenuesPresenter(interactor: interactor, router: self)
        let dataSource = VenuesTableDataSource()
        let controller = VenuesViewController(presenter: presenter,
                                              dataSource: dataSource)
        navigationController?.pushViewController(controller, animated: false)
    }
    
}
