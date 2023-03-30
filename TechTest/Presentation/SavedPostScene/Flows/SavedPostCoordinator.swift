//
//  SavedPostCoordinator.swift
//  TechTest
//
//  Created by wyn on 2022/11/30.
//

import SwiftUI

protocol SavedPostCoordinatorDependenciesType {
    func makeSavedPostListContentView(actions: PostListViewModelActions) -> PostListContentView<SavedPostListViewModel>
    func makeSavedPostDetailContentView(
        with content: Post,
        actions: PostDetailViewModelActions?
    ) -> PostDetailContentView<SavedPostDetailViewModel>
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
        let actions = PostListViewModelActions(showPostDetail: showSavedPostDetails)
        let contentView = dependencies.makeSavedPostListContentView(actions: actions)
        let viewcontroller = UIHostingController(rootView: contentView)
        navigationController.pushViewController(viewcontroller, animated: true)
        return navigationController
    }

    private func showSavedPostDetails(_ post: Post) {
        let actions = PostDetailViewModelActions(showPostComment: nil, didTapSavedButton: didTapSavedButton)
        let contentView = dependencies.makeSavedPostDetailContentView(with: post, actions: actions)
        let viewcontroller = UIHostingController(rootView: contentView)
        navigationController.pushViewController(viewcontroller, animated: true)
    }

    private func didTapSavedButton() {
        _ = navigationController.popViewController(animated: true)
    }
}
