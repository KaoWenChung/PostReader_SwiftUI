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

    // MARK: - UseCase
    func makeShowPostsUseCase() -> ShowPostsUseCaseType {
        return ShowPostsUseCase(postRepository: makePostRepository())
    }

    // MARK: - Repositories
    func makePostRepository() -> PostsRepositoryType {
        return PostsRepository(dataTransferService: dependencies.dataTransferService)
    }

    // MARK: - Post List
    func makePostListViewController() -> PostListContentView<PostListViewModel> {
        return PostListContentView(viewModel: makePostListViewModel())
    }
    
    func makePostListViewModel() -> PostListViewModel {
        return PostListViewModel(showPostsUseCase: makeShowPostsUseCase())
    }
}
