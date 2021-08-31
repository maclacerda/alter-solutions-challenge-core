//
//  URLRequestProtocolTests.swift
//  AlterSolutionsChallengeCoreTests
//
//  Created by Marcos Lacerda on 26/08/21.
//

@testable import AlterSolutionsChallengeCore
import XCTest

class URLRequestProtocolTests: XCTestCase {

    func test() {
        let sut = URLRequestSpy("https://someurl.com")

        XCTAssertNoThrow(
            try sut.buildURLRequest()
        )
    }

}

// MARK: - Stuff

class URLRequestSpy: URLRequestProtocol {

    private let url: String

    init(_ url: String) {
        self.url = url
    }

    var baseURL: URL {
        return URL(string: url)!
    }

    var path: String {
        return ""
    }

    var method: HTTPMethod {
        return .get
    }

    var parameters: URLRequestParameters? {
        return nil
    }

    var headers: [String: Any]? {
        return nil
    }

}
