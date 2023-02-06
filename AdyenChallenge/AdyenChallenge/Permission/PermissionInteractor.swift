//
//  PermissionInteractor.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 05/02/2023.
//

import Foundation

/// Interacts with services to get data
protocol PermissionInteractorProtocol {
    
    var isPermissionGranted: Bool { get }
    func requestPermission(_ command: CommandOf<Bool>)
    func getCurrentLocation(_ command: CommandOf<LocationFetchResult>)
    
}

final class PermissionInteractor: PermissionInteractorProtocol{
 
    private let locationService: LocationServiceProtocol
    
    var isPermissionGranted: Bool {
        locationService.isPermissionGranted
    }
    
    init(locationService: LocationServiceProtocol) {
        self.locationService = locationService
    }
    
    func requestPermission(_ command: CommandOf<Bool>) {
        guard !locationService.isPermissionGranted else {
            command.execute(with: locationService.isPermissionGranted)
            return
        }
        locationService.requestLocationPermission(command)
    }
    
    func getCurrentLocation(_ command: CommandOf<LocationFetchResult>) {
        locationService.getLocationCoordinates(command)
    }
    
}
