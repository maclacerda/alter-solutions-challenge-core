//
//  URLDispatcherTests.swift
//  AlterSolutionsChallengeCoreTests
//
//  Created by Marcos Lacerda on 26/08/21.
//

@testable import AlterSolutionsChallengeCore
import XCTest

class URLDispatcherTests: XCTestCase {

    func testDispatcherInit() {
        let sut = URLSessionDispatcher()
        XCTAssertNotNil(sut)
    }

}
