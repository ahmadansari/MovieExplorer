//
//  MovieDTO.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation

class MovieDTO: NSObject {

  private weak var movie: Movie?

  init(movie: Movie? = nil) {
    super.init()
    self.movie = movie
  }

  func movieTitle() -> String? {
    return self.movie?.title
  }

  func movieOverview() -> String? {
    return self.movie?.overview
  }

  func releaseDate() -> String? {
    return self.movie?.releaseDate
  }

  func displayDate() -> String {

    // Date Type
    let convertToDate: ((String?) -> Date?) = { dateString in
      guard let dateString = dateString else { return nil }
      let formatter = DateFormatter()
      formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
      formatter.dateFormat = Constants.releaseDateFormat
      return formatter.date(from: dateString)
    }

    if let date = convertToDate(releaseDate()) {
      return date.stringValue(format: Constants.dateDisplayFormat) ?? ""
    }
    return ""
  }

  func posterURL() -> URL? {
    if let relativePath = self.movie?.posterPath {
      let thumbnailPath = String.init(format: ServicePath.movieThumbnailPath, Constants.defaultPosterSize)
      let posterPath = URL.init(string: thumbnailPath)?.appendingPathComponent(relativePath)
      return posterPath
    }
    return nil
  }

  func backdropURL() -> URL? {
    if let relativePath = self.movie?.backdropPath {
      let thumbnailPath = String.init(format: ServicePath.movieThumbnailPath, Constants.defaultBackdropSize)
      let backdropPath = URL.init(string: thumbnailPath)?.appendingPathComponent(relativePath)
      return backdropPath
    }
    return nil
  }

  func genreList() -> String {
    if var genres = self.movie?.genres?.allObjects {
      if genres.count > 0 {
        genres = (genres as! [Genre]).sorted {$0.name ?? "" < $1.name ?? ""}
        let list = (genres as! [Genre]).compactMap({$0.name}).joined(separator: ", ")
        return list
      }
    }
    return ""
  }

  func movieLanguage() -> String? {
    if let languageCode = self.movie?.originalLanguage {
      let locale = NSLocale.current as NSLocale
      return locale.displayName(forKey: .identifier, value: languageCode)
    }
    return ""
  }

  func movieRatings() -> String? {
    if let voteAverage = self.movie?.voteAverage {
      return String(voteAverage)
    }
    return ""

  }

}
