//
//  Enums.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 06/02/2023.
//

import Foundation

/// Network errors
enum NetworkError: Error {
    case invalidRequest
    case noInternet
    case apiFailure
    case invalidResponse
    case decodingError
}

/// HTTP protocol methods
enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

typealias Parameters = [String : Any]

/// Parameter Encoding Type
enum ParameterEncoding {
    
    case queryString
    case body
    case none
    
    /// Encodes parameters based on encoding type
    /// - Parameters:
    ///   - request: url request
    ///   - parameters: parameters to be encoded
    func encode(_ request: inout URLRequest,
                with parameters: Parameters)  {
        switch self {
        case .queryString:
            guard let url = request.url else { return }
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
               !parameters.isEmpty {
                
                urlComponents.queryItems = [URLQueryItem]()
                for (k, v) in parameters {
                    let queryItem = URLQueryItem(name: k, value: "\(v)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                    urlComponents.queryItems?.append(queryItem)
                }
                request.url = urlComponents.url
            }
        case .body:
            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters) {
                request.httpBody = jsonData
            }
        case .none:
            break
        }
    }
    
}

