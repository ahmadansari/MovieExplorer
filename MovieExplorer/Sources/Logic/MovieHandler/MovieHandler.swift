//
//  MovieHandler.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation

class MovieHandler {

  // MARK: Default Context
  static let shared = MovieHandler()

  // Make init private for singleton
  private init() {

  }

  func fetchLatestMovies(page: Int,
                         service: MovieServiceProtocol = MovieService(),
                         completionHandler: @escaping (MovieServiceResponse?, Error?) -> Void) {
    service.latestMovies(page: page) { (response, error) in
      if error != nil {
        completionHandler(nil, error)
      } else {
        if let movies = response?.movies {
          let context = CoreDataStack.defaultStack.newBackgroundContext()
          Movie.saveMovies(movies,
                           context: context,
                           completion: { (error) in
            completionHandler(response, error)
          })
        }
      }
    }
  }

  func fetchGenreList(service: GenreServiceProtocol = GenreService(),
                      completionHandler: @escaping (GenreServiceResponse?, Error?) -> Void) {
    service.genreList { (response, error) in
      if error != nil {
        completionHandler(nil, error)
      } else {
        if let genres = response?.genereList {
          let context = CoreDataStack.defaultStack.newBackgroundContext()
          Genre.saveGenres(genres,
                           context: context,
                           completion: { (error) in
            completionHandler(response, error)
          })
        }
      }
    }
  }
}
