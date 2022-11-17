//
//  DataTransferServiceType.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//

import Foundation

public protocol DataTransferServiceType {
    
    func request<T: Decodable, E: ResponseRequestableType>(with endpoint: E) async throws -> (T, TaskCancellable) where E.Response == T
    func request<E: ResponseRequestableType>(with endpoint: E) async throws -> TaskCancellable where E.Response == Void
}

public protocol DataTransferErrorResolverType {
    func resolve(error: NetworkError) -> Error
}

public protocol ResponseDecoderType {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

public protocol DataTransferErrorLoggerType {
    func log(error: Error)
}

public protocol ResponseRequestableType: RequestableType {
    associatedtype Response
    var responseDecoder: ResponseDecoderType { get }
}
