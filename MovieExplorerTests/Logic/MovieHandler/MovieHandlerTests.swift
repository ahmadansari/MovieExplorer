//
//  MovieHandlerTests.swift
//  MovieExplorerTests
//
//  Created by Ahmad Ansari on 18/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import XCTest

@testable
import MovieExplorer

class MovieHandlerTests: XCTestCase {
  
  var movieMockService: MovieMockService!
  var genreMockService: GenreMockService!
  var movieHandler: MovieHandler!
  
  override func setUp() {
    super.setUp()
    movieMockService = MovieMockService()
    genreMockService = GenreMockService()
    movieHandler = MovieHandler.shared
  }
  
  override func tearDown() {
    movieMockService = nil
    genreMockService = nil
    movieHandler = nil
    super.tearDown()
  }
  
  // Init State Test
  func testInit() {
    XCTAssertNotNil(movieMockService, "Movie Service Nil")
    XCTAssertNotNil(genreMockService, "Genre Service Nil")
    XCTAssertNotNil(movieHandler, "Movie Handler Nil")
  }
  
  // Movies Fetching and Persistence Test
  func testFetchMovies() {
    movieHandler.fetchLatestMovies(page: 1, service: movieMockService) { (response, error) in
      XCTAssertNil(error, "Latest Movies Fetch Error")
      XCTAssertNotNil(response, "Invalid Movies Response")
    }
  }
  
  // Genre Fetching and Persistence Test
  func testFetchGenre() {
    movieHandler.fetchGenreList(service: genreMockService, completionHandler: { (response, error) in
      XCTAssertNil(error, "Genre Fetch Error")
      XCTAssertNotNil(response, "Invalid Genre Response")
    })
  }
}
