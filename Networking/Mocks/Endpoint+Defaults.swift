//
//  Endpoint+Defaults.swift
//  NetworkingTests
//
//  Created by lpenman on 28/04/2020.
//  Copyright © 2020 Jaguar Land Rover. All rights reserved.
//

import Foundation
@testable import Networking

public extension Endpoint {

    static var `default`: Endpoint {
        return Endpoint(url: URL(string: "a.com")!,
                        tokenRequirement: .notRequired)
    }

    static var requiresToken: Endpoint {
        return Endpoint(url: URL(string: "a.com")!,
                        tokenRequirement: .required)
    }

    static var tokenRequest: Endpoint {
        return Endpoint(url: URL(string: "a.com")!,
                        tokenRequirement: .requested)
    }

}
