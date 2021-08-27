//
//  DependencyInject.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

@propertyWrapper
struct DependencyInject<Dependency> {
    
    private var dependency: Dependency
    
    init() {
        do {
            self.dependency = try DependencyContainer.shared.resolve(type: Dependency.self)
        } catch {
            fatalError("Not able to resolve dependecy: \(Dependency.self), verify if it's correct registered in dependency container")
        }
    }
    
    var wrappedValue: Dependency {
        get { return dependency }
        set { dependency = newValue }
    }
    
}
