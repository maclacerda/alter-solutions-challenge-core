//
//  DependencyTests.swift
//  AlterSolutionsChallengeCoreTests
//
//  Created by Marcos Lacerda on 26/08/21.
//

@testable import AlterSolutionsChallengeCore
import XCTest

class DependencyTests: XCTestCase {
    
    // MARK: - Properties
    
    private let sut: DependencyContainer = DependencyContainer.shared
        
    // MARK: - Tests
    
    func testDependencyInjection_resolveDependencyWithoutRegister_ShouldNotReturnDependency() {
        let dependency = try? sut.resolve(type: MyOtherDependencyProtocol.self)
        XCTAssertNil(dependency)
    }
    
    func testDependencyInjection_resolveDependencyWithoutRegister_ShouldThrowException() {
        XCTAssertThrowsError(
            _ = try sut.resolve(type: MyOtherDependencyProtocol.self)
        )
    }
    
    func testDependencyInjection_getWrappedValue_ShouldBeNotNil() {
        try? sut.register(type: MyDependencyProtocol.self) {
            return MyDependency()
        }
        
        let sut = DependencyInjectSpy()
        
        XCTAssertNotNil(sut.myProtocol)
    }
    
    func testDependencyInjection_setWrappedValue_ShouldBeNotNil() {
        try? sut.register(type: MyDependencyProtocol.self) {
            return MyDependency()
        }
        
        var sut = DependencyInjectSpy()

        sut.myProtocol = MyDependency()

        XCTAssertNotNil(sut.myProtocol)
    }


}

// MARK: - Stuff
struct DependencyInjectSpy {
    
    @DependencyInject
    var myProtocol: MyDependencyProtocol
    
}
