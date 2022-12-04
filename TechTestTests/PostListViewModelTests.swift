//
//  PostListViewModelTests.swift
//  TechTestTests
//
//  Created by wyn on 2022/11/22.
//

import XCTest
@testable import TechTest

final class PostListViewModelTests: XCTestCase {

    class CancellableMock: CancellableType {
        func cancel() {}
    }

    class ShouwPostsUseCaseFailedMock: ShowPostsUseCaseType {
        let error: Error?
        let expectation: XCTestExpectation
        init(error: Error?,
             expectation: XCTestExpectation) {
            self.error = error
            self.expectation = expectation
        }
        func execute() async throws -> ([TechTest.Post], TechTest.CancellableType) {
            if let error = error {
                expectation.fulfill()
                throw error
            }
            return ([], CancellableMock())
        }
    }

    class ShouwPostsUseCaseSuccessMock: ShowPostsUseCaseType {
        let response: [Post]
        let expectation: XCTestExpectation
        init(response: [Post],
             expectation: XCTestExpectation) {
            self.response = response
            self.expectation = expectation
        }
        func execute() async throws -> ([TechTest.Post], TechTest.CancellableType) {
            expectation.fulfill()
            return (response, CancellableMock())
        }
    }

    func testPostListUseCaseWithNetwokError() async {
        let expectation = expectation(description: "Should run error")
        let error = NetworkError.notConnected
        let sut = PostListViewModel(showPostsUseCase: ShouwPostsUseCaseFailedMock(error: error, expectation: expectation), actions: nil)
        await sut.reloadData()
        
        wait(for: [expectation], timeout: 0.1)
        XCTAssertNotNil(sut.error)
    }

    func testPostListUseCaseGetData() async {
        let expectation = expectation(description: "Should get data")
        let response: [Post] = [Post(id: 0, title: "TitleA", body: "BodyA"),
                                Post(id: 1, title: "TitleB", body: "BodyB")]
        let sut = PostListViewModel(showPostsUseCase: ShouwPostsUseCaseSuccessMock(response: response, expectation: expectation), actions: nil)
        await sut.reloadData()
        
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(sut.items.first?.id, 0)
        XCTAssertEqual(sut.items.first?.title, "TitleA")
        XCTAssertEqual(sut.items.first?.body, "BodyA")
        XCTAssertEqual(sut.items.count, 2)
        XCTAssertNil(sut.error)
    }

}
