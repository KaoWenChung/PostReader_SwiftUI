//
//  ShowPostsUseCaseTests.swift
//  TechTestTests
//
//  Created by wyn on 2022/12/5.
//

import XCTest
@testable import TechTest

final class ShowPostsUseCaseTests: XCTestCase {
    
    class PostListRepositorySuccessMock: PostListRepositoryType {
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
    
    func testShowPostsUseCase_whenSuccessfullyFetchesPosts() async {
        // given
        let expectation = expectation(description: "Fetch posts")
        let postListRepository = PostListRepositorySuccessMock(response: Fixture.posts, expectation: expectation)
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
}
