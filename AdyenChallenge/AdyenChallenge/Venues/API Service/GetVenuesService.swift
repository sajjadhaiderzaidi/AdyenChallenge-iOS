//
//  GetVenuesService.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 06/02/2023.
//

import Foundation

typealias GetVenuesResult = Result<[Venue], GetVenuesError>

/// Gets list of venues
protocol GetVenuesServiceProtocol {
    
    func getVenues(around: Coordinate2D,
                   in radius: Int,
                   onComplete: CommandOf<GetVenuesResult>)
    
}


struct GetVenuesService: GetVenuesServiceProtocol {
    
    private var service: NetworkServiceProtocol
        
    init(service: NetworkServiceProtocol? = nil) {
        let config: RequestConfiguration = .init(
            method: .get,
            path: "places/search",
            parameters: [:]
        )
        self.service = service ?? NetworkService(configuration: config)
    }
    
    
    func getVenues(around: Coordinate2D,
                   in radius: Int,
                   onComplete: CommandOf<GetVenuesResult>) {
        let location = [
            String(around.latitude),
            String(around.longitude)
        ].joined(separator: ",")
        service.configuration = service.configuration.changing(parameters: [
            "ll": location,
            "radius": radius,
            "sort": "DISTANCE",
            "limit": 50
        ])
        
        request(onComplete: onRequestCompleteAction(onComplete))
    }
    
}

//MARK: - private declarations
extension GetVenuesService {

    private typealias GetVenuesAPIResponse = Result<GetVenuesAPIResponseData, NetworkError>

    private struct GetVenuesAPIResponseData: Codable {
        let results: [APIVenue]
    }

    private func onRequestCompleteAction(_ command: CommandOf<GetVenuesResult>) -> CommandOf<GetVenuesAPIResponse> {
        CommandOf { response in
            switch response {
            case .success(let data):
                let venues = data.results
                    .compactMap{ $0.model }
                command.execute(with: .success(venues))
            case .failure(let error):
                switch error {
                case .noInternet:
                    command.execute(with: .failure(.noInternet))
                default:
                    command.execute(with: .failure(.unknown))
                }
            }
        }
    }
    
    private func transformedAction(_ command: CommandOf<GetVenuesAPIResponse>) -> CommandOf<Result<Data, NetworkError>> {
        CommandOf { apiResponse in
            switch apiResponse {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let model =  try decoder.decode(GetVenuesAPIResponseData.self, from: data)
                    command.execute(with: .success(model))
                } catch {
                    command.execute(with: .failure(.decodingError))
                }
            case .failure(let error):
                command.execute(with: .failure(error))
            }
        }
    }
    
    private func request(onComplete: CommandOf<GetVenuesAPIResponse>) {
        service.request(onComplete: transformedAction(onComplete))
    }
    
}

/// User propagatable error
enum GetVenuesError: Error {
    
    case noInternet, unknown
    
    var presentableMessage: String {
        switch self {
        case .noInternet:
            return "Unable to connect to internet..."
        default:
            return "Something went wrong, please try again!"
        }
    }
    
}

