//
//  Movie.swift
//  
//
//  Created by Wei Lu on 16/03/2022.
//

import Foundation

public struct Movie: Codable, PopularType {
    public var id: Int
    public var backdropPath: String
    public var posterPath: String
    public var title: String?
    public var name: String? = nil
    public var voteAverage: Double
    public var voteCount: Double
    public var overview: String

    public let adult: Bool
    public let genreIds: [Int]
    public let originalTitle: String
    public let originalLanguage: String
    public let popularity: Double
    public let video: Bool
    public let releaseDate: String
}
