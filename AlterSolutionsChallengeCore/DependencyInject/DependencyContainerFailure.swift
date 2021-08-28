//
//  DependencyContainerFailure.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

import Foundation

public enum DependencyContainerFailure: Error, LocalizedError {
    
    case couldNotFindDependency(String)
    case tryingToRegisterDependencyTwice(String)
    
}

extension DependencyContainerFailure {
    
    public var errorDescription: String? {
        switch self {
        case let .couldNotFindDependency(message):
            return "Not able to resolve dependecy: \(message), verify if it's correct registered in dependency container"
                
        case let .tryingToRegisterDependencyTwice(message):
            return "Trying to register `\(message)` twice!"
        }
    }
    
}
