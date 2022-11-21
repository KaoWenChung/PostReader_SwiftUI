//
//  NetworkSessionManagerMock.swift
//  TechTestTests
//
//  Created by wyn on 2022/11/20.
//

import Foundation

struct NetworkSessionManagerMock: NetworkSessionManagerType {
    let response: HTTPURLResponse
    let data: Data
    func request(_ request: URLRequest) async throws -> DataResponse {
        return (data, response)
    }
}
