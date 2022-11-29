//
//  PostListViewModel.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//

import Combine
import Dispatch
import SwiftUI

struct PostListViewModelActions<DestinationView: View> {
    let showPostDetail: (Post) -> DestinationView
}

protocol PostListViewModelInputType {
    func onAppear()
}
protocol PostListViewModelOutputType: ObservableObject {
    associatedtype ItemView: View
    associatedtype DestinationView: View
    var items: [Post] { get }
    var error: Error? { get }
    func itemView(_ data: Post) -> ItemView
    func destinationView(_ item: Post) -> DestinationView
}
protocol PostListViewModelType: PostListViewModelInputType, PostListViewModelOutputType { }

final class PostListViewModel<DestinationView: View>: PostListViewModelType {

    private let showPostsUseCase: ShowPostsUseCaseType
    private let actions: PostListViewModelActions<DestinationView>?

    @Published private(set) var items: [Post] = []
    @Published private(set) var error: Error?
    
    init(showPostsUseCase: ShowPostsUseCaseType,
         actions: PostListViewModelActions<DestinationView>?) {
        self.showPostsUseCase = showPostsUseCase
        self.actions = actions
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

extension PostListViewModel {
    func destinationView(_ item: Post) -> some View {
        return actions?.showPostDetail(item)
    }

    func itemView(_ item: Post) -> some View {
        return PostListItemView(itemData: item)
    }
}
