//
//  UtilityTests.swift
//  MovieExplorerTests
//
//  Created by Ahmad Ansari on 18/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import XCTest

@testable
import MovieExplorer

class UtilityTestCases: XCTestCase {

  func testLogger() {
    // given
    let utility = Utility.defaultUtility

    // when
    utility.configureSwiftLogger()

    // then
    XCTAssertNotNil(SLog.debug(""))
    XCTAssertNotNil(SLog.error(""))
    XCTAssertNotNil(SLog.info(""))
    XCTAssertNotNil(SLog.warning(""))
  }
}
