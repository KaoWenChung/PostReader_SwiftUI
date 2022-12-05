//
//  PostListViewModelTests.swift
//  TechTestTests
//
//  Created by wyn on 2022/11/22.
//

import XCTest
@testable import TechTest

final class PostListViewModelTests: XCTestCase {

    func testPostListUseCaseWithNetwokError() async {
        let expectation = expectation(description: "Should run error")
        let error = NetworkError.notConnected
        let sut = PostListViewModel(showPostsUseCase: ShowPostsUseCaseFailedMock(error: error, expectation: expectation), actions: nil)
        await sut.reloadData()
        
        wait(for: [expectation], timeout: 0.1)
        XCTAssertNotNil(sut.error)
    }

    func testPostListUseCaseGetData() async {
        let expectation = expectation(description: "Should get data")
        let sut = PostListViewModel(showPostsUseCase: ShouwPostsUseCaseSuccessMock(response: Fixture.posts, expectation: expectation), actions: nil)
        await sut.reloadData()
        
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(sut.items.first?.id, 0)
        XCTAssertEqual(sut.items.first?.title, "TitleA")
        XCTAssertEqual(sut.items.first?.body, "BodyA")
        XCTAssertEqual(sut.items.count, 2)
        XCTAssertNil(sut.error)
    }

}
