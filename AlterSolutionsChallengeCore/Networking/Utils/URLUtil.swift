//
//  URLUtil.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

import Foundation

public final class URLUtil {

    /// Provides a simple way to get scaped query parameters
    ///
    /// - Parameter parameters: the parameters for the query
    /// - Returns: an string representing the parameters
    func escapedParameters(_ parameters: [String: Any]) -> String {
        guard !parameters.isEmpty else {
            return ""
        }

        var keyValuePairs = [String]()

        for (key, value) in parameters {
            // make sure that it is a string value
            let stringValue = "\(value)"

            // escape it
            let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

            // append it
            keyValuePairs.append(key + "=" + "\(escapedValue!)")
        }

        return "?\(keyValuePairs.joined(separator: "&"))"
    }

}
