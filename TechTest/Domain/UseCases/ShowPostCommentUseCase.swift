//
//  ShowPostCommentUseCase.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

protocol ShowPostCommentUseCaseType {
    func execute(withID id: Int) async throws -> [Comment]
}

final class ShowPostCommentUseCase: ShowPostCommentUseCaseType {

    private let repository: PostCommentRepositoryType

    init(repository: PostCommentRepositoryType) {

        self.repository = repository
    }

    func execute(withID id: Int) async throws -> [Comment] {
        return try await repository.fetchPostComment(withID: id)
    }
}
