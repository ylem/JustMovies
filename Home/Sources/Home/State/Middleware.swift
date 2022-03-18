//
//  Middleware.swift
//  
//
//  Created by Wei Lu on 16/03/2022.
//

import Foundation
import SwiftRedux
import Combine
import Models

let homeMiddleware: Middleware<HomeState, HomeAction, HomeRepository> = {
    state, action, service in

    switch action {
    case .loadPopularMovies(let page):
        return service.fetchPopularMovies(page: page)
            .map { 
                HomeAction.didLoadPopularMovies($0)
            }
            .eraseToAnyPublisher()
    case .loadPopularTVs(let page):
        return service.fetchPopularTVs(page: page)
            .map {
                HomeAction.didLoadPopularTVs($0)
            }
            .eraseToAnyPublisher()
    default:
        return Empty().eraseToAnyPublisher()
    }
}

