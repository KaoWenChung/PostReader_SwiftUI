//
//  NetworkConfigurableMock.swift
//  TechTestTests
//
//  Created by wyn on 2022/11/20.
//

import Foundation

struct NetworkConfigurableMock: NetworkConfigurableType {
    var baseURL: URL = URL(string: "https://mock.testing.com")!
    var headers: [String: String] = [:]
    var queryParameters: [String: String] = [:]
}
