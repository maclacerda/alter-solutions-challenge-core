//
//  URLRequestErrorTests.swift
//  AlterSolutionsChallengeCoreTests
//
//  Created by Marcos Lacerda on 26/08/21.
//

@testable import AlterSolutionsChallengeCore
import XCTest

class URLRequestErrorTests: XCTestCase {

    func testUnknowError() {
        let sut: URLRequestError = .unknown

        XCTAssertEqual(-1, sut.code)
        XCTAssertEqual("Unknown error.", sut.rawError.localizedDescription)
    }

    func testRequestBuilderFailedError() {
        let sut: URLRequestError = .requestBuilderFailed

        XCTAssertEqual(-2, sut.code)
        XCTAssertEqual("The request builder failed.", sut.rawError.localizedDescription)
    }

    func testRawError() {
        let sut: URLRequestError = .raw(NSError(domain: "error", code: -4, description: "Generic Error"))

        XCTAssertEqual(-4, sut.code)
        XCTAssertEqual("Generic Error", sut.rawError.localizedDescription)
    }

    func testWithDataError() {
        let data = "['id': 1]".data(using: .utf8) ?? Data()
        let sut: URLRequestError = .withData(data, nil)

        XCTAssertEqual(-3, sut.code)
        XCTAssertNotNil(sut.rawError.userInfo)
    }

    func testWithInvalidDataError() {
        let data = "".data(using: .utf8) ?? Data()
        let sut: URLRequestError = .withData(data, nil)

        XCTAssertEqual(-3, sut.code)
        XCTAssertEqual(URLRequestError.unknown.rawError, sut.rawError)
    }

}
