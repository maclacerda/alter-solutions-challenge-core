//
//  URLUtilTests.swift
//  AlterSolutionsChallengeCoreTests
//
//  Created by Marcos Lacerda on 26/08/21.
//

@testable import AlterSolutionsChallengeCore
import XCTest

class URLUtilTests: XCTestCase {

    func testURLUtil_parseParameters_ShouldReturnANonEmptyString() {
        let parameters: [String: Any] = ["offset": 20]
        let expectedResult = "?offset=20"
        
        let sut = URLUtil()
        
        XCTAssertFalse(sut.escapedParameters(parameters).isEmpty)
        XCTAssertEqual(expectedResult, sut.escapedParameters(parameters))
    }
    
    func testURLUtil_parseParameters_ShouldReturnAEmptyString() {
        let parameters: [String: Any] = [:]
        
        let sut = URLUtil()
        
        XCTAssertTrue(sut.escapedParameters(parameters).isEmpty)
    }
    
}
