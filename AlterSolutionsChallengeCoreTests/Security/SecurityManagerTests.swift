//
//  SecurityManagerTests.swift
//  AlterSolutionsChallengeCoreTests
//
//  Created by Marcos Lacerda on 26/08/21.
//

@testable import AlterSolutionsChallengeCore
import XCTest

// swiftlint:disable line_length
class SecurityManagerTests: XCTestCase {

    // MARK: - Properties

    private let salt: [UInt8] = [65, 108, 116, 101, 114, 83, 111, 108, 117, 116, 105, 111, 110, 115, 67, 104, 97, 108, 108, 101, 110, 103, 101, 77, 97, 114, 99, 111, 115]

    // MARK: - Tests

    func testSecurityManager_makeSalt_ShouldBeGeneratedCorrectSalt() {
        let salt = "TestMakeSalt"
        let expectedResult: [UInt8] = [27, 7, 21, 1, 62, 2, 10, 17, 60, 19, 34, 39]
        let sut = SecurityManager.shared

        XCTAssertEqual(expectedResult, sut.makeSalt(salt))
    }

    func testSecurityManager_obfuscate_ShouldBeObfuscatedStringWithSuccess() {
        var sut = SecurityManager.shared
        let expectedResult: [UInt8] = [2, 4, 21, 9, 30, 54, 1, 11, 16, 57, 8, 29, 13, 28, 48]

        sut.salt = salt

        XCTAssertEqual(expectedResult, try sut.obfuscate("ChallengeMarcos"))
    }

    func testSecurityManager_reveal_ShouldBeRevealedStringWithSuccess() {
        var sut = SecurityManager.shared
        let encrypted: [UInt8] = [2, 4, 21, 9, 30, 54, 1, 11, 16, 57, 8, 29, 13, 28, 48]
        let expectedResult = "ChallengeMarcos"

        sut.salt = salt

        XCTAssertEqual(expectedResult, try sut.reveal(encrypted))
    }

    func testSecurityManager_obfuscateWithSaltEmpty_ShouldBeTrhowAnError() {
        var sut = SecurityManager.shared

        sut.salt = []

        XCTAssertThrowsError(
            try sut.obfuscate("empty error test")
        )
    }

    func testSecurityManager_revealWithSaltEmpty_ShouldBeThrowAnError() {
        var sut = SecurityManager.shared

        sut.salt = []

        XCTAssertThrowsError(
            try sut.reveal([10, 30, 5])
        )
    }

}
// swiftlint:enable line_length
