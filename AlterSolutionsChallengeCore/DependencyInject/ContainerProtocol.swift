//
//  ContainerProtocol.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

/// Defines a factory that builds a dependency
public typealias DependencyFactory = () -> Any

/// Defines a contract for a dependency container
public protocol ContainerProtocol {

    /// Registers a dependency factory for the given type.
    /// Note: it's instance will be built on the first time this dependency is used.
    /// - Parameters:
    ///   - type: the dependency
    ///   - factory: a dependency factory for the lazy dependency
    func register<Dependency>(type: Dependency.Type, factory: @escaping DependencyFactory) throws

    /// Get's a dependency from the container
    /// - Parameters:
    ///   - type: the dependency to retrieve instance
    func resolve<Dependency>(type: Dependency.Type) throws -> Dependency

    /// Get's a dependency factoryName
    /// - Parameters:
    ///   - type: a type of dependency to fetch the factory name
    func dependencyName<Dependency>(_ type: Dependency.Type) -> String

}

extension ContainerProtocol {

    public func dependencyName<Dependency>(_ type: Dependency.Type) -> String {
        return String(describing: type)
    }

}
