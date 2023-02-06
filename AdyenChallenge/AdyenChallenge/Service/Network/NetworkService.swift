//
//  NetworkService.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 06/02/2023.
//

import Foundation

/// Makes URLRequest using URLSession.default
protocol NetworkServiceProtocol: AnyObject {
    
    var configuration: RequestConfiguration { get set }
    
    func request(onComplete: CommandOf<Result<Data, NetworkError>>)
    
    func cancelAndDispose()

}

final class NetworkService: NetworkServiceProtocol {
    
    var configuration: RequestConfiguration
    private var task: URLSessionDataTask?
    
    init(configuration: RequestConfiguration) {
        self.configuration = configuration
    }
    
    func request(onComplete: CommandOf<Result<Data, NetworkError>>) {
        let request = configuration.asURLRequest()
        task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil,
                  let responseData = data else {
                onComplete.execute(with: .failure(.apiFailure))
                return
            }
            onComplete.execute(with: .success(responseData))
        }
        task?.resume()
    }
  
    func cancelAndDispose() {
        task?.cancel()
        task = nil
    }
    
}

