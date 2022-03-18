//
//  HomeServices.swift
//  
//
//  Created by Wei Lu on 16/03/2022.
//

import Foundation
import Combine
import Models
import Networking

protocol HomeServicesProtocol {
    func fetchPopularMovies(page: Int) -> AnyPublisher<PopularMovieResponse, HTTPError>
    func fetchPopularTVs(page: Int) -> AnyPublisher<PopularTVResponse, HTTPError>
}

class HomeServices: HomeServicesProtocol {

    private let networkService: NetworkServiceProtocol
    private let endpointProvider: EndpointProviding

    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        endpointProvider: EndpointProviding = EndpointProvider()
    ) {
        self.networkService = networkService
        self.endpointProvider = endpointProvider
    }

    func fetchPopularMovies(page: Int = 1) -> AnyPublisher<PopularMovieResponse, HTTPError> {
        let endpoint = endpointProvider.endpoint(from: .popular(.movie, page: page))
        let requestData = RequestData(endpoint: endpoint)
        return networkService.request(requestData: requestData).eraseToAnyPublisher()
    }

    func fetchPopularTVs(page: Int = 1) -> AnyPublisher<PopularTVResponse, HTTPError> {
        let endpoint = endpointProvider.endpoint(from: .popular(.tv, page: page))
        let requestData = RequestData(endpoint: endpoint)
        return networkService.request(requestData: requestData).eraseToAnyPublisher()
    }
}
