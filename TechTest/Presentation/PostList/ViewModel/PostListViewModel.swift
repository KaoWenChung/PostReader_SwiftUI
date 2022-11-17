//
//  PostListViewModel.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//

import Combine

protocol PostListViewModelInputType {
    func onAppear()
}
protocol PostListViewModelOutputType: ObservableObject {
    var items: [Post] { get }
}
protocol PostListViewModelType: PostListViewModelInputType, PostListViewModelOutputType { }

final class PostListViewModel: PostListViewModelType {

    private let showPostsUseCase: ShowPostsUseCaseType
    @Published private(set) var items: [Post] = []
    
    init(showPostsUseCase: ShowPostsUseCaseType) {
        self.showPostsUseCase = showPostsUseCase
    }

    func onAppear() {
        Task.init {
            let (value, taskCancelable) = try await showPostsUseCase.execute()
            items = value
        }
    }
    
    private(set) var displayedPosts: [Post] = []
    
    func fetchAllPosts() {
        
    }
}
