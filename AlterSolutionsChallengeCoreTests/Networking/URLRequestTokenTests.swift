//
//  URLRequestTokenTests.swift
//  AlterSolutionsChallengeCoreTests
//
//  Created by Marcos Lacerda on 26/08/21.
//

@testable import AlterSolutionsChallengeCore
import XCTest

class URLRequestTokenTests: XCTestCase {

    func testCancel() {
        let task = URLSession(configuration: .default).dataTask(with: URL(string: "https://someurl.com")!)
        let sut = URLRequestTokenSpy(task: task)

        XCTAssertNotNil(sut)

        sut.cancel()

        XCTAssertTrue(sut.cancelCalled)
    }

}

// MARK: - Stuff

class URLRequestTokenSpy: URLRequestToken {

    var cancelCalled = false

    override func cancel() {
        super.cancel()
        cancelCalled = true
    }

}
