//
//  AppDIContainer.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//

import Foundation

final class AppDIContainer {

    static let appConfiguration = AppConfiguration()

    // MARK: - Network
    static var apiDataTransferService = {
        let config = APIDataNetworkConfig(baseURL: URL(string: appConfiguration.baseURL)!)
        let apiDataNetwork = NetworkService(config: config)
        return DataTransferService(networkService: apiDataNetwork)
    }()

    // MARK: - DIContainers of scenes
    static func makePostSceneDIContainer() -> PostSceneDIContainer {
        let dependencies = PostSceneDIContainer.Dependencies(dataTransferService: apiDataTransferService)
        return PostSceneDIContainer(dependencies: dependencies)
    }

}
