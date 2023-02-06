//
//  Assembly.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 05/02/2023.
//

import UIKit
import CoreLocation

/// Assebles module 
struct Assembly {
    
    public static func assemble() -> UIWindow {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.backgroundColor = .systemBackground
        let locationManager = CLLocationManager()
        let locationService = LocationService(manager: locationManager)
        let interactor = PermissionInteractor(locationService: locationService)
        let router = Router()
        let presenter = PermissionPresenter(interactor: interactor,
                                            router: router)
        let controller = PermissionViewController(presenter: presenter)
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.navigationItem.setHidesBackButton(true, animated: false)
        router.navigationController = navigationController
        window.rootViewController = navigationController
        
        return window
    }
    
}

