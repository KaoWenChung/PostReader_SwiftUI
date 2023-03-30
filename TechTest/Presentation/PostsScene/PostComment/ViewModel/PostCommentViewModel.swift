//
//  PostCommentViewModel.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

import Combine
import Dispatch

protocol PostCommentViewModelInputType {
    func loadData() async
}
protocol PostCommentViewModelOutputType: ObservableObject {
    var items: [Comment] { get }
    var error: ErrorType? { get set }
}

protocol PostCommentViewModelType: PostCommentViewModelInputType, PostCommentViewModelOutputType {

}
final class PostCommentViewModel: PostCommentViewModelType {

    private let showPostCommentUseCase: ShowPostCommentUseCaseType
    private let id: Int
    @Published private(set) var items: [Comment] = []
    @Published var error: ErrorType?

    init(withID id: Int, useCase: ShowPostCommentUseCaseType) {
        self.showPostCommentUseCase = useCase
        self.id = id
    }
}

extension PostCommentViewModel {
    @MainActor
    func loadData() async {
        do {
            let value = try await showPostCommentUseCase.execute(withID: id)
            self.items = value
        } catch {
            self.error = ErrorType(errorDescription: ErrorDescription.notConnected)
        }
    }
}
