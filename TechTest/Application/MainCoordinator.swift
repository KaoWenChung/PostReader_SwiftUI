//
//  MainCoordinator.swift
//  TechTest
//
//  Created by wyn on 2022/11/29.
//

import SwiftUI

enum AppFlow {
    case postList
    case savePostList
}

protocol SavedPostCoordinatorType: CoordinatorType {
}

class SavedPostCoordinator: SavedPostCoordinatorType {
    lazy var rootViewController: UIViewController = UIViewController()

    var parentCoordinator: MainCoordinatorType?
    
    func start() -> UIViewController {
        return UIViewController()
    }
}

protocol MainCoordinatorType: CoordinatorType {
    var postCoordinator: PostCoordinatorType? { get }
    var ordersCoordinator: SavedPostCoordinatorType? { get }
    func moveTo(flow: AppFlow)
}

final class MainCoordinator: MainCoordinatorType {
    var parentCoordinator: MainCoordinatorType?
    var postCoordinator: PostCoordinatorType?
    var ordersCoordinator: SavedPostCoordinatorType?
    
    lazy var rootViewController: UIViewController = UITabBarController()
    
    private let appDIContainer: AppDIContainer

    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
    }
    
    func start() -> UIViewController {
        let postSceneDIContainer = appDIContainer.makePostSceneDIContainer()
        let flow = postSceneDIContainer.makePostFlowCoordinator()
        flow.parentCoordinator = self
        postCoordinator = flow
        let postViewController = flow.start()
        
        postViewController.tabBarItem = UITabBarItem(title: "Post", image: UIImage(systemName: "newspaper.fill"), tag: 0)

        let ordersViewController = ordersCoordinator!.start()
        ordersCoordinator?.parentCoordinator = self
        ordersViewController.tabBarItem = UITabBarItem(title: "Bookmark", image: UIImage(systemName: "book.fill"), tag: 1)
        
        (rootViewController as? UITabBarController)?.viewControllers = [postViewController, ordersViewController]
        
        return rootViewController
    }
    func moveTo(flow: AppFlow) {
        switch flow {
        case .postList:
            (rootViewController as? UITabBarController)?.selectedIndex = 0
        case .savePostList:
            (rootViewController as? UITabBarController)?.selectedIndex = 1
        }
    }

    func resetToRoot() -> Self {
        postCoordinator?.resetToRoot()
        moveTo(flow: .postList)
        return self
    }
}
