//
//  PostSceneDIContainer.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//

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
    func makePostListContentView() -> PostListContentView<PostListViewModel> {
        return PostListContentView(viewModel: makePostListViewModel())
    }
    
    func makePostListViewModel() -> PostListViewModel {
        return PostListViewModel(showPostsUseCase: makeShowPostsUseCase())
    }

    // MARK: - Saved Post List
    func makeSavedPostListContentView() -> PostListContentView<SavedPostListViewModel> {
        return PostListContentView(viewModel: makeSavedPostListViewModel())
    }
    
    func makeSavedPostListViewModel() -> SavedPostListViewModel {
        return SavedPostListViewModel(showSavedPostsUseCase: makeShowSavedPostsUseCase())
    }

    // MARK: - Post Detail
    func makePostDetailContentView(withID id: Int) -> PostDetailContentView<PostDetailViewModel> {
        return PostDetailContentView(viewModel: makePostDetailViewModel(withID: id))
    }
    
    func makePostDetailViewModel(withID id: Int) -> PostDetailViewModel {
        return PostDetailViewModel(withID: id, useCase: makeShowPostDetailUseCase())
    }

    // MARK: - Post Comment
    func makePostCommentContentView(withID id: Int) -> PostCommentContentView<PostCommentViewModel> {
        return PostCommentContentView(viewModel: makePostCommentViewModel(withID: id))
    }
    
    func makePostCommentViewModel(withID id: Int) -> PostCommentViewModel {
        return PostCommentViewModel(withID: id, useCase: makeShowPostCommentUseCase())
    }
}
