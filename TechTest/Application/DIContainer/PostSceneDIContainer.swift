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
    lazy var savedPostsResponseCache: SavedPostsResponseStorageType = CoreDataSavedPostsResponseStorage()

    // MARK: - UseCase
    func makeShowPostsUseCase() -> ShowPostsUseCaseType {
        return ShowPostsUseCase(postRepository: makePostListRepository())
    }

    func makeShowSavedPostsUseCase() -> ShowSavedPostsUseCaseType {
        return ShowSavedPostsUseCase(postRepository: makeSavedPostListRepository())
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

    func makeSavedPostListRepository() -> SavedPostListRepositoryType {
        return SavedPostListRepository(cache: savedPostsResponseCache)
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
        return PostListViewModel(showPostsUseCase: makeShowPostsUseCase(), actions: actions)
    }

    // MARK: - Saved Post List
    func makeSavedPostListContentView(actions: PostListViewModelActions) -> PostListContentView<SavedPostListViewModel> {
        return PostListContentView(viewModel: makeSavedPostListViewModel(actions: actions))
    }
    
    func makeSavedPostListViewModel(actions: PostListViewModelActions) -> SavedPostListViewModel {
        return SavedPostListViewModel(showSavedPostsUseCase: makeShowSavedPostsUseCase(), actions: actions)
    }

    // MARK: - Post Detail
    func makePostDetailContentView(withID id: Int) -> PostDetailContentView<PostDetailViewModel> {
        return PostDetailContentView(viewModel: makePostDetailViewModel(withID: id))
    }
    
    func makePostDetailViewModel(withID id: Int) -> PostDetailViewModel {
        return PostDetailViewModel(withID: id, useCase: makeShowPostDetailUseCase())
    }

    // MARK: - Saved Post Detail
    func makeSavedPostDetailContentView(with content: Post) -> PostDetailContentView<SavedPostDetailViewModel> {
        return PostDetailContentView(viewModel: makeSavedPostDetailViewModel(with: content))
    }
    
    func makeSavedPostDetailViewModel(with content: Post) -> SavedPostDetailViewModel {
        return SavedPostDetailViewModel(postData: content)
    }

    // MARK: - Post Comment
    func makePostCommentContentView(withID id: Int) -> PostCommentContentView<PostCommentViewModel> {
        return PostCommentContentView(viewModel: makePostCommentViewModel(withID: id))
    }
    
    func makePostCommentViewModel(withID id: Int) -> PostCommentViewModel {
        return PostCommentViewModel(withID: id, useCase: makeShowPostCommentUseCase())
    }
    // MARK: - Flow Coordinators
    func makePostFlowCoordinator(navigationController: UINavigationController? = UINavigationController()) -> PostCoordinator {
        return PostCoordinator(navigationController: navigationController, dependencies: self)
    }

}

extension PostSceneDIContainer: PostCoordinatorDependenciesType {}
