//
//  MockVenues.swift
//  AdyenChallengeTests
//
//  Created by Sajjad Haider Zaidi on 06/02/2023.
//

@testable import AdyenChallenge

enum MockVenues {
    
    class Router: RouterProtocol {
        
        var location: Coordinate2D? = nil
        
        func openVenuesScreen(_ location: Coordinate2D) {
            self.location = location
        }
        
    }
    
    class Interactor: VenuesInteractorProtocol {
        
        var getVenuesCommand: CommandOf<GetVenuesResult> = .nop
        
        func getVenues(_ command: CommandOf<GetVenuesResult>) {
            getVenuesCommand = command
        }
        
    }
    
    class View: VenuesViewProtocol {
        
        var state: VenuesViewState = .showSpinner
        var isLoading: Bool = true
        var viewModel: VenuesViewModel = .init(loadingText: "",
                                               venues: [])
        
        func render(viewModel: VenuesViewModel) {
            self.viewModel = viewModel
        }
        
        func updateState(state: VenuesViewState) {
            self.state = state
        }
        
        func setLoadingState(isLoading: Bool) {
            self.isLoading = isLoading
        }
        
    }
    
    class Presenter: VenuesPresenterProtocol {
        
        var view: VenuesViewProtocol?
        var loadDataCommand: Command = .nop
        
        func loadData() {
            loadDataCommand.execute()
        }
        
    }
    
    class GetVenuesService: GetVenuesServiceProtocol {
        
        var getVenuesCommand: CommandOf<GetVenuesResult> = .nop
        
        func getVenues(around: Coordinate2D, in radius: Int, onComplete: CommandOf<GetVenuesResult>) {
            getVenuesCommand = onComplete
        }
        
    }
    
}

extension Venue {
    
    static let mock: Self = {
        .init(
            id: "49f0ee61f964a52071691fe3",
            name: "CB2 Union Square",
            distance: 32,
            tags: ["Furniture and Home Store"],
            geocode: .mock
        )
    }()

}

extension Coordinate2D {
    
    static let mock: Self = {
        .init(latitude: 37.785873, longitude: -122.406599)
    }()
    
}
