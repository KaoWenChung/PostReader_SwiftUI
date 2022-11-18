//
//  ShowSavedPostsUseCase.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

protocol ShowSavedPostsUseCaseType {
    func execute(completion: @escaping ([Post]) -> Void)
}

final class ShowSavedPostsUseCase: ShowSavedPostsUseCaseType {

    private let postRepository: SavedPostListRepositoryType

    init(postRepository: SavedPostListRepositoryType) {

        self.postRepository = postRepository
    }

    func execute(completion: @escaping ([Post]) -> Void) {
        postRepository.fetchPostList(completion: completion)
    }
}
