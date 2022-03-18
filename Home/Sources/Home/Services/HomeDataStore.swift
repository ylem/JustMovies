//
//  File.swift
//  
//
//  Created by Wei Lu on 16/03/2022.
//

import Foundation
import Storage
import Models
import Networking

public protocol HomeDataStoreProtocol {
    func store(popularMovies: [Movie])
    func fetchStoredPopularMovies() -> [Movie]?
    func removeStoredPopularMovies()

    func store(popularTVs: [TV])
    func fetchStoredPopularTVs() -> [TV]?
    func removeStoredPopularTVs()
}

public class HomeDataStore: HomeDataStoreProtocol {
    private let storage: DataStore
    private let popularMoviesStorageKey = "popular_movies"
    private let popularTVsStorageKey = "popular_tvs"

    private var popularMoviesInStorage: [Movie]?
    private var popularTVsInStorage: [TV]?

    public init(storage: DataStore = DiskStorage()) {
        self.storage = storage
    }

    public func store(popularMovies movies: [Movie]) {
        storage.save(object: movies, with: popularMoviesStorageKey, encoder: .snakeCaseConverting)
        popularMoviesInStorage = movies
    }

    public func fetchStoredPopularMovies() -> [Movie]? {
        if popularMoviesInStorage == nil {
            popularMoviesInStorage = storage.fetchAll(with: popularMoviesStorageKey, decoder: .snakeCaseConverting)
        }
        return popularMoviesInStorage
    }

    public func removeStoredPopularMovies() {
        popularMoviesInStorage = nil
        try? storage.delete(dataForKey: popularMoviesStorageKey)
    }

    public func store(popularTVs tvs: [TV]) {
        storage.save(object: tvs, with: popularMoviesStorageKey, encoder: .snakeCaseConverting)
        popularTVsInStorage = tvs
    }

    public func fetchStoredPopularTVs() -> [TV]? {
        if popularTVsInStorage == nil {
            popularTVsInStorage = storage.fetchAll(with: popularTVsStorageKey, decoder: .snakeCaseConverting)
        }
        return popularTVsInStorage
    }

    public func removeStoredPopularTVs() {
        popularTVsInStorage = nil
        try? storage.delete(dataForKey: popularTVsStorageKey)
    }
}
