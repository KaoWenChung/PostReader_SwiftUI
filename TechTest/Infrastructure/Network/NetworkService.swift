//
//  NetworkService.swift
//  TechTest
//
//  Created by wyn on 2022/11/16.
//

import Foundation

public enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

public protocol NetworkCancellable {
    func cancel()
}

extension Task: NetworkCancellable { }
