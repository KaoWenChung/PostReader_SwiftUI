//
//  ShowPostsUseCase.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//

protocol ShowPostsUseCaseType {
    func execute() async throws -> ([Post], CancellableType)
}

final class ShowPostsUseCase: ShowPostsUseCaseType {

    private let postRepository: PostsRepositoryType

    init(postRepository: PostsRepositoryType) {

        self.postRepository = postRepository
    }

    func execute() async throws -> ([Post], CancellableType) {
        return try await postRepository.fetchPostList()
    }
}
