//
//  DataTransferServiceTests.swift
//  TechTestTests
//
//  Created by wyn on 2022/11/20.
//

import XCTest

// MARK: - Mock Data
private struct MockResponseData: Decodable {
    let name: String
}

// MARK: - Tests
final class DataTransferServiceTests: XCTestCase {
    
    func testReceivedValidJSONResponse_decodeResponseToObject() {
        // given
        let mockConfig = NetworkConfigurableMock()
        let expectation = expectation(description: "should decode response to object")
        let mockData = #"{"name": "Mike"}"#.data(using: .utf8)
        let mockSessionManager = NetworkSessionManagerMock(response: HTTPURLResponse(), data: mockData!)
        let networkService = NetworkService(config: mockConfig, sessionManager: mockSessionManager)
        let mockEndpoint = Endpoint<MockResponseData>(path: "https://mock.endpoint.com", method: .get)
        // sut
        let sut = DataTransferService(networkService: networkService)
        // when
        Task.init {
            do {
                let (value, _) = try await sut.request(with: mockEndpoint)
                XCTAssertEqual(value.name, "Mike")
                expectation.fulfill()
            } catch {
                XCTFail("Decoding mock object failure")
            }
        }
        // result
        wait(for: [expectation], timeout: 0.1)
    }
}
