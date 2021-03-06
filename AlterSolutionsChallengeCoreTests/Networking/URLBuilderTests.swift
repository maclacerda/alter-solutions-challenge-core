//
//  URLBuilderTests.swift
//  AlterSolutionsChallengeCoreTests
//
//  Created by Marcos Lacerda on 26/08/21.
//

@testable import AlterSolutionsChallengeCore
import XCTest

class URLBuilderTests: XCTestCase {

    func test_buildingURLWithBodyParameters_shouldReturnExpectedURLRequest() {
        // Given
        guard let url = URL(string: "http://www.someurl.com/") else {
            XCTFail("Could not create URL.")
            return
        }

        let expectedMethod = "GET"
        let path = "path"
        let headers = ["header1": "value1"]
        let bodyParams = ["bodyParam1": "bodyParamValue"]
        let adapter = URLRequestAdapterSpy()

        // When
        let builder = URLRequestBuilder(with: url)
            .set(method: .get)
            .set(path: path)
            .set(headers: headers)
            .set(parameters: .body(bodyParams))
            .add(adapter: adapter)

        guard let sut = try? builder.build() else {
            XCTFail("Could not build URLRequest with builder.")
            return
        }

        // Then
        let cleanSutURL = sut.url?.absoluteString.replacingOccurrences(of: path, with: "")

        XCTAssertEqual(url.absoluteString, cleanSutURL, "Expected \(url), but got \(String(describing: sut.url)).")
        XCTAssertEqual(expectedMethod, sut.httpMethod,
                       "Expected \(String(describing: method)), but got \(String(describing: sut.httpMethod)).")
        XCTAssertEqual(sut.url?.pathComponents.contains(path), true,
                       "Expected \(path), but got \(String(describing: sut.url?.pathComponents)).")
        XCTAssertEqual(headers, sut.allHTTPHeaderFields,
                       "Expected \(headers), but got \(String(describing: sut.allHTTPHeaderFields)).")

        guard let bodyData = sut.httpBody,
              let httpBody = try? JSONSerialization.jsonObject(with: bodyData, options: .mutableContainers)
                as? [String: String]
        else {
            XCTFail("Could not get `body` dictionary from `httpBody`.")
            return
        }

        XCTAssertEqual(bodyParams, httpBody, "Expected \(bodyParams), but got \(httpBody).")
        XCTAssertTrue(adapter.adaptCalled, "The adapter should have been called.")
    }

    func test_buildingURLWithURLParameters_shouldReturnExpectedURLRequest() {
        // Given
        guard let url = URL(string: "http://www.someurl.com/") else {
            XCTFail("Could not create URL.")
            return
        }

        let expectedMethod = "GET"
        let path = "path"
        let headers = ["header1": "value1"]
        let urlParams = ["bodyParam1": "bodyParamValue"]
        let adapter = URLRequestAdapterSpy()
        let expectedAbsoluteStringURL = "http://www.someurl.com/path?bodyParam1=bodyParamValue"

        // When
        let builder = URLRequestBuilder(with: url)
            .set(method: .get)
            .set(path: path)
            .set(headers: headers)
            .set(parameters: .url(urlParams))
            .add(adapter: adapter)

        guard let sut = try? builder.build() else {
            XCTFail("Could not build URLRequest with builder.")
            return
        }

        // Then
        XCTAssertEqual(expectedAbsoluteStringURL, sut.url?.absoluteString,
                       "Expected \(expectedAbsoluteStringURL), but got \(String(describing: sut.url?.absoluteString)).")
        XCTAssertEqual(expectedMethod, sut.httpMethod,
                       "Expected \(String(describing: method)), but got \(String(describing: sut.httpMethod)).")
        XCTAssertEqual(sut.url?.pathComponents.contains(path), true,
                       "Expected \(path), but got \(String(describing: sut.url?.pathComponents)).")
        XCTAssertEqual(headers, sut.allHTTPHeaderFields,
                       "Expected \(headers), but got \(String(describing: sut.allHTTPHeaderFields)).")
        XCTAssertTrue(adapter.adaptCalled, "The adapter should have been called.")
    }

    func test_buildingURLWithAdapter_shouldThrowError() {
        // Given
        guard let url = URL(string: "http://www.someurl.com/") else {
            XCTFail("Could not create URL.")
            return
        }

        let adapter = URLRequestAdapterStub()
        adapter.shouldThrowError = true

        // When
        let builder = URLRequestBuilder(with: url)
            .set(method: .get)
            .add(adapter: adapter)

        // Then
        XCTAssertThrowsError(
            _ = try builder.build(),
            "Expected to throw error, but it didn't."
        )
    }

}

// MARK: - Testing Helpers

private final class URLRequestAdapterSpy: URLRequestAdapter {
    private(set) var adaptCalled = false

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        adaptCalled = true
        return urlRequest
    }

}

private final class URLRequestAdapterStub: URLRequestAdapter {
    var shouldThrowError = false

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        if shouldThrowError {
            throw NSError(domain: "raise exception in stub", code: -1, description: "throws custom error")
        }

        return urlRequest
    }

}
