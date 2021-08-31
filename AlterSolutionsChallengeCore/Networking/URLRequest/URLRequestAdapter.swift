//
//  URLRequestAdapter.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

import Foundation

public protocol URLRequestAdapter {

    /// Inspects and adapts the specified `URLRequest` in some manner if necessary and returns the result.
    /// - parameter urlRequest: The URL request to adapt.
    /// - throws: An `Error` if the adaptation encounters an error.
    /// - returns: The adapted `URLRequest`.
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest

}
