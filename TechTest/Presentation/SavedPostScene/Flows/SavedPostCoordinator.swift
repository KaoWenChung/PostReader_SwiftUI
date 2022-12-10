//
//  SavedPostCoordinator.swift
//  TechTest
//
//  Created by wyn on 2022/11/30.
//

import SwiftUI

protocol SavedPostCoordinatorDependenciesType {
    func makeSavedPostListContentView(actions: PostListViewModelActions) -> PostListContentView<SavedPostListViewModel>
    func makeSavedPostDetailContentView(with content: Post, actions: PostDetailViewModelActions?) -> PostDetailContentView<SavedPostDetailViewModel>
}

protocol SavedPostCoordinatorType: CoordinatorType {
    var navigationController: UINavigationController { get }
}

final class SavedPostCoordinator: SavedPostCoordinatorType {
    let navigationController: UINavigationController
    private let dependencies: SavedPostCoordinatorDependenciesType
    
    init(navigationController: UINavigationController = .init(),
         dependencies: SavedPostCoordinatorDependenciesType) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() -> UIViewController {
        let contentView = dependencies.makeSavedPostListContentView(actions: PostListViewModelActions(showPostDetail: showSavedPostDetails))
        let vc = UIHostingController(rootView: contentView)
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }

    private func showSavedPostDetails(_ post: Post) {
        let contentView = dependencies.makeSavedPostDetailContentView(with: post, actions: PostDetailViewModelActions(showPostComment: nil, didTapSavedButton: didTapSavedButton))
        let vc = UIHostingController(rootView: contentView)
        navigationController.pushViewController(vc, animated: true)
    }

    private func didTapSavedButton() {
        _ = navigationController.popViewController(animated: true)
    }
}
