//
//  URLDispatcherTests.swift
//  AlterSolutionsChallengeCoreTests
//
//  Created by Marcos Lacerda on 26/08/21.
//

@testable import AlterSolutionsChallengeCore
import XCTest

class URLDispatcherTests: XCTestCase {

    func testURLDispatcher_init_ShouldBeCreateACorrectURLSession() {
        let sut = URLSessionDispatcher()
        XCTAssertNotNil(sut)
    }

}
