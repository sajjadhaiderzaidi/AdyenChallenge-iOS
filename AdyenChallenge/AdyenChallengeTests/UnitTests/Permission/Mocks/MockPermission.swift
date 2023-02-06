//
//  MockPermission.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 06/02/2023.
//

@testable import AdyenChallenge

enum MockPermission {
    
    class Router: RouterProtocol {
        var location: Coordinate2D? = nil
        
        func openVenuesScreen(_ location: Coordinate2D) {
            self.location = location
        }
    }
    
    class Interactor: PermissionInteractorProtocol {
        var isPermissionGranted: Bool = false
        
        var getCurrentLocationCommand: CommandOf<LocationFetchResult> = .nop
        var requestPermissionCommand: CommandOf<Bool> = .nop
        
        func requestPermission(_ command: CommandOf<Bool>) {
            requestPermissionCommand = command
        }
        
        func getCurrentLocation(_ command: CommandOf<LocationFetchResult>) {
            getCurrentLocationCommand = command
        }
    }
    
    class View: PermissionViewProtocol {
        var isLoading: Bool = true
        var viewModel: PermissionViewModel = .init(text: "",
                                                   ctaText: "",
                                                   ctaAction: .nop)
        
        func render(viewModel: PermissionViewModel) {
            self.viewModel = viewModel
        }
        
        func setLoadingState(isLoading: Bool) {
            self.isLoading = isLoading
        }
    }
    
    class Presenter: PermissionPresenterProtocol {
        
        var view: PermissionViewProtocol?
        var loadDataCommand: Command = .nop
        
        func loadData() {
            loadDataCommand.execute()
        }
    }
    
    class LocationService: LocationServiceProtocol {
        
        var isPermissionGranted: Bool = false
        var getLocationCoordinates: CommandOf<LocationFetchResult> = .nop
        var requestLocationPermission: CommandOf<Bool> = .nop
        
        func getLocationCoordinates(_ command: CommandOf<LocationFetchResult>) {
            getLocationCoordinates = command
        }
        
        func requestLocationPermission(_ command: CommandOf<Bool>) {
            requestLocationPermission = command
        }
        
    }
    
}
