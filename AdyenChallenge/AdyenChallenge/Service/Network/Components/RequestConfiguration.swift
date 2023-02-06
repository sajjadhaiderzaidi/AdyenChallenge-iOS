//
//  RequestConfiguration.swift
//  AdyenChallenge
//
//  Created by Sajjad Haider Zaidi on 06/02/2023.
//

import Foundation

/// Configuration of API to be used to construct URLRequest
struct RequestConfiguration {
    
    let baseURL: URL
    let method: HTTPMethod
    let path: String
    let headers: [String:String]
    let parameters: Parameters
   
    init(
        baseURL: URL = defaultBaseURL,
        method: HTTPMethod,
        path: String,
        headers: [String:String] = defaultHeaders,
        parameters: Parameters = [:]
    ) {
        self.baseURL = baseURL
        self.method = method
        self.path = path
        self.headers = headers
        self.parameters = parameters
    }
    
    func changing(
        baseURL: URL? = nil,
        method: HTTPMethod? = nil,
        path: String? = nil,
        headers: [String:String]? = nil,
        parameters: Parameters? = nil
    ) -> RequestConfiguration{
        .init(baseURL: baseURL ?? self.baseURL,
              method: method ?? self.method,
              path: path ?? self.path,
              headers: headers ?? self.headers,
              parameters: parameters ?? self.parameters)
    }
}

extension RequestConfiguration {
    
    /// Constructs URLRequest using configuration
    /// - Returns: urlRequest
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: baseURL.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        switch method {
        case .get:
            ParameterEncoding.queryString.encode(&request, with: parameters)
        case .post:
            ParameterEncoding.body.encode(&request, with: parameters)
        default:
            break
        }
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }
    
}

//MARK: - Class level properties
extension RequestConfiguration {
    
    static let defaultHeaders: [String:String] = {
        var headers = ["accept": "application/json"]
        if let key = Bundle.main.infoDictionary?["API_KEY"] as? String {
            headers["Authorization"] = key
        }
        return headers
    }()
    
    static let defaultBaseURL = URL(string: "https://api.foursquare.com/v3/")!
    
}
