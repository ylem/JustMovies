//
//  Reducer.swift
//  
//
//  Created by Wei Lu on 16/03/2022.
//

import Foundation
import SwiftRedux
import Navigation

let homeReducer: Reducer<HomeState, HomeAction> = { state, action in
    var newState = state

    switch action {
    case .didLoadPopularMovies(let movies):
        newState.popularMovies = movies ?? []
    case .didLoadPopularTVs(let tvs):
        newState.popularTVs = tvs ?? []
    case .show(let router, let navigation):
        routing(router, navigation)
    default:
        break
    }

    return newState
}

func routing(_ route: HomeRoute, _ navigation: Navigation) {
    navigation.present(.push, destination: { route.view().modifier(StoreModifier()) })
}
