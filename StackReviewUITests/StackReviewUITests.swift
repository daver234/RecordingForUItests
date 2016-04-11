//
//  StackReviewUITests.swift
//  StackReviewUITests
//
//  Created by Greg Heo on 2015-09-30.
//  Copyright © 2015 Razeware. All rights reserved.
//

import XCTest

class StackReviewUITests: XCTestCase {
  let app = XCUIApplication()

  override func setUp() {
    super.setUp()

    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    XCUIApplication().launch()

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    XCUIDevice.sharedDevice().orientation = .Portrait
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  // challenge 5
  func testAboutDetails() {
    let app = XCUIApplication()
    app.navigationBars["StackReview"].buttons["About"].tap()

    let showHideCopyrightNoticeButton = app.buttons["Show/Hide Copyright Notice"]
    showHideCopyrightNoticeButton.tap()

    XCTAssertTrue(app.images["rw_logo"].exists)

    showHideCopyrightNoticeButton.tap()

    XCTAssertFalse(app.images["rw_logo"].exists)
  }

  func testHideMap() {

    XCUIDevice.sharedDevice().orientation = .LandscapeLeft
    
    let tablesQuery = app.tables
    tablesQuery.staticTexts["Stack 'em High"].swipeUp()

    tablesQuery.staticTexts["Ye Olde Pancake"].tap()

    let mapQuery = app.maps
    XCTAssertTrue(mapQuery.element.exists)

    app.buttons["Hide Map"].tap()

    let map = mapQuery.element
    let mapIsHidden = map.frame.size.width == 0 || map.frame.size.height == 0
    XCTAssertTrue(mapIsHidden)

  }

  func testAbout() {
    let startTitleLabel = app.navigationBars.staticTexts["StackReview"]
    XCTAssertTrue(startTitleLabel.exists, "Should be on the start screen")

    app.buttons["About"].tap()

    let aboutTitleLabel = app.navigationBars.staticTexts["About"]
    XCTAssertTrue(aboutTitleLabel.exists, "Should be on the about screen")
  }

  // challenge 4
  func testTableViewTap() {
    let tableText = app.tables.staticTexts["Stack 'em High"]
    let pancakeText = app.staticTexts["Stack 'em High"]
    let hideDetailsButton = app.buttons["Hide Details"]

    tableText.tap()

    XCTAssertTrue(pancakeText.exists)
    XCTAssertTrue(hideDetailsButton.exists)
  }
}
