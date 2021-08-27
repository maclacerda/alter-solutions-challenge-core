//
//  ViewCodeProtocol.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

public enum ViewCodeProtocolError: Error {
    case callNotPermited(String)
}

public protocol ViewCodeProtocol {
    func setupHierarchy()
    func setupConstraints()
    func setupConfigurations()
}

public extension ViewCodeProtocol {
    
    func setupView() {
        setupHierarchy()
        setupConstraints()
        setupConfigurations()
    }

}
