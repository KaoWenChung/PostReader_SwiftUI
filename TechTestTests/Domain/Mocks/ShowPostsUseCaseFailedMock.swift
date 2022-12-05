//
//  ShowPostsUseCaseFailedMock.swift
//  TechTestTests
//
//  Created by wyn on 2022/12/5.
//

import XCTest
@testable import TechTest

final class ShowPostsUseCaseFailedMock: ShowPostsUseCaseType {
    let error: Error?
    let expectation: XCTestExpectation
    init(error: Error?,
         expectation: XCTestExpectation) {
        self.error = error
        self.expectation = expectation
    }
    func execute() async throws -> ([Post], CancellableType) {
        if let error = error {
            expectation.fulfill()
            throw error
        }
        return ([], CancellableMock())
    }
}

final class ShouwPostsUseCaseSuccessMock: ShowPostsUseCaseType {
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
