//
//  MoviesModuleTests.swift
//  MovieExplorerTests
//
//  Created by Ahmad Ansari on 18/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import XCTest
@testable import MovieExplorer

class MoviesModuleTests: XCTestCase {
    
    func testBuildViewController() {
        // given
        let builder = MoviesModuleBuilder()
        
        // when
        let navController = builder.build() as? UINavigationController
        let viewController = navController?.topViewController as? MoviesViewController
        
        // then
        XCTAssertNotNil(builder)
        XCTAssertNotNil(navController)
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController?.viewModel)
    }
}
