import Foundation
import Combine

public protocol NetworkServiceProtocol {
    func request<T: Decodable>(requestData: RequestData) -> AnyPublisher<T, HTTPError>
}

public class NetworkService: NetworkServiceProtocol {

    internal let session: SessionProtocol

    public init(urlSession: SessionProtocol = URLSession.shared) {
        self.session = urlSession
    }

    private func isRequiredToken(requestData: RequestData) -> Bool {
        return requestData.endpoint.tokenRequirement == .required
    }

    public func request<T: Decodable>(requestData: RequestData) -> AnyPublisher<T, HTTPError> {
        return session
            .publisher(for: requestData)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
