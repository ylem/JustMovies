import Foundation
@testable import Networking

public extension RequestData {

    static var `default`: RequestData {
        return RequestData(endpoint: .default,
                           httpMethod: .get,
                           headers: ["key": "value"],
                           body: nil)
    }

    static var authorised: RequestData {
        return RequestData(endpoint: .requiresToken,
                           httpMethod: .get,
                           headers: ["key": "value"],
                           body: nil)
    }

    static var token: RequestData {
        return RequestData(endpoint: .tokenRequest,
                           httpMethod: .post,
                           headers: ["key": "value"],
                           body: nil)
    }

}
