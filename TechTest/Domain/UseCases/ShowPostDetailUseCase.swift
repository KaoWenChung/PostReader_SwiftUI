//
//  ShowPostDetailUseCase.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

protocol ShowPostDetailUseCaseType {
    func execute(withID id: Int) async throws -> Post
}

final class ShowPostDetailUseCase: ShowPostDetailUseCaseType {

    private let repository: PostDetailRepositoryType

    init(repository: PostDetailRepositoryType) {

        self.repository = repository
    }

    func execute(withID id: Int) async throws -> Post {
        return try await repository.fetchPostDetail(withID: id)
    }
}
