//
//  APIConstants.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation

enum API {
    static let baseURL  = "http://api.themoviedb.org/3"
    static let apiKey   = "2696829a81b1b5827d515ff121700838"
}

enum ServicePath {
    static let discoverMovies       = "/discover/movie"
    static let genreList            = "/genre/movie/list"
    static let movieThumbnailPath   = "http://image.tmdb.org/t/p/w%d/"
}

enum Keys {
    // MARK: - API Keys
    static let total_results        = "total_results"
    static let total_pages          = "total_pages"
    static let results              = "results"
    static let vote_count           = "vote_count"
    static let id                   = "id"
    static let video                = "video"
    static let vote_average         = "vote_average"
    static let title                = "title"
    static let popularity           = "popularity"
    static let poster_path          = "poster_path"
    static let original_language    = "original_language"
    static let original_title       = "original_title"
    static let genre_ids            = "genre_ids"
    static let backdrop_path        = "backdrop_path"
    static let adult                = "adult"
    static let overview             = "overview"
    static let release_date         = "release_date"
    static let name                 = "name"
    static let genres               = "genres"
    
    // MARK: - Service Parameter Keys
    static let page                 = "page"
    static let api_key              = "api_key"
    static let query                = "query"
}

struct PageInfo {
    
}
