//
//  SavedPostCoordinator.swift
//  TechTest
//
//  Created by wyn on 2022/11/30.
//

import SwiftUI

protocol SavedPostCoordinatorDependenciesType {
    func makeSavedPostListContentView(actions: PostListViewModelActions) -> PostListContentView<SavedPostListViewModel>
}

protocol SavedPostCoordinatorType: CoordinatorType {
    var navigationController: UINavigationController? { get }
}

final class SavedPostCoordinator: SavedPostCoordinatorType {
    private(set) weak var navigationController: UINavigationController?
    private let dependencies: SavedPostCoordinatorDependenciesType
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    var parentCoordinator: AppFlowCoordinator?
    
    init(navigationController: UINavigationController?,
         dependencies: SavedPostCoordinatorDependenciesType) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() -> UIViewController {
        navigationRootViewController
        return UIViewController()
    }
}
