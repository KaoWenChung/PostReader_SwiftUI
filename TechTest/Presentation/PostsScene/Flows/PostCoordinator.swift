//
//  PostCoordinator.swift
//  TechTest
//
//  Created by wyn on 2022/11/30.
//

import SwiftUI

protocol PostCoordinatorDependenciesType {
    func makePostListContentView(actions: PostListViewModelActions) -> PostListContentView<PostListViewModel>
}

protocol PostCoordinatorType: CoordinatorType {
    var navigationController: UINavigationController? { get }
}

final class PostCoordinator: PostCoordinatorType {
    private(set) weak var navigationController: UINavigationController?
    private let dependencies: PostCoordinatorDependenciesType
    
    lazy var rootViewController: UIViewController = UIViewController()
    
    var parentCoordinator: MainCoordinatorType?
    
    init(navigationController: UINavigationController?,
         dependencies: PostCoordinatorDependenciesType) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() -> UIViewController {
        navigationRootViewController
        return UIViewController()
    }
}
