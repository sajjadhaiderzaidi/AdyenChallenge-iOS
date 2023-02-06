//
//  LocationService.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 05/02/2023.
//

import CoreLocation

public typealias Coordinate2D = CLLocationCoordinate2D
typealias LocationFetchResult = Result<Coordinate2D, LocationFetchError>

/// Gets authorization and user's location when authorised
protocol LocationServiceProtocol {
    
    var isPermissionGranted: Bool { get }
    func getLocationCoordinates(_ command: CommandOf<LocationFetchResult>)
    func requestLocationPermission(_ command: CommandOf<Bool>)

}

enum LocationFetchError: Error {
    case noLocation
}

final class LocationService: NSObject, LocationServiceProtocol {
    
    private let manager: CLLocationManager
    private var authorizationCommand: CommandOf<Bool>? = nil
    private var getLocationCommnad: CommandOf<LocationFetchResult>? = nil

    var isPermissionGranted: Bool {
        isAuthorized(manager.authorizationStatus)
    }
    
    
    public init(manager: CLLocationManager) {
        self.manager = manager
        super.init()
        manager.delegate = self
    }
    
    
    private func isAuthorized(_ status: CLAuthorizationStatus) -> Bool {
        [.authorizedAlways,
         .authorizedWhenInUse]
            .contains(status)
    }
    
    func getLocationCoordinates(_ command: CommandOf<LocationFetchResult>) {
        manager.requestLocation()
        getLocationCommnad = command
    }
    
    func requestLocationPermission(_ command: CommandOf<Bool>) {
        manager.requestWhenInUseAuthorization()
        authorizationCommand = command
    }
    
}

//MARK: - CLLocationManagerDelegate Delegate
extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationCommand?.execute(with: isAuthorized(status))
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            getLocationCommnad?.execute(with: .failure(.noLocation))
            return
        }
        getLocationCommnad?.execute(with: .success(location.coordinate))
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        getLocationCommnad?.execute(with: .failure(.noLocation))
    }
    
}
