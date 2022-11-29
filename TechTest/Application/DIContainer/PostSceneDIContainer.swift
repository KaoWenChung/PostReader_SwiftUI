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
    func makePostListContentView<DestinationView: View>(actions: PostListViewModelActions<DestinationView>) -> PostListContentView<PostListViewModel<DestinationView>> {
        return PostListContentView(viewModel: makePostListViewModel(actions: actions))
    }
    
    func makePostListViewModel<DestinationView: View>(actions: PostListViewModelActions<DestinationView>) -> PostListViewModel<DestinationView> {
        return PostListViewModel(showPostsUseCase: makeShowPostsUseCase(), actions: actions)
    }

    // MARK: - Saved Post List
    func makeSavedPostListContentView<DestinationView: View>(actions: PostListViewModelActions<DestinationView>) -> PostListContentView<SavedPostListViewModel<DestinationView>> {
        return PostListContentView(viewModel: makeSavedPostListViewModel(actions: actions))
    }
    
    func makeSavedPostListViewModel<DestinationView: View>(actions: PostListViewModelActions<DestinationView>) -> SavedPostListViewModel<DestinationView> {
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

    // MARK: - Tab bar View
    func makeTabbarContentView<PostDestinationView: View, SavedPostDestinationView: View>(postListView: PostDestinationView, savedPostListView: SavedPostDestinationView) -> TabbarContentView<PostDestinationView, SavedPostDestinationView> {
        return TabbarContentView(viewModel: makeTabbarViewModel(postListView: postListView, savedPostListView: savedPostListView))
    }

    func makeTabbarViewModel<PostDestinationView: View, SavedPostDestinationView: View>(postListView: PostDestinationView, savedPostListView: SavedPostDestinationView) -> TabbarViewModel<PostDestinationView, SavedPostDestinationView> {
        return TabbarViewModel(postListView: postListView, savedPostListView: savedPostListView)
    }
}
