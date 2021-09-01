//
//  AnalyticsProtocol.swift
//  AlterSolutionsChallengeCore
//
//  Created by Marcos Lacerda on 31/08/21.
//

import Foundation

protocol AnalyticsProtocol: AnyObject {

    func sendEvent(with event: [String: Any])

}
