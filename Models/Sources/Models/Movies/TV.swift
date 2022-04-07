//
//  File.swift
//  
//
//  Created by Wei Lu on 18/03/2022.
//

import Foundation

public struct TV: Codable, PopularType {
    public var id: Int
    public var backdropPath: String?
    public var name: String?
    public var title: String?
    public var posterPath: String?
    public var voteAverage: Double
    public var voteCount: Double
    public var overview: String

    public let firstAirDate: String
    public let genreIds: [Int]
    public let originalName: String
    public let originalLanguage: String
    public let originCountry: [String]
    public let popularity: Double

}
