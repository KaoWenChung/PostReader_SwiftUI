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
    lazy var moviesResponseCache: PostsResponseStorageType = CoreDataPostsResponseStorage()

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
        return PostDetailRepository(dataTransferService: dependencies.dataTransferService, cache: moviesResponseCache)
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
