//
//  PostsRepository.swift
//  TechTest
//
//  Created by wyn on 2022/11/16.
//

final class PostsRepository {

    private let dataTransferService: DataTransferServiceType
    private let cache: PostsResponseStorageType

    init(dataTransferService: DataTransferServiceType, cache: PostsResponseStorageType) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }
}
