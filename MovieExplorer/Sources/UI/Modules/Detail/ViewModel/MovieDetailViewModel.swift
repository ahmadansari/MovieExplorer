//
//  MovieDetailViewModel.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Kingfisher

class MovieDetailViewModel {

  private let movieDTO: MovieDTO?

  // Variables
  var title           = BehaviorSubject<String?>(value: nil)
  var genreList       = BehaviorSubject<String?>(value: nil)
  var releaseDate     = BehaviorSubject<String?>(value: nil)
  var movieLanguage   = BehaviorSubject<String?>(value: nil)
  var movieRatings    = BehaviorSubject<String?>(value: nil)
  var movieOverview   = BehaviorSubject<String?>(value: nil)

  var posterLoaded    = PublishSubject<URL?>()
  var backdropLoaded  = PublishSubject<URL?>()

  init(movieDTO: MovieDTO) {
    self.movieDTO = movieDTO
  }
}

extension MovieDetailViewModel {

  func loadViewData() {
    title.onNext(movieDTO?.movieTitle())
    genreList.onNext(movieDTO?.genreList())
    releaseDate.onNext(movieDTO?.displayDate())
    movieLanguage.onNext(movieDTO?.movieLanguage())
    movieRatings.onNext(movieDTO?.movieRatings())
    movieOverview.onNext(movieDTO?.movieOverview())

    if let posterURL = movieDTO?.posterURL() {
      KingfisherManager.shared.retrieveImage(with: posterURL) { [weak self] _ in
        self?.posterLoaded.onNext((posterURL))
      }
    } else {
      posterLoaded.onNext((nil))
    }

    if let backdropURL = movieDTO?.backdropURL() {
      KingfisherManager.shared.retrieveImage(with: backdropURL) { [weak self] _ in
        self?.backdropLoaded.onNext((backdropURL))
      }
    } else {
      backdropLoaded.onNext((nil))
    }
  }

}
