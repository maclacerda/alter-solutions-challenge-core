//
//  URLRequestError.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

import Foundation

private let domain = "URLRequestError"

/// Defines URLRequestErrors
/// - raw: and error comming from the system, that conforms with Error
/// - unknown: unknown error
/// - requestBuilderFailed: the request builder failed
/// - withData: there is an error and it has a payload
public enum URLRequestError: Error {
    
    case raw(Error)
    case unknown
    case requestBuilderFailed
    case withData(Data, Error?)
    
    public var code: Int {
        switch self {
        case .raw(let error):
            let nsError = error as NSError
            return nsError.code
            
        case .unknown:
            return -1
            
        case .requestBuilderFailed:
            return -2
            
        case .withData(_, let error):
            let nsError = error as NSError?
            return nsError?.code ?? -3
        }
    }
    
    public var rawError: NSError {
        switch self {
        case .raw(let error):
            return error as NSError
            
        case .unknown:
            return NSError(domain: domain, code: code, description: "Unknown error.")
            
        case .requestBuilderFailed:
            return NSError(domain: domain, code: code, description: "The request builder failed.")
            
        case .withData(let data, _):
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []), let userInfo = jsonObject as? [String: Any] else {
                return URLRequestError.unknown.rawError
            }
            
            return NSError(domain: domain, code: code, userInfo: userInfo)
        }
    }
    
}
