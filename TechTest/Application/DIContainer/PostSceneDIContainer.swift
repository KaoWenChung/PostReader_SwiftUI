//
//  PostSceneDIContainer.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//
import SwiftUI

final class PostSceneDIContainer {
    struct Dependencies {
        let dataTransferService: DataTransferServiceType
    }
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Persistent Storage
    lazy var postsResponseCache: PostsResponseStorageType = CoreDataPostsResponseStorage()

    // MARK: - UseCase
    func makeShowPostsUseCase() -> ShowPostsUseCaseType {
        return ShowPostsUseCase(postRepository: makePostListRepository())
    }

    func makeShowPostDetailUseCase() -> ShowPostDetailUseCaseType {
        return ShowPostDetailUseCase(repository: makePostDetailRepository())
    }

    func makeShowPostCommentUseCase() -> ShowPostCommentUseCaseType {
        return ShowPostCommentUseCase(repository: makePostCommentRepository())
    }

    // MARK: - Repositories
    func makePostListRepository() -> PostListRepositoryType {
        return PostListRepository(dataTransferService: dependencies.dataTransferService)
    }

    func makePostDetailRepository() -> PostDetailRepositoryType {
        return PostDetailRepository(dataTransferService: dependencies.dataTransferService, cache: postsResponseCache)
    }

    func makePostCommentRepository() -> PostCommentRepository {
        return PostCommentRepository(dataTransferService: dependencies.dataTransferService)
    }

    // MARK: - Post List
    func makePostListContentView(actions: PostListViewModelActions) -> PostListContentView<PostListViewModel> {
        return PostListContentView(viewModel: makePostListViewModel(actions: actions))
    }

    func makePostListViewModel(actions: PostListViewModelActions) -> PostListViewModel {
        return PostListViewModel(title: CommonString.allPosts.text,
                                 showPostsUseCase: makeShowPostsUseCase(),
                                 actions: actions)
    }

    // MARK: - Post Detail
    func makePostDetailContentView(withID id: Int,
                                   actions: PostDetailViewModelActions?) -> PostDetailContentView<PostDetailViewModel> {
        return PostDetailContentView(viewModel: makePostDetailViewModel(withID: id, actions: actions))
    }

    func makePostDetailViewModel(withID id: Int, actions: PostDetailViewModelActions?) -> PostDetailViewModel {
        return PostDetailViewModel(withID: id, useCase: makeShowPostDetailUseCase(), actions: actions)
    }

    // MARK: - Post Comment
    func makePostCommentContentView(withID id: Int) -> PostCommentContentView<PostCommentViewModel> {
        return PostCommentContentView(viewModel: makePostCommentViewModel(withID: id))
    }

    func makePostCommentViewModel(withID id: Int) -> PostCommentViewModel {
        return PostCommentViewModel(withID: id, useCase: makeShowPostCommentUseCase())
    }
    // MARK: - Flow Coordinators
    func makePostFlowCoordinator(
        navigationController: UINavigationController = UINavigationController()
    ) -> PostCoordinator {
        return PostCoordinator(navigationController: navigationController, dependencies: self)
    }

}

extension PostSceneDIContainer: PostCoordinatorDependenciesType {}
