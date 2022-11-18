//
//  ShowPostDetailUseCase.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

protocol ShowPostDetailUseCaseType {
    func execute(withID id: Int, completion: @escaping (Post) -> Void)
    func checkSaveStatus(by request: PostsRequest, completion: @escaping (Bool) -> Void)
    func save(response: Post, for request: PostsRequest)
    func delete(_ request: PostsRequest)
}

final class ShowPostDetailUseCase: ShowPostDetailUseCaseType {

    private let repository: PostDetailRepositoryType

    init(repository: PostDetailRepositoryType) {

        self.repository = repository
    }

    func execute(withID id: Int, completion: @escaping (Post) -> Void) {
        repository.fetchPostDetail(withID: id, completion: completion)
    }

    func checkSaveStatus(by request: PostsRequest, completion: @escaping (Bool) -> Void) {
        repository.checkSaveStatus(by: request, completion: completion)
    }

    func save(response: Post, for request: PostsRequest) {
        repository.save(response: response, for: request)
    }

    func delete(_ request: PostsRequest) {
        repository.delete(request)
    }
}
