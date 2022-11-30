//
//  SavedPostSceneDIContainer.swift
//  TechTest
//
//  Created by wyn on 2022/11/30.
//

import SwiftUI

final class SavedPostSceneDIContainer {

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
    func makeShowSavedPostsUseCase() -> ShowSavedPostsUseCaseType {
        return ShowSavedPostsUseCase(postRepository: makeSavedPostListRepository())
    }

    // MARK: - Repositories

    func makeSavedPostListRepository() -> SavedPostListRepositoryType {
        return SavedPostListRepository(cache: savedPostsResponseCache)
    }

    // MARK: - Saved Post List
    func makeSavedPostListContentView(actions: PostListViewModelActions) -> PostListContentView<SavedPostListViewModel> {
        return PostListContentView(viewModel: makeSavedPostListViewModel(actions: actions))
    }

    func makeSavedPostListViewModel(actions: PostListViewModelActions) -> SavedPostListViewModel {
        return SavedPostListViewModel(showSavedPostsUseCase: makeShowSavedPostsUseCase(), actions: actions)
    }

    // MARK: - Saved Post Detail
    func makeSavedPostDetailContentView(with content: Post) -> PostDetailContentView<SavedPostDetailViewModel> {
        return PostDetailContentView(viewModel: makeSavedPostDetailViewModel(with: content))
    }

    func makeSavedPostDetailViewModel(with content: Post) -> SavedPostDetailViewModel {
        return SavedPostDetailViewModel(postData: content)
    }
    
    // MARK: - Flow Coordinators
    func makeSavedPostFlowCoordinator(navigationController: UINavigationController? = UINavigationController()) -> SavedPostCoordinator {
        return SavedPostCoordinator(navigationController: navigationController, dependencies: self)
    }

}

extension SavedPostSceneDIContainer: SavedPostCoordinatorDependenciesType {}
