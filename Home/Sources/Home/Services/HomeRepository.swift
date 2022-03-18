//
//  HomeRepository.swift
//  
//
//  Created by Wei Lu on 16/03/2022.
//

import Foundation
import Combine
import Storage
import Models

protocol HomeRepositoryProtocol {
    func fetchPopularMovies(page: Int) -> AnyPublisher<[Movie]?, Never>
    func fetchPopularTVs(page: Int) -> AnyPublisher<[TV]?, Never>
}

class HomeRepository {

    private let service: HomeServicesProtocol
    private let storage: HomeDataStoreProtocol

    init(service: HomeServicesProtocol = HomeServices(),
         storage: HomeDataStoreProtocol = HomeDataStore()) {
        self.service = service
        self.storage = storage
    }

    func fetchPopularMovies(page: Int = 1) -> AnyPublisher<[Movie]?, Never> {
        return service.fetchPopularMovies(page: page)
            .map({ [weak self] (response: PopularMovieResponse) in
                self?.storage.store(popularMovies: response.results)
                return response.results
            })
            .catch({ [weak self] (error) -> Just<[Movie]?> in
                return Just(self?.storage.fetchStoredPopularMovies())
            })
            .eraseToAnyPublisher()
    }

    func fetchPopularTVs(page: Int = 1) -> AnyPublisher<[TV]?, Never> {
        return service.fetchPopularTVs(page: page)
            .map({ [weak self] (response: PopularTVResponse) in
                self?.storage.store(popularTVs: response.results)
                return response.results
            })
            .catch({ [weak self] (error) -> Just<[TV]?> in
                return Just(self?.storage.fetchStoredPopularTVs())
            })
                .eraseToAnyPublisher()
    }
}
