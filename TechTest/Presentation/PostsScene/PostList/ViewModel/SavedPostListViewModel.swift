//
//  SavedPostListViewModel.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

import SwiftUI
import Dispatch

final class SavedPostListViewModel: PostListViewModelType {

    private let showSavedPostsUseCase: ShowSavedPostsUseCaseType
    private let actions: PostListViewModelActions?

    @Published private(set) var items: [Post] = []
    @Published private(set) var error: Error?
    
    init(showSavedPostsUseCase: ShowSavedPostsUseCaseType,
         actions: PostListViewModelActions?) {
        self.showSavedPostsUseCase = showSavedPostsUseCase
        self.actions = actions
    }

    func onAppear() {
        showSavedPostsUseCase.execute() { result in
            DispatchQueue.main.async {
                self.items = result
            }
        }
    }
}

extension SavedPostListViewModel {
    func destinationView(_ item: Post) {
        actions?.showPostDetail(item)
    }

    func itemView(_ item: Post) {
        PostListItemView(itemData: item)
    }
}
