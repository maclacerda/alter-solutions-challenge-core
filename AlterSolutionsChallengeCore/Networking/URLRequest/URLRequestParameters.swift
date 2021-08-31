//
//  URLRequestParameters.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

import Foundation

/// Defines the parameters to pass along with the request
///
/// - body: parameters to be embeded on the body of the request
/// - url: path parameters to be set o the URL
public enum URLRequestParameters {

    case body(_: [String: Any]?)
    case url(_: [String: Any]?)

}
