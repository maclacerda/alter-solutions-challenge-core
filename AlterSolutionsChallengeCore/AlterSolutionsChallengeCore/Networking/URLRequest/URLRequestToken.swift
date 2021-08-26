//
//  URLRequestToken.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

import Foundation

/// Task abstraction in order to make the request cancelable without exposing the URLSessionDataTask
public class URLRequestToken {
    
    // MARK: Properties
    
    private weak var task: URLSessionDataTask?
    
    // MARK: - Initialization
    
    /// Initiliser
    ///
    /// - Parameter task: and URLSessionDataTask that could be canceled
    public init(task: URLSessionDataTask) {
        self.task = task
    }
    
    // MARK: - Functions
    
    /// Cancels the data task
    public func cancel() {
        task?.cancel()
    }
    
}
