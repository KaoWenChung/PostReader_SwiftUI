//
//  ShowPostsUseCaseTests.swift
//  TechTestTests
//
//  Created by wyn on 2022/12/5.
//

import XCTest
@testable import TechTest

final class ShowPostsUseCaseTests: XCTestCase {
    
    enum PostListRepositoryError: Error {
        case failedFetching
    }

    class PostListRepositorySuccessedMock: PostListRepositoryType {
        let response: [Post]
        let expectation: XCTestExpectation?
        
        init(response: [Post],
             expectation: XCTestExpectation?) {
            self.response = response
            self.expectation = expectation
        }

        func fetchPostList() async throws -> ([Post], CancellableType) {
            expectation?.fulfill()
            return (response, CancellableMock())
        }
        
    }

    class PostListRepositoryFailedMock: PostListRepositoryType {
        let error: Error
        let expectation: XCTestExpectation?
        
        init(error: Error,
             expectation: XCTestExpectation?) {
            self.error = error
            self.expectation = expectation
        }

        func fetchPostList() async throws -> ([Post], CancellableType) {
            expectation?.fulfill()
            throw error
        }
        
    }
    
    func testShowPostsUseCase_whenSuccessfullyFetchesPosts() async {
        // given
        let expectation = expectation(description: "Fetch posts")
        let postListRepository = PostListRepositorySuccessedMock(response: Fixture.posts, expectation: expectation)
        let sut = ShowPostsUseCase(postRepository: postListRepository)

        // when
        var result: [Post] = []
        do {
            let (response, _) = try await sut.execute()
            result = response
        } catch {
            XCTFail("Should not happen")
        }
        await waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(result.first?.id, 0)
        XCTAssertEqual(result.first?.title, "TitleA")
        XCTAssertEqual(result.first?.body, "BodyA")
        XCTAssertEqual(result.count, 2)
    }

    func testShowPostsUseCase_whenFailedFetchesPosts_failedFetching() async {
        // given
        let expectation = self.expectation(description: "Fetch posts should fail")
        let postListRepository = PostListRepositoryFailedMock(error: PostListRepositoryError.failedFetching, expectation: expectation)
        let sut = ShowPostsUseCase(postRepository: postListRepository)

        // when
        do {
            _ = try await sut.execute()
            XCTFail("Should not happen")
        } catch {
            XCTAssertEqual(error as! PostListRepositoryError, PostListRepositoryError.failedFetching)
        }
        await waitForExpectations(timeout: 0.1, handler: nil)
    }
}
