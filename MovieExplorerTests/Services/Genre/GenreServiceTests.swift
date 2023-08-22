//
//  GenreServiceTests.swift
//  MovieExplorerTests
//
//  Created by Ahmad Ansari on 18/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import XCTest

@testable
import MovieExplorer

class GenreServiceTests: XCTestCase {

  var mockService: GenreMockService!

  override func setUp() {
    super.setUp()
    mockService = GenreMockService()
  }

  override func tearDown() {
    mockService = nil
    super.tearDown()
  }

  func testService() {
    XCTAssertNotNil(mockService)
  }

  func testServiceResponse() {
    mockService.genreList { (response, _) in
      XCTAssertNotNil(response)
      XCTAssertNotNil(response?.genereList, "Invalid Genre List")
      if let count = response?.genereList?.count {
        XCTAssertGreaterThan(count, 0, "No Genre Found")
      }
    }
  }
}

class GenreMockService: Service, GenreServiceProtocol {

  init() {
    super.init(baseURL: "",
               servicePath: "")
  }

  func genreList(completionHandler: @escaping ServiceResponseHandler<GenreServiceResponse>) {

    var genreResponse: GenreServiceResponse?
    if let url = Bundle.main.url(forResource: "GenreResponse", withExtension: "json") {
      if let mockResponse: String = try? String(contentsOf: url) {
        if let json = try? translation.decode(string: mockResponse) {
          genreResponse = try? self.translation.decode(object: json)
        }
      }
    }
    completionHandler(genreResponse, nil)
  }
}
