//
//  TechTestUITests.swift
//  TechTestUITests
//
//  Created by wyn on 2022/12/6.
//

import XCTest

final class TechTestUITests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testOpenPostDetails() {
        let app = XCUIApplication()
        app.collectionViews.cells.staticTexts["qui est esse"].tap()
        let test = app.staticTexts["qui est esse"]
        XCTAssertTrue(test.waitForExistence(timeout: 1))
    }

}
