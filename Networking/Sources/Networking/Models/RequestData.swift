import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public struct RequestData {

    private(set) public var endpoint: Endpoint
    let httpMethod: HTTPMethod
    let headers: [String: String]
    let body: Data?

    private static var defaultHeader: [String: String] {
        [
            "Content-Type": "application/json",
            "Accept-Language": Locale.autoupdatingCurrent.identifier
        ]
    }

    public init(
        endpoint: Endpoint,
        httpMethod: HTTPMethod = .get,
        headers: [String: String] = [:],
        body: Data? = nil
    ) {
        self.endpoint = endpoint
        self.httpMethod = httpMethod
        self.headers = RequestData.defaultHeader.merging(headers) { _, new in new }
        self.body = body
    }
}
