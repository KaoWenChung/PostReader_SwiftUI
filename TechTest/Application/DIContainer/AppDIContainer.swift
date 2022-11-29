//
//  AppDIContainer.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//

import Foundation

final class AppDIContainer {

    lazy var appConfiguration = AppConfiguration()

    // MARK: - Network
    lazy var apiDataTransferService = {
        let config = APIDataNetworkConfig(baseURL: URL(string: appConfiguration.baseURL)!)
        let apiDataNetwork = NetworkService(config: config)
        return DataTransferService(networkService: apiDataNetwork)
    }()

    // MARK: - DIContainers of scenes
    func makePostSceneDIContainer() -> PostSceneDIContainer {
        let dependencies = PostSceneDIContainer.Dependencies(dataTransferService: apiDataTransferService)
        return PostSceneDIContainer(dependencies: dependencies)
    }

}
