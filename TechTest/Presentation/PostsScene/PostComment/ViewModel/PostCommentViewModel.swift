//
//  PostCommentViewModel.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

import Combine
import Dispatch

protocol PostCommentViewModelInputType {
    func onAppear()
}
protocol PostCommentViewModelOutputType: ObservableObject {
    var items: [Comment] { get }
}

protocol PostCommentViewModelType: PostCommentViewModelInputType, PostCommentViewModelOutputType {
    
}
final class PostCommentViewModel: PostCommentViewModelType {

    private let showPostCommentUseCase: ShowPostCommentUseCaseType
    private let id: Int
    @Published private(set) var items: [Comment] = []
    

    init(withID id: Int, useCase: ShowPostCommentUseCaseType) {
        self.showPostCommentUseCase = useCase
        self.id = id
    }

    func onAppear() {
        Task.init {
            let value = try await showPostCommentUseCase.execute(withID: id)
            DispatchQueue.main.async {
                self.items = value
            }
        }
    }
}
