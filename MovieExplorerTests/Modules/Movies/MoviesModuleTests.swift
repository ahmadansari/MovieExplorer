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

  var builder: MoviesModuleBuilder!
  var viewController: MoviesViewController!

  override func setUp() {
    super.setUp()

    builder = MoviesModuleBuilder()
    let navController = builder.build() as? UINavigationController
    viewController = navController?.topViewController as? MoviesViewController
  }

  override func tearDown() {
    builder = nil
    viewController = nil
    super.tearDown()
  }

  func testBuildViewController() {
    // given
    let builder = self.builder
    let viewController = self.viewController

    // then
    XCTAssertNotNil(builder)
    XCTAssertNotNil(viewController)
    XCTAssertNotNil(viewController?.viewModel)
    XCTAssertEqual(viewController?.viewModel?.page, PageInfo.defaultPage, "Invalid Page")
  }

  func testConfigure() {
    // given
    let viewModel = viewController.viewModel

    // if
    viewModel?.configure()

    // then
    XCTAssertNotNil(viewModel?.moviesFRC, "Nil Value Found")
  }

  func testLoadViewData() {
    // given
    let viewModel = viewController.viewModel
    let loadExpectation = expectation(description: "Load Movie Data")

    // if
    viewModel?.configure()
    viewModel?.loadViewData {
      viewModel?.moviesFRC.performFetch(completion: { (error) in
        XCTAssertNil(error, "Fetch Error")
        let objectCount = viewModel?.moviesFRC.count() ?? 0
        XCTAssertNotNil(viewModel?.moviesFRC, "Nil Value Found")
        XCTAssertGreaterThan(objectCount, 0, "No Movies Found")
        loadExpectation.fulfill()
      })
    }

    waitForExpectations(timeout: 30) { (error) in
      if let error = error {
        XCTFail("waitForExpectations Timeout Error: \(error)")
      }
    }
  }

  func testLoadNextPage() {
    // given
    let viewModel = viewController.viewModel
    let pageExpectation = expectation(description: "Load Next Page Data")

    // if
    viewModel?.configure()
    viewModel?.loadNextPage()
    viewModel?.moviesFRC.performFetch(completion: { (error) in
      // then
      XCTAssertNil(error, "Fetch Error")
      let objectCount = viewModel?.moviesFRC.count() ?? 0
      let page = viewModel?.page ?? 0
      XCTAssertNotNil(viewModel?.moviesFRC, "Nil Value Found")
      XCTAssertGreaterThan(objectCount, 0, "No Movies Found")
      XCTAssertGreaterThan(page, 0, "Invalid Page Number")
      pageExpectation.fulfill()
    })

    waitForExpectations(timeout: 30) { (error) in
      if let error = error {
        XCTFail("waitForExpectations Timeout Error: \(error)")
      }
    }
  }
}
