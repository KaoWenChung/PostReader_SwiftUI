//
//  AppConfiguration.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//

final class AppConfiguration {
    // Define environment
    enum Environment {
        case debug
        case release
    }

    let current: Environment
    private(set) var baseURL: String!

    init() {
        #if DEBUG
        current = .debug
        #elseif RELEASE
        current = .release
        #endif
        baseURL = getBaseURL()
    }

    private func getBaseURL() -> String {
        #if DEBUG
        return "https://jsonplaceholder.typicode.com"
        #elseif RELEASE
        return "https://jsonplaceholder.typicode.com"
        #endif
    }
}
