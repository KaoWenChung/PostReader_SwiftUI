//
//  PostListViewModel.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//

import Combine
import Dispatch
import SwiftUI

struct PostListViewModelActions {
    let showPostDetail: (Post) -> Void
}

protocol PostListViewModelInputType {
    func reloadData() async
}

protocol PostListViewModelOutputType: ObservableObject {
    var items: [Post] { get }
    var error: ErrorType? { get set }
    func didSelectItem(_ item: Post)
}

protocol PostListViewModelType: PostListViewModelInputType, PostListViewModelOutputType { }

final class PostListViewModel: PostListViewModelType {

    private let showPostsUseCase: ShowPostsUseCaseType
    private let actions: PostListViewModelActions?

    @Published private(set) var items: [Post] = []
    @Published var error: ErrorType? = nil
    
    init(showPostsUseCase: ShowPostsUseCaseType,
         actions: PostListViewModelActions?) {
        self.showPostsUseCase = showPostsUseCase
        self.actions = actions
    }

}

extension PostListViewModel {

    @MainActor
    func reloadData() async {
        do {
            let (value, _) = try await showPostsUseCase.execute()
            items = value
        } catch {
            self.error = ErrorType(errorDescription: ErrorDescription.notConnected)
        }
    }

    func didSelectItem(_ item: Post) {
        actions?.showPostDetail(item)
    }
}
