//
//  ViewCodeProtocolTests.swift
//  AlterSolutionsChallengeCoreTests
//
//  Created by Marcos Lacerda on 26/08/21.
//

@testable import AlterSolutionsChallengeCore
import XCTest

class ViewCodeProtocolTests: XCTestCase {

    func testViewCode_setupView_ShouldBeReturnSucess() {
        let sut = ViewCodeSpy()
        
        sut.setupView()
        
        XCTAssertTrue(sut.setupViewCalled)
    }
    
    func testViewCode_setupHierarchyDirectly_ShouldBeRaiseException() {
        let sut = ViewCodeSpy()
        
        sut.setupHierarchy()
        
        XCTAssertTrue(sut.setupHierarchyCalled)
    }
    
    func testViewCode_setupConstraintsDirectly_ShouldBeRaiseException() {
        let sut = ViewCodeSpy()
        
        sut.setupConstraints()
        
        XCTAssertTrue(sut.setupConstraintsCalled)
    }
    
    func testViewCode_setupConfigurationsDirectly_ShouldBeRaiseException() {
        let sut = ViewCodeSpy()
        
        sut.setupConfigurations()
        
        XCTAssertTrue(sut.setupConfigurationsCalled)
    }
    
}

// MARK: - Stuff
class ViewCodeSpy: ViewCodeProtocol {
    
    var setupViewCalled = false
    var setupHierarchyCalled = false
    var setupConstraintsCalled = false
    var setupConfigurationsCalled = false
    
    func setupView() {
        setupViewCalled = true
        (self as ViewCodeProtocol).setupView()
    }
    
    func setupHierarchy() {
        setupHierarchyCalled = true
    }
    
    func setupConstraints() {
        setupConstraintsCalled = true
    }
    
    func setupConfigurations() {
        setupConfigurationsCalled = true
    }
    
}
