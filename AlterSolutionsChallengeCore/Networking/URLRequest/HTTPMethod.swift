//
//  HTTPMethod.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

import Foundation

/// This defines the type of HTTP method used to perform the request
///
/// - get: GET method
/// - put: PUT method
/// - post: POST method
/// - patch: PATCH method
/// - delete: DELETE method
public enum HTTPMethod: String {

    /// Defines the suported types of HTTP methods
    case post
    case put
    case get
    case delete
    case patch

    /// Returns the name of the method to be used in the request
    public var name: String {
        return rawValue.uppercased()
    }

}
