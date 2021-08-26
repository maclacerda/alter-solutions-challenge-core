//
//  SecurityManager.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

import Foundation

public enum SecurityManagerError: Error {
    case invalidSalt
}

public protocol SecurityManagerProtocol {
    func reveal(_ key: [UInt8]) throws -> String
    func obfuscate(_ value: String) throws -> [UInt8]
    func makeSalt(_ value: String) -> [UInt8]
}

public struct SecurityManager: SecurityManagerProtocol {
    
    // MARK: - Properties
    
    public static var shared = SecurityManager()
    
    public var salt: [UInt8] = [] {
        didSet {
            obfuscator.salt = salt
        }
    }
    
    fileprivate let obfuscator = Obfuscator()
    
    // MARK: - Initializer
    
    private init() {}
    
    // MARK: - Public API
    
    public func reveal(_ key: [UInt8]) throws -> String {
        guard !salt.isEmpty else {
            throw SecurityManagerError.invalidSalt
        }

        return obfuscator.reveal(key: key)
    }
    
    public func obfuscate(_ value: String) throws -> [UInt8] {
        guard !salt.isEmpty else {
            throw SecurityManagerError.invalidSalt
        }
        
        return obfuscator.bytesByObfuscatingString(string: value)
    }
    
    public func makeSalt(_ value: String) -> [UInt8] {
        return obfuscator.makeSalt(value)
    }
    
}
