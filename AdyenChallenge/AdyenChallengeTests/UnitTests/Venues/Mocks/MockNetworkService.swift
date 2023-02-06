//
//  MockNetworkService.swift
//  AdyenChallengeTests
//
//  Created by Sajjad Haider Zaidi on 06/02/2023.
//

import Foundation
@testable import AdyenChallenge

class MockNetworkService: NetworkServiceProtocol {
        
    var configuration: RequestConfiguration = .mock
    var requestCommand: CommandOf<Result<Data, NetworkError>> = .nop
    var cancelAndDisposed: Bool = false
    
    func request(onComplete: CommandOf<Result<Data, NetworkError>>) {
        requestCommand = onComplete
    }
    
    func cancelAndDispose() {
        cancelAndDisposed = true
    }
    
    func convertJsonToData(filename: String) -> Data? {
        guard let path = Bundle(for: type(of: self)).path(forResource: filename, ofType: "json") else {
            return nil
        }
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
    
}


extension RequestConfiguration {
    
    static let mock: Self = {
        .init(
            baseURL: URL(string: "http://example.com/test/api")!,
            method: .get,
            path: "/v3/",
            headers: [
                "test-header": "test-header-value"
            ],
            parameters: [
                "test-param": "test-param-value"
            ]
        )
    }()
    
}
