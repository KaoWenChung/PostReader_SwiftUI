//
//  CoordinatorType.swift
//  TechTest
//
//  Created by wyn on 2022/11/29.
//

import SwiftUI

protocol FlowCoordinatorType: AnyObject {
    var parentCoordinator: AppFlowCoordinator? { get set }
}

protocol CoordinatorType: FlowCoordinatorType {
    var rootViewController: UIViewController { get set }
    func start() -> UIViewController
    @discardableResult func resetToRoot() -> Self
}

extension CoordinatorType {
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
