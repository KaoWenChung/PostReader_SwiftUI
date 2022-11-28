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

    @Published private(set) var items: [Post] = []
    @Published private(set) var error: Error?
    
    init(showSavedPostsUseCase: ShowSavedPostsUseCaseType) {
        self.showSavedPostsUseCase = showSavedPostsUseCase
    }

    func onAppear() {
        showSavedPostsUseCase.execute() { result in
            DispatchQueue.main.async {
                self.items = result
            }
        }
    }
}
