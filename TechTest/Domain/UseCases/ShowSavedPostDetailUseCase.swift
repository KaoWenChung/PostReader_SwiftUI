//
//  ShowSavedPostDetailUseCase.swift
//  TechTest
//
//  Created by wyn on 2022/12/9.
//

protocol ShowSavedPostDetailUseCaseType {
    func delete(_ request: PostsRequest)
}

final class ShowSavedPostDetailUseCase: ShowSavedPostDetailUseCaseType {

    private let repository: PostDetailRepositoryType

    init(repository: PostDetailRepositoryType) {

        self.repository = repository
    }

    func delete(_ request: PostsRequest) {
        repository.delete(request)
    }
}
