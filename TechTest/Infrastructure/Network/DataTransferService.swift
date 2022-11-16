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

public protocol DataTransferServiceType {
    
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E) async throws -> T where E.Response == T
    func request<E: ResponseRequestable>(with endpoint: E) async throws where E.Response == Void
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

public final class DefaultDataTransferService {
    
    private let networkService: NetworkServiceType
    private let errorResolver: DataTransferErrorResolverType
    private let errorLogger: DataTransferErrorLoggerType
    
    public init(with networkService: NetworkServiceType,
                errorResolver: DataTransferErrorResolverType = DefaultDataTransferErrorResolver(),
                errorLogger: DataTransferErrorLoggerType = DefaultDataTransferErrorLogger()) {
        self.networkService = networkService
        self.errorResolver = errorResolver
        self.errorLogger = errorLogger
    }
}

extension DefaultDataTransferService: DataTransferServiceType {
    
    public func request<T: Decodable, E: ResponseRequestable>(with endpoint: E) async throws -> T where E.Response == T {
        do {
            let data = try await networkService.request(endpoint: endpoint)
            let result: T = try decode(data: data, decoder: endpoint.responseDecoder)
            return result
        } catch let error as NetworkError {
            errorLogger.log(error: error)
            let error = self.resolve(networkError: error)
            throw error
        }
    }

    public func request<E>(with endpoint: E) async throws where E : ResponseRequestable, E.Response == Void {
        do {
            try await networkService.request(endpoint: endpoint)
        } catch let error as NetworkError {
            self.errorLogger.log(error: error)
            let error = self.resolve(networkError: error)
            throw error
        }
    }

    // MARK: - Private
    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoderType) throws -> T {
        do {
            guard let data = data else { throw DataTransferError.noResponse }
            let result: T = try decoder.decode(data)
            return result
        } catch {
            errorLogger.log(error: error)
            throw DataTransferError.parsing(error)
        }
    }
    
    private func resolve(networkError error: NetworkError) -> DataTransferError {
        let resolvedError = self.errorResolver.resolve(error: error)
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }
}

// MARK: - Logger
public final class DefaultDataTransferErrorLogger: DataTransferErrorLoggerType {
    public init() { }
    
    public func log(error: Error) {
        printIfDebug("-------------")
        printIfDebug("\(error)")
    }
}

// MARK: - Error Resolver
public class DefaultDataTransferErrorResolver: DataTransferErrorResolverType {
    public init() { }
    public func resolve(error: NetworkError) -> Error {
        return error
    }
}

// MARK: - Response Decoders
public class JSONResponseDecoder: ResponseDecoderType {
    private let jsonDecoder = JSONDecoder()
    public init() { }
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}

public class RawDataResponseDecoder: ResponseDecoderType {
    public init() { }
    
    enum CodingKeys: String, CodingKey {
        case `default` = ""
    }
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        if T.self is Data.Type, let data = data as? T {
            return data
        } else {
            let context = DecodingError.Context(codingPath: [CodingKeys.default], debugDescription: "Expected Data type")
            throw Swift.DecodingError.typeMismatch(T.self, context)
        }
    }
}
