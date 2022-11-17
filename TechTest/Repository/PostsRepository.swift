//
//  PostsRepository.swift
//  TechTest
//
//  Created by wyn on 2022/11/16.
//

import Foundation

final class PostsRepository {

    private let dataTransferService: DataTransferServiceType

    init(dataTransferService: DataTransferServiceType) {
        self.dataTransferService = dataTransferService
    }
}

protocol PostsRepositoryType {
    func fetchPostList() async throws -> ([Post], CancellableType)
}

extension PostsRepository: PostsRepositoryType {
    func fetchPostList() async throws -> ([Post], CancellableType) {
        let task = RepositoryTask()
        let endpoint = APIEndpoints.getPostList()
        let (data, taskCancelable) = try await dataTransferService.request(with: endpoint)
        task.networkTask = taskCancelable
        return (data, task)
    }
    
    
}
