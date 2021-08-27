//
//  APIService.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

import Foundation

/// Defines an API service
public protocol APIService {
    
    /// The dispatcher to take care of the network requests
    var dispatcher: URLRequestDispatcherProtocol { get }
    
    /// Intializer to inject the dispatcher
    /// - Parameter dispatcher: the dispatcher to take care of the network requests
    init(dispatcher: URLRequestDispatcherProtocol)
    
}
