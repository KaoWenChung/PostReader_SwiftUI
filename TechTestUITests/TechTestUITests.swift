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
    
    func testOpenPostDetails_tapSaveButtonTwice() {
        let app = XCUIApplication()
        app.collectionViews.cells.staticTexts["qui est esse"].tap()
        let title = app.staticTexts["qui est esse"]
        XCTAssertTrue(title.waitForExistence(timeout: 1))
        let saveButton = app.buttons["Save"]
        let savedButton = app.buttons["Saved"]
        saveButton.tap()
        XCTAssertTrue(savedButton.waitForExistence(timeout: 1))
        XCTAssertFalse(saveButton.waitForExistence(timeout: 1))
        // recover to the unsaved status
        savedButton.tap()
        XCTAssertTrue(saveButton.waitForExistence(timeout: 1))
        XCTAssertFalse(savedButton.waitForExistence(timeout: 1))
    }

    func testOpenPostDetails_tapSaveButtonOnce_PresentPostInSavePosts() {
        let app = XCUIApplication()
        let cell = app.collectionViews.cells.staticTexts["qui est esse"]
        cell.tap()
        let title = app.staticTexts["qui est esse"]
        XCTAssertTrue(title.waitForExistence(timeout: 1))
        let saveButton = app.buttons["Save"]
        let savedButton = app.buttons["Saved"]
        saveButton.tap()
        XCTAssertTrue(savedButton.waitForExistence(timeout: 1))
        XCTAssertFalse(saveButton.waitForExistence(timeout: 1))
        let tabBarBookmark = app.tabBars["Tab Bar"].buttons["BOOKMARK"]
        let tabBarPost = app.tabBars["Tab Bar"].buttons["POST"]
        tabBarBookmark.tap()
        XCTAssertTrue(cell.waitForExistence(timeout: 1))
        tabBarPost.tap()
        XCTAssertTrue(savedButton.waitForExistence(timeout: 1))
        XCTAssertFalse(saveButton.waitForExistence(timeout: 1))
        // recover to the unsaved status
        savedButton.tap()
        XCTAssertTrue(saveButton.waitForExistence(timeout: 1))
        XCTAssertFalse(savedButton.waitForExistence(timeout: 1))
    }

}
