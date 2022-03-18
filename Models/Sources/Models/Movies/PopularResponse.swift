//
//  PopularMovieResponse.swift
//  
//
//  Created by Wei Lu on 16/03/2022.
//

import Foundation

public struct PopularMovieResponse: Decodable {
    public let page: Int
    public let results: [Movie]
    public let totalPages: Int
    public let totalResults: Int
}

public struct PopularTVResponse: Decodable {
    public let page: Int
    public let results: [TV]
    public let totalPages: Int
    public let totalResults: Int
}
