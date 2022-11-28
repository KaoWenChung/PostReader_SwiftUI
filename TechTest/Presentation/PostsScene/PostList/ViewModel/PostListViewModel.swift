//
//  PostListViewModel.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//

import Combine
import Dispatch
/*
 TODO: Separate the concern of user event
struct PostListViewModelActions {
    let showPostDetail: (Post) -> Void
}
*/
protocol PostListViewModelInputType {
    func onAppear()
}
protocol PostListViewModelOutputType: ObservableObject {
    var items: [Post] { get }
    var error: Error? { get }
}
protocol PostListViewModelType: PostListViewModelInputType, PostListViewModelOutputType { }

final class PostListViewModel: PostListViewModelType {

    private let showPostsUseCase: ShowPostsUseCaseType
//    private let actions: PostListViewModelActions?

    @Published private(set) var items: [Post] = []
    @Published private(set) var error: Error?
    
    init(showPostsUseCase: ShowPostsUseCaseType) {
        self.showPostsUseCase = showPostsUseCase
    }

    func onAppear() {
        Task.init {
            do {
                let (value, _) = try await showPostsUseCase.execute()
                DispatchQueue.main.async {
                    self.items = value
                }
            } catch let error as NetworkError {
                self.error = error
            }
        }
    }
}
