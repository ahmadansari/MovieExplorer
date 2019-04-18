//
//  MovieServiceTests.swift
//  MovieExplorerTests
//
//  Created by Ahmad Ansari on 18/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import XCTest

@testable
import MovieExplorer

class MovieServiceTests: XCTestCase {
    
    var mockService: MovieMockService!
    
    override func setUp() {
        super.setUp()
        mockService = MovieMockService()
    }
    
    override func tearDown() {
        mockService = nil
        super.tearDown()
    }
    
    func testService() {
        XCTAssertNotNil(mockService)
    }
    
    func testServiceResponse() {
        mockService.latestMovies(page: 1) { (response, _) in
            XCTAssertNotNil(response)
            XCTAssertNotNil(response?.movies, "Invalid Movies List")
            if let count = response?.movies?.count {
                XCTAssertGreaterThan(count, 0, "No Movies Found")
            }
        }
    }
}

class MovieMockService: Service, MovieServiceProtocol {
    
    init() {
        super.init(baseURL: "",
                   servicePath: "")
    }
    
    func latestMovies(page: Int, completionHandler: @escaping ServiceResponseHandler<MovieServiceResponse>) {

        var movieResponse: MovieServiceResponse?
        if let url = Bundle.main.url(forResource: "MovieResponse", withExtension: "json") {
            if let mockResponse: String = try? String(contentsOf: url) {
                if let json = try? translation.decode(string: mockResponse) {
                    movieResponse = try? self.translation.decode(object: json)
                }
            }
        }
        completionHandler(movieResponse, nil)
    }
}
