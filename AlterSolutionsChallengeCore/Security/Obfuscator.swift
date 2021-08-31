//
//  Obfuscator.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 26/08/21.
//

import Foundation

class Obfuscator {

    // MARK: - Variables

    /// The salt used to obfuscate and reveal the string.
    internal var salt: [UInt8] = []

    // MARK: - Instance Methods

    /**
     This method obfuscates the string passed in using the salt
     that was used when the Obfuscator was initialized.
     
     - parameter string: the string to obfuscate
     
     - returns: the obfuscated string in a byte array
     */
    func bytesByObfuscatingString(string: String) -> [UInt8] {
        let text = [UInt8](string.utf8)
        let cipher = salt
        let length = cipher.count

        var encrypted = [UInt8]()

        for character in text.enumerated() {
            encrypted.append(character.element ^ cipher[character.offset % length])
        }

        return encrypted
    }

    /**
     This method reveals the original string from the obfuscated
     byte array passed in. The salt must be the same as the one
     used to encrypt it in the first place.
     
     - parameter key: the byte array to reveal
     
     - returns: the original string
     */
    func reveal(key: [UInt8]) -> String {
        let cipher = salt
        let length = cipher.count

        var decrypted = [UInt8]()

        for character in key.enumerated() {
            decrypted.append(character.element ^ cipher[character.offset % length])
        }

        return String(bytes: decrypted, encoding: .utf8)!
    }

    func makeSalt(_ string: String) -> [UInt8] {
        let text = [UInt8](string.utf8)
        let cipher = [UInt8]("\(String(describing: Obfuscator.self))\(String(describing: NSObject.self))".utf8)
        let length = cipher.count

        var encrypted = [UInt8]()

        for character in text.enumerated() {
            encrypted.append(character.element ^ cipher[character.offset % length])
        }

        #if DEBUG
        print("Salt used: \(self.salt)\n")
        print("Swift Code:\n************")
        print("// Original \"\(string)\"")
        print("let key: [UInt8] = \(encrypted)\n")
        #endif

        return encrypted
    }

}
