//
//  DataTransferService.swift
//  TechTest
//
//  Created by wyn on 2022/11/16.
//

import Foundation

public enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

public protocol DataTransferService {
    
    @discardableResult
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E) async throws -> NetworkCancellable? where E.Response == T
    @discardableResult
    func request<E: ResponseRequestable>(with endpoint: E) async throws -> NetworkCancellable? where E.Response == Void
}

public protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}
