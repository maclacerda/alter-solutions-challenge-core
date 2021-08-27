//
//  DependencyContainer.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

/// The concrete implementation of a dependency store
public final class DependencyContainer: ContainerProtocol {
    
    // MARK: - Properties
    
    var dependencies = [String: DependencyFactory]()
    
    // MARK: - Initialization
    
    public init() {}
    
    // MARK: - Singleton
    
    public static let shared = DependencyContainer()
    
    // MARK: - Public API
    
    public func register<Dependency>(type: Dependency.Type, factory: @escaping DependencyFactory) throws {
        let name = dependencyName(type)
        
        guard dependencies[name] == nil else {
            throw DependencyContainerFailure.tryingToRegisterDependencyTwice(name)
        }
        
        dependencies[name] = factory
    }
    
    public func resolve<Dependency>(type: Dependency.Type) throws -> Dependency {
        let name = dependencyName(type)
        
        guard let factory = dependencies[name],
              let dependency = factory() as? Dependency else {
            throw DependencyContainerFailure.couldNotFindDependency(name)
        }
        
        return dependency
    }
    
}
