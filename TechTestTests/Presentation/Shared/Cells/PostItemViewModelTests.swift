//
//  PostItemViewModelTests.swift
//  TechTestTests
//
//  Created by wyn on 2022/12/8.
//

import XCTest
@testable import TechTest

final class PostItemViewModelTests: XCTestCase {
    func testInitViewModel_byPost() {
        let fixture = Fixture.posts.first
        let sut = PostItemViewModel(post: fixture!)
        XCTAssertEqual(sut.title, "TitleA")
        XCTAssertEqual(sut.body, "BodyA")
    }
    func testInitViewModel_byComment() {
        let comment = Comment(id: 0, name: "TitleA", body: "BodyA")
        let sut = PostItemViewModel(comment: comment)
        XCTAssertEqual(sut.title, "TitleA")
        XCTAssertEqual(sut.body, "BodyA")
    }
}
