//
//  File.swift
//  
//
//  Created by Wei Lu on 21/09/2021.
//

import Foundation
import Combine
import Networking

public class MockNetworkSession: SessionProtocol {
    public var statusCode: Int = 200
    public var error: HTTPError?
    public var data: Data?

    public init() {}

    public func publisher<T: Decodable>(
        for requestData: RequestData
    ) -> AnyPublisher<T, HTTPError> {
        if statusCode != 200 {
            let error = URLSession.shared.handleStatusCode(statusCode)
            return Result.Publisher(error!).eraseToAnyPublisher()
        }

        if error != nil {
            return Result.Publisher(error!).eraseToAnyPublisher()
        }

        if let data = data {
            if let object = try? JSONDecoder.snakeCaseConverting.decode(T.self, from: data) {
                return Result.Publisher(object).eraseToAnyPublisher()
            } else {
                return Result.Publisher(HTTPError.failedDecoding).eraseToAnyPublisher()
            }
        }

        return Result.Publisher(HTTPError.noData).eraseToAnyPublisher()
    }
}
