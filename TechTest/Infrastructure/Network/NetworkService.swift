//
//  NetworkService.swift
//  TechTest
//
//  Created by wyn on 2022/11/16.
//

import Foundation

public enum NetworkError: Error {
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

public protocol NetworkServiceType {
    @discardableResult
    func request(endpoint: Requestable) async throws -> Data?
}

public protocol NetworkErrorLoggerType {
    func log(request: URLRequest)
    func log(responseData data: Data?, response: URLResponse?)
    func log(error: Error)
}

// MARK: - Implementation

public struct NetworkService {
    
    private let config: NetworkConfigurableType
    private let logger: NetworkErrorLoggerType
    
    public init(config: NetworkConfigurableType,
                logger: NetworkErrorLoggerType = NetworkErrorLogger()) {
        self.config = config
        self.logger = logger
    }
    
    private func request(request: URLRequest) async throws -> Data? {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            logger.log(responseData: data, response: response)
            logger.log(request: request)
            return data
        } catch let requestError {
            let error = resolve(error: requestError)
            logger.log(error: error)
            throw error
        }
    }
    
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }
}

extension NetworkService: NetworkServiceType {
    @discardableResult
    public func request(endpoint: Requestable) async throws -> Data? {
        do {
            let urlRequest = try endpoint.urlRequest(with: config)
            return try await request(request: urlRequest)
        } catch {
            throw NetworkError.urlGeneration
        }
    }
}

// MARK: - Logger

public final class NetworkErrorLogger: NetworkErrorLoggerType {
    public init() { }

    public func log(request: URLRequest) {
        print("-------------")
        print("request: \(request.url!)")
        print("headers: \(request.allHTTPHeaderFields!)")
        print("method: \(request.httpMethod!)")
        if let httpBody = request.httpBody, let result = ((try? JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: AnyObject]) as [String: AnyObject]??) {
            printIfDebug("body: \(String(describing: result))")
        } else if let httpBody = request.httpBody, let resultString = String(data: httpBody, encoding: .utf8) {
            printIfDebug("body: \(String(describing: resultString))")
        }
    }

    public func log(responseData data: Data?, response: URLResponse?) {
        guard let data = data else { return }
        if let dataDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            printIfDebug("responseData: \(String(describing: dataDict))")
        }
    }

    public func log(error: Error) {
        printIfDebug("\(error)")
    }
}

extension Dictionary where Key == String {
    func prettyPrint() -> String {
        var string: String = ""
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            if let nstr = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                string = nstr as String
            }
        }
        return string
    }
}

func printIfDebug(_ string: String) {
    #if DEBUG
    print(string)
    #endif
}