//
//  PostCoordinator.swift
//  TechTest
//
//  Created by wyn on 2022/11/30.
//

import SwiftUI

protocol PostCoordinatorDependenciesType {
    func makePostListContentView(actions: PostListViewModelActions) -> PostListContentView<PostListViewModel>
    func makePostDetailContentView(withID id: Int, actions: PostDetailViewModelActions?) -> PostDetailContentView<PostDetailViewModel>
    func makePostCommentContentView(withID id: Int) -> PostCommentContentView<PostCommentViewModel>
}

protocol PostCoordinatorType: CoordinatorType {
    var navigationController: UINavigationController { get }
}

final class PostCoordinator: PostCoordinatorType {
    let navigationController: UINavigationController
    private let dependencies: PostCoordinatorDependenciesType
    
    init(navigationController: UINavigationController = .init(),
         dependencies: PostCoordinatorDependenciesType) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() -> UIViewController {
        let contentView = dependencies.makePostListContentView(actions: PostListViewModelActions(showPostDetail: showPostDetails))
        let vc = UIHostingController(rootView: contentView)
        navigationController.pushViewController(vc, animated: true)
        return navigationController
    }

    private func showPostDetails(_ post: Post) {
        let contentView = dependencies.makePostDetailContentView(withID: post.id, actions: PostDetailViewModelActions(showPostComment: showPostComments))
        let vc = UIHostingController(rootView: contentView)
        navigationController.pushViewController(vc, animated: true)
    }

    private func showPostComments(_ postID: Int) {
        let contentView = dependencies.makePostCommentContentView(withID: postID)
        let vc = UIHostingController(rootView: contentView)
        navigationController.pushViewController(vc, animated: true)
    }
}
