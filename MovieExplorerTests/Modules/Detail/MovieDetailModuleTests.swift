//
//  MovieDetailModuleTests.swift
//  MovieExplorerTests
//
//  Created by Ahmad Ansari on 18/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import XCTest
@testable import MovieExplorer

class MovieDetailModuleTests: XCTestCase {
    
    var builder: MovieDetailModuleBuilder!
    var viewController: MovieDetailViewController!
    var movieDTO: MovieDTO!
    
    override func setUp() {
        super.setUp()
        
        movieDTO = Movie.movie(withId: 287947, context: CoreDataStack.defaultStack.mainContext)?.movieDTO
        builder = MovieDetailModuleBuilder()
        viewController = builder.build(movieDTO: movieDTO) as? MovieDetailViewController
    }
    
    override func tearDown() {
        builder = nil
        viewController = nil
        movieDTO = nil
        super.tearDown()
    }
    
    /// Testing View Controller Init State
    func testViewController() {
       
        //given
        let builder = self.builder
        let viewController = self.viewController
        
        // then
        XCTAssertNotNil(movieDTO, "MovieDTO Nil")
        XCTAssertNotNil(builder, "builder Nil")
        XCTAssertNotNil(viewController, "viewController Nil")
        XCTAssertNotNil(viewController?.viewModel, "ViewModel Nil")
    }
    
    func testLoadViewData() {
        //given
        let viewModel = viewController.viewModel
        
        //if
        viewModel?.loadViewData()
        
        //then
        XCTAssertNotNil(try? viewModel?.title.value(), "Nil Value Found")
        XCTAssertNotNil(try? viewModel?.genreList.value(), "Nil Value Found")
        XCTAssertNotNil(try? viewModel?.movieRatings.value(), "Nil Value Found")
        XCTAssertNotNil(try? viewModel?.movieLanguage.value(), "Nil Value Found")
        XCTAssertNotNil(try? viewModel?.releaseDate.value(), "Nil Value Found")
        XCTAssertNotNil(try? viewModel?.movieOverview.value(), "Nil Value Found")
    }
}
