//
//  NSError+extensions.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

import Foundation

extension NSError {
    
    /// A convenience initialiser for NSError, to set its description
    ///
    /// - Parameters:
    ///   - domain: the error domain
    ///   - code: the error code
    ///   - description: some description for this error
    convenience init(domain: String, code: Int, description: String) {
        self.init(domain: domain, code: code, userInfo: [(kCFErrorLocalizedDescriptionKey as CFString) as String: description])
    }
    
}
