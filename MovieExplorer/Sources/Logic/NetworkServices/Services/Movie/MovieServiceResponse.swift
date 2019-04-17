//
//  MovieServiceResponse.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation

struct MovieServiceResponse: Codable {
    let page: Int32?
    let totalResults: Int32?
    let totalPages: Int32?
    let movies: [MovieData]?
    
    private enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
}

struct MovieData: Codable {
    
    let id: Int64?
    let title: String?
    let voteCount: Int32?
    let video: Bool?
    let voteAverage: Float?
    let popularity: Float?
    let posterPath: String?
    let originalLanguage: String?
    let originalTitle: String?
    let backdropPath: String?
    let adult: Bool?
    let overview: String?
    let releaseDate: String?
    let genreIds: [Int]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
        case popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
    }
    
}
