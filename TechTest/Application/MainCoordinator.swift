//
//  MainCoordinator.swift
//  TechTest
//
//  Created by wyn on 2022/11/29.
//

import SwiftUI

enum AppFlow {
    case MostViewed
    case Favorites
}

protocol FlowCoordinator: AnyObject {
    var parentCoordinator: MainBaseCoordinator? { get set }
}

protocol Coordinator: FlowCoordinator {
    var rootViewController: UIViewController { get set }
    func start() -> UIViewController
    @discardableResult func resetToRoot() -> Self
}

extension Coordinator {
    var navigationRootViewController: UINavigationController? {
        get {
            (rootViewController as? UINavigationController)
        }
    }
    
    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: false)
        return self
    }
}

protocol MainBaseCoordinator: Coordinator {
//    var homeCoordinator: HomeBaseCoordinator { get }
//    var ordersCoordinator: OrdersBaseCoordinator { get }
//    var deepLinkCoordinator: DeepLinkBaseCoordinator { get }
    func moveTo(flow: AppFlow)
    func handleDeepLink(text: String)
}

final class MainCoordinator {
    
}
