//
//  Action.swift
//  
//
//  Created by Wei Lu on 16/03/2022.
//

import Foundation
import Models
import Navigation

enum HomeAction {
    case loadPopularMovies(page: Int)
    case loadPopularTVs(page: Int)
    case didLoadPopularMovies([Movie]?)
    case didLoadPopularTVs([TV]?)

    case show(_ router: HomeRoute, Navigation)
}
