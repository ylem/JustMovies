//
//  PopularType.swift
//  
//
//  Created by Wei Lu on 18/03/2022.
//

import Foundation

public protocol PopularType {
    var id: Int { get set }
    var title: String? { get set }
    var name: String? { get set }
    var backdropPath: String? { get set }
    var posterPath: String? { get set }
    var voteAverage: Double { get set }
    var voteCount: Double { get set }
    var overview: String { get set }
}

public extension PopularType {
    func posterImageURL(width: PosterSize) -> URL? {
        guard let posterPath = posterPath else { return nil }
        return EndpointProvider().endpoint(from: .images(path: posterPath, width: width.rawValue)).url
    }

    func backdropImageURL(width: BackdropSize) -> URL? {
        guard let backdropPath = backdropPath else { return nil }
        return EndpointProvider().endpoint(from: .images(path: backdropPath, width: width.rawValue)).url
    }

    var vate: String {
        String(format: "%0.1f", voteAverage)
    }

    var displayName: String {
        [title ?? "", name ?? ""].first(where: { !$0.isEmpty }) ?? ""
    }
}
