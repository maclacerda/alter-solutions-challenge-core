//
//  AnalyticsProtocolTests.swift
//  AlterSolutionsChallengeCoreTests
//
//  Created by Marcos Lacerda on 31/08/21.
//

import XCTest
@testable import AlterSolutionsChallengeCore

class AnalyticsProtocolTests: XCTestCase {

    func testAnalytics_sendEvent_ShouldBeSucess() {
        let sut = AnalyticsSpy()

        sut.sendEvent(with: [:])

        XCTAssertTrue(sut.sendEventCalled)
    }

}

// MARK: - Staff

private class AnalyticsSpy: AnalyticsProtocol {

    private(set) var sendEventCalled = false

    func sendEvent(with event: [String: Any]) {
        sendEventCalled = true
    }

}
