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
    func testOpenPostDetails2() {
        
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"]/*[[".cells.staticTexts[\"est rerum tempore vitae\\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\\nqui aperiam non debitis possimus qui neque nisi nulla\"]",".staticTexts[\"est rerum tempore vitae\\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\\nqui aperiam non debitis possimus qui neque nisi nulla\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Comment"].tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["maiores sed dolores similique labore et inventore et\nquasi temporibus esse sunt id et\neos voluptatem aliquam\naliquid ratione corporis molestiae mollitia quia et magnam dolor"]/*[[".cells.staticTexts[\"maiores sed dolores similique labore et inventore et\\nquasi temporibus esse sunt id et\\neos voluptatem aliquam\\naliquid ratione corporis molestiae mollitia quia et magnam dolor\"]",".staticTexts[\"maiores sed dolores similique labore et inventore et\\nquasi temporibus esse sunt id et\\neos voluptatem aliquam\\naliquid ratione corporis molestiae mollitia quia et magnam dolor\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["All Comments"].buttons["qui est esse"].tap()
        
        let saveButton = app.buttons["Save"]
        saveButton.tap()
        
        let savedButton = app.buttons["Saved"]
        savedButton.tap()
        saveButton.tap()
        
        let tabBar = app.tabBars["Tab Bar"]
        let bookmarkButton = tabBar.buttons["BOOKMARK"]
        bookmarkButton.tap()
        
        let postButton = tabBar.buttons["POST"]
        postButton.tap()
        savedButton.tap()
        bookmarkButton.tap()
        postButton.tap()
        saveButton.tap()
        bookmarkButton.tap()
        postButton.tap()
        app.navigationBars["qui est esse"].buttons["All Posts"].tap()
        
    }

}
