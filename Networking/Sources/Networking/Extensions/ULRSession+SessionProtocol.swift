import Foundation
import Combine

extension URLSession: SessionProtocol {

    static func constructRequest(from requestData: RequestData) -> URLRequest {
        var urlRequest = URLRequest(url: requestData.endpoint.url)
        urlRequest.httpBody = requestData.body
        urlRequest.httpMethod = requestData.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = requestData.headers
        return urlRequest
    }

    public func publisher<T: Decodable>(for requestData: RequestData) -> AnyPublisher<T, HTTPError> {
        let request = URLSession.constructRequest(from: requestData)

        return dataTaskPublisher(for: request)
            .tryMap({ output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw HTTPError.noResponse
                }

                guard let error = self.handleStatusCode(response.statusCode) else {
                    return output.data
                }

                throw error
            })
            .decode()
            .mapError { error in
                #if DEBUG
                print(error)
                print(error.localizedDescription)
                #endif
                return HTTPError.failedDecoding
            }
            .eraseToAnyPublisher()
    }

    public func handleStatusCode(_ statusCode: Int) -> HTTPError? {
        guard (200 ..< 300).contains(statusCode)
        else {
            if let code = HTTPStatusCode(rawValue: statusCode) {
                switch code {
                case .unauthorised:
                    return HTTPError.unauthorised
                case .notFound, .internalError, .badRequest:
                    return HTTPError.failedWithStatusCode(code)
                case.authorisationRefused:
                    return HTTPError.authorisationRefused
                case .success, .accepted, .noContent:
                    return nil
                }
            }

            return HTTPError.unknownErrorCode
        }

        return nil
    }
}

extension Publisher where Output == Data {
    func decode<T: Decodable>(
        as type: T.Type = T.self,
        using decoder: JSONDecoder = .snakeCaseConverting
    ) -> Publishers.Decode<Self, T, JSONDecoder> {
        decode(type: type, decoder: decoder)
    }
}
