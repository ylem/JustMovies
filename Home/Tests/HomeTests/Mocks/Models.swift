//
//  File.swift
//  
//
//  Created by Wei Lu on 18/03/2022.
//

import Foundation

@testable import Models
@testable import Home

extension PopularMovieResponse {
    static var arrange: PopularMovieResponse {
        let path = "popular-movie-success"

        do {
            return try FileLoader.load(path, fileExtension: "json", bundle: Bundle.module)
        } catch {
            fatalError("HomeTests: Couldn't load resource '\(path)'")
        }
    }
}

extension PopularTVResponse {
    static var arrange: PopularTVResponse {
        let path = "popular-tv-success"

        do {
            return try FileLoader.load(path, fileExtension: "json", bundle: Bundle.module)
        } catch {
            fatalError("HomeTests: Couldn't load resource '\(path)'")
        }
    }
}
