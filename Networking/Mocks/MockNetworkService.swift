//
//  File.swift
//  
//
//  Created by Wei Lu on 18/03/2022.
//

import Foundation
import Combine
import Networking

public class MockNetworkService: NetworkServiceProtocol {

    public func request<T: Decodable>(requestData: RequestData) -> AnyPublisher<T, HTTPError> {
        return MockNetworkSession()
            .publisher(for: requestData)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
