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

protocol HomeCoordinatorType: CoordinatorType {
}

protocol OrdersCoordinatorType: CoordinatorType {
}

class HomeCoordinator: HomeCoordinatorType {
    lazy var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        return UIViewController()
    }
    
    var parentCoordinator: MainCoordinatorType?
    
    
}

class OrdersCoordinator: OrdersCoordinatorType {
    lazy var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        return UIViewController()
    }
    
    var parentCoordinator: MainCoordinatorType?
    
    
}


protocol MainCoordinatorType: CoordinatorType {
    var homeCoordinator: HomeCoordinatorType { get }
    var ordersCoordinator: OrdersCoordinatorType { get }
    func moveTo(flow: AppFlow)
}

final class MainCoordinator: MainCoordinatorType {
    var parentCoordinator: MainCoordinatorType?
    lazy var rootViewController: UIViewController = UITabBarController()
    lazy var homeCoordinator: HomeCoordinatorType = HomeCoordinator()
    lazy var ordersCoordinator: OrdersCoordinatorType = OrdersCoordinator()
    
    func start() -> UIViewController {
        
        let homeViewController = homeCoordinator.start()
        homeCoordinator.parentCoordinator = self
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "homekit"), tag: 0)
        
        let ordersViewController = ordersCoordinator.start()
        ordersCoordinator.parentCoordinator = self
        ordersViewController.tabBarItem = UITabBarItem(title: "Orders", image: UIImage(systemName: "doc.plaintext"), tag: 1)
        
        (rootViewController as? UITabBarController)?.viewControllers = [homeViewController,ordersViewController]
        
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
        homeCoordinator.resetToRoot()
        moveTo(flow: .postList)
        return self
    }
}
