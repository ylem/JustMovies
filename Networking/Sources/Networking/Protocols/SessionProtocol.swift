import Foundation
import Combine

public protocol SessionProtocol {
    func publisher<T: Decodable>(for requestData: RequestData) -> AnyPublisher<T, HTTPError>
}
