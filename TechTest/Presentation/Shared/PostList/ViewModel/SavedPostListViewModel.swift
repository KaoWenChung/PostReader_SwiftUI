//
//  SavedPostListViewModel.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

import Combine
import Dispatch

final class SavedPostListViewModel: PostListViewModelType {

    private let showSavedPostsUseCase: ShowSavedPostsUseCaseType
    private let actions: PostListViewModelActions?

    let title: String

    @Published private(set) var items: [Post] = []
    @Published var error: ErrorType?

    init(title: String,
         showSavedPostsUseCase: ShowSavedPostsUseCaseType,
         actions: PostListViewModelActions?) {
        self.title = title
        self.showSavedPostsUseCase = showSavedPostsUseCase
        self.actions = actions
    }
}

extension SavedPostListViewModel {
    func reloadData() {
        showSavedPostsUseCase.execute { result in
            DispatchQueue.main.async {
                self.items = result
            }
        }
    }

    func didSelectItem(_ item: Post) {
        actions?.showPostDetail(item)
    }
}
