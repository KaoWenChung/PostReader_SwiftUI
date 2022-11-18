//
//  ShowPostDetailUseCase.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

protocol ShowPostDetailUseCaseType {
    func execute(withID id: Int, completion: @escaping (Post) -> Void)
    func save(response: Post, for request: PostsRequest)
}

final class ShowPostDetailUseCase: ShowPostDetailUseCaseType {

    private let repository: PostDetailRepositoryType

    init(repository: PostDetailRepositoryType) {

        self.repository = repository
    }

    func execute(withID id: Int, completion: @escaping (Post) -> Void) {
        repository.fetchPostDetail(withID: id) { value in
            completion(value)
        }
    }

    func save(response: Post, for request: PostsRequest) {
        repository.save(response: response, for: request)
    }
}
