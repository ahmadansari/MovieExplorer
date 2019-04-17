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
    static let nowPlaying           = "/movie/now_playing"
    static let genreList            = "/genre/movie/list"
    static let movieThumbnailPath   = "http://image.tmdb.org/t/p/w%d/"
}

enum Keys {
    // MARK: - Service Parameter Keys
    static let page                 = "page"
    static let apiKey              = "api_key"
}

enum PageInfo {
    static let defaultPage = 1
}
