//
//  PostListViewModelTests.swift
//  TechTestTests
//
//  Created by wyn on 2022/11/22.
//

import XCTest
@testable import TechTest

final class PostListViewModelTests: XCTestCase {
    
    class CancelAbleMock: CancellableType {
        func cancel() {}
    }
    
    class ShouwPostsUseCaseFailMock: ShowPostsUseCaseType {
        let error: Error?
        let response: [Post]
        let expectation: XCTestExpectation
        init(error: Error?, response: [Post], expectation: XCTestExpectation) {
            self.error = error
            self.response = response
            self.expectation = expectation
        }
        func execute() async throws -> ([TechTest.Post], TechTest.CancellableType) {
            if let error = error {
                expectation.fulfill()
                throw error
            }
            return (response, CancelAbleMock())
        }
    }
    
    func testPostListUseCaseWithNetwokError() {
        let expectation = expectation(description: "Should run error")
        let error = NetworkError.notConnected
        let sut = PostListViewModel(showPostsUseCase: ShouwPostsUseCaseFailMock(error: error, response: [], expectation: expectation))
        sut.onAppear()
        
//        XCTAssertEqual(sut.error, NetworkError.notConnected)
//        XCTAssertNotNil(sut.error)
        wait(for: [expectation], timeout: 0.1)
//        XCTAssertNotNil(sut.error)
    }
    
}
