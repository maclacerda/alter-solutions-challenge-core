//
//  DependencyContainerTests.swift
//  AlterSolutionsChallengeCoreTests
//
//  Created by Marcos Lacerda on 26/08/21.
//

@testable import AlterSolutionsChallengeCore
import XCTest

class DependencyContainerTests: XCTestCase {

    // MARK: - Properties
    
    private let sut: DependencyContainer = .init()
    
    // MARK: - Tests
    
    func test_registerLazyDependency_shouldRegisterAFactoryForTheDependency() {
        // Given
        let factory: DependencyFactory = { MyDependency() }
        let type = MyDependencyProtocol.self
        
        // When
        XCTAssertNoThrow(
            try sut.register(type: type, factory: factory)
        )
        
        // Then
        let dependencyKey = String(describing: type)
        XCTAssertNotNil(sut.dependencies[dependencyKey])
    }
    
    func test_registerLazyDependency_shouldThrowError_whenRegisteringADependencyTwice() {
        // Given
        let factory: DependencyFactory = { MyDependency() }
        let type = MyDependencyProtocol.self
        let dependencyKey = String(describing: type)
        
        // When
        var errorReturned: DependencyContainerFailure?
        
        do {
            try sut.register(type: type, factory: factory)
            try sut.register(type: type, factory: factory)
        } catch {
            errorReturned = error as? DependencyContainerFailure
        }
        
        // Then
        guard case .tryingToRegisterDependencyTwice(dependencyKey) = errorReturned else {
            XCTFail("Expected .tryingToRegisterDependencyTwice, but got \(String(describing: errorReturned)).")
            return
        }
        
        XCTAssertNotNil(errorReturned?.errorDescription)
    }
    
    func test_get_shouldThrowError_whenTryingToResolveAnUnregisteredDependency() {
        // Given
        let type = MyDependencyProtocol.self
        let dependencyKey = String(describing: type)
        
        // When
        var errorReturned: DependencyContainerFailure?
        
        do {
            _ = try sut.resolve(type: type)
        } catch {
            errorReturned = error as? DependencyContainerFailure
        }
        
        // Then
        guard case .couldNotFindDependency(dependencyKey) = errorReturned else {
            XCTFail("Expected .couldNotFindProviderForDependency, but got \(String(describing: errorReturned)).")
            return
        }
        
        XCTAssertNotNil(errorReturned?.errorDescription)
    }
    
    func test_get_shouldStoreInstance_whenResolvingALazyInstanceForTheFirstTime() {
        // Given
        let factory: DependencyFactory = MyDependency.init
        let type = MyDependencyProtocol.self
        
        XCTAssertNoThrow(
            try sut.register(type: type, factory: factory)
        )
        
        // When
        let instanceReturned = try? sut.resolve(type: type)
        
        // Then
        XCTAssertNotNil(instanceReturned)
        XCTAssertEqual(sut.dependencies.count, 1)
    }

}

// MARK: - Stuff

protocol MyDependencyProtocol: AnyObject {}
protocol MyOtherDependencyProtocol: AnyObject {}

final class MyDependency: MyDependencyProtocol {}
