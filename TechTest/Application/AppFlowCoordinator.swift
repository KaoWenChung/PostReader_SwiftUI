//
//  AppFlowCoordinator.swift
//  TechTest
//
//  Created by wyn on 2022/11/29.
//

import SwiftUI

protocol AppFlowCoordinatorType: CoordinatorType {
    var postCoordinator: PostCoordinatorType? { get }
    var savedPostCoordinator: SavedPostCoordinatorType? { get }
}

final class AppFlowCoordinator: AppFlowCoordinatorType {
    var postCoordinator: PostCoordinatorType?
    var savedPostCoordinator: SavedPostCoordinatorType?
    
    private let appDIContainer: AppDIContainer

    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
    }
    
    func start() -> UIViewController {
        let postSceneDIContainer = appDIContainer.makePostSceneDIContainer()
        let postFlow = postSceneDIContainer.makePostFlowCoordinator()
        postCoordinator = postFlow
        let postViewController = postFlow.start()
        
        postViewController.tabBarItem = UITabBarItem(title: "Post", image: UIImage(systemName: "newspaper.fill"), tag: 0)

        let savedPostSceneDIContainer = appDIContainer.makeSavedPostSceneDIContainer()
        let savedPostFlow = savedPostSceneDIContainer.makeSavedPostFlowCoordinator()
        savedPostCoordinator = savedPostFlow
        let ordersViewController = savedPostFlow.start()
        
        ordersViewController.tabBarItem = UITabBarItem(title: "Bookmark", image: UIImage(systemName: "book.fill"), tag: 1)
        
        let rootViewController = UITabBarController()
        rootViewController.viewControllers = [postViewController, ordersViewController]
        
        return rootViewController
    }
}
