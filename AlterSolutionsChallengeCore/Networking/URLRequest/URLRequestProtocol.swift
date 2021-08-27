//
//  URLRequestProtocol.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

import Foundation

/// Defines the Request protocol, which can be implemented as a class, struct or enum
public protocol URLRequestProtocol {
    
    /// The API's base url
    var baseURL: URL { get }
    
    /// Defines the endpoint we want to hit
    var path: String { get }
    
    /// Relative to the method we want to call, that was defined with an enum above
    var method: HTTPMethod { get }
    
    /// Those are the parameters we want to pass with the request
    /// they can be used for the body or the URL
    var parameters: URLRequestParameters? { get }
    
    /// Defines the list of headers we want to be passed along with each request
    var headers: [String: Any]? { get }
    
}
extension URLRequestProtocol {
    
    func buildURLRequest() throws -> URLRequest {
        return try URLRequestBuilder(with: baseURL, path: path)
            .set(method: method)
            .set(headers: headers)
            .set(parameters: parameters)
            .build()
    }
    
}
