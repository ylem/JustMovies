import Foundation

public enum HTTPStatusCode: Int {
    case success = 200
    case accepted = 202
    case noContent = 204
    case badRequest = 400
    case unauthorised = 401
    case authorisationRefused = 403
    case notFound = 404
    case internalError = 500
}

public enum HTTPError: Error, Equatable {
    case noResponse
    case unknownErrorCode
    case noData
    case unauthorised
    case authorisationRefused
    case failedWithStatusCode(HTTPStatusCode)
    case failedDecoding
}
