//
//  URLSessionDispatcher.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

import Foundation

private struct DataTaskResponse {

    let data: Data?
    let error: Error?
    let httpResponse: HTTPURLResponse?

}

public class URLSessionDispatcher: URLRequestDispatcherProtocol {

    // MARK: - Properties

    private var session: URLSession

    // MARK: - Initialization

    /// Initilizes the dispatcher with a session, that could be injected
    ///
    /// - Parameter session: an URLSession
    public required init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    // MARK: - Public

    /// Executes the request and provides a completion with the response
    ///
    /// - Parameters:
    ///   - request: the request to be executed
    ///   - keyPath: an optional `key` to extract json in result
    ///   - completion: the requests callback
    /// - Returns: a token in order to let us manipulate the task if needed
    public func execute(request: URLRequestProtocol,
                        keyPath: String? = nil,
                        completion: @escaping (Result<Data?, URLRequestError>) -> Void) -> URLRequestToken? {
        var urlRequestToken: URLRequestToken?

        do {
            let urlRequest = try request.buildURLRequest()

            let dataTask = session.dataTask(with: urlRequest) { [weak self] (data, urlResponse, error) in
                let httpResponse = urlResponse as? HTTPURLResponse
                let dataTaskResponse = DataTaskResponse(data: data, error: error, httpResponse: httpResponse)

                if let urlRequestError = self?.parseErrors(in: dataTaskResponse) {
                    completion(.failure(urlRequestError))
                } else {
                    guard let data = data else {
                        completion(.success(nil))
                        return
                    }

                    guard let keyPathToExtract = keyPath else {
                        completion(.success(data))
                        return
                    }

                    let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)

                    guard let nestedJson = (json as AnyObject).value(forKeyPath: keyPathToExtract),
                          JSONSerialization.isValidJSONObject(nestedJson),
                          let dataExtracted = try? JSONSerialization.data(withJSONObject: nestedJson) else {
                        completion(.failure(.unknown))
                        return
                    }

                    completion(.success(dataExtracted))
                }
            }

            urlRequestToken = URLRequestToken(task: dataTask)
            dataTask.resume()
        } catch {
            completion(.failure(.requestBuilderFailed))
        }

        return urlRequestToken
    }

    private func parseErrors(in dataTaskResponse: DataTaskResponse) -> URLRequestError? {
        guard let statusCode = dataTaskResponse.httpResponse?.statusCode else {
            return .unknown
        }

        if !(200...299 ~= statusCode) {
            guard dataTaskResponse.error == nil else {
                return .unknown
            }

            guard 400...499 ~= statusCode,
                  let data = dataTaskResponse.data,
                  let jsonString = String(data: data, encoding: .utf8) else {
                return .unknown
            }

            #if DEBUG
            print(jsonString)
            #endif

            return .withData(data, dataTaskResponse.error)
        }

        return nil
    }

}
