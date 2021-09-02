//
//  URLSessionDispatcherTests.swift
//  AlterSolutionsChallengeCoreTests
//
//  Created by Marcos Lacerda on 26/08/21.
//

@testable import AlterSolutionsChallengeCore
import XCTest

class URLSessionDispatcherTests: XCTestCase {

    func testURLSessionDispatcher_execute_ShouldBeSuccess() {
        let sut = URLSessionDispatcher()
        let request = URLRequestSpy("https://someurl.com")

        _ = sut.execute(request: request) { (result: Result<Data?, URLRequestError>) in
            guard case .success(let data) = result else {
                XCTFail("Request should be returned success")
                return
            }

            XCTAssertNotNil(data)
            XCTAssertEqual("success", String(data: data!, encoding: .utf8))
        }
    }

    func testURLSessionDispatcher_execute_ShouldBeFailure() {
        let sut = URLSessionDispatcher()
        let request = URLRequestSpy("https://some.com")

        _ = sut.execute(request: request) { (result: Result<Data?, URLRequestError>) in
            guard case .failure(let error) = result else {
                XCTFail("Request should be returned failure")
                return
            }

            XCTAssertNotNil(error)
            XCTAssertEqual(URLRequestError.requestBuilderFailed.rawError, error.rawError)
        }
    }

}

// MARK: - Stuff

class MockSessionDispatcher: URLSessionDispatcher {

    override func execute(request: URLRequestProtocol,
                          keyPath: String?,
                          completion: @escaping (Result<Data?, URLRequestError>) -> Void) -> URLRequestToken? {
        if request.baseURL.absoluteString == "https://someurl.com" {
            completion(.success("success".data(using: .utf8)))
        } else {
            completion(.failure(.requestBuilderFailed))
        }

        return nil
    }

}
