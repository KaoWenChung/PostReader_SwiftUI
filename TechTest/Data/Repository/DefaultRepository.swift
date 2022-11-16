//
//  DefaultRepository.swift
//  TechTest
//
//  Created by wyn on 2022/11/16.
//

final class DefaultMoviesRepository {

    private let dataTransferService: DataTransferService
    private let cache: PostsResponseStorageType

    init(dataTransferService: DataTransferService, cache: PostsResponseStorageType) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }
}
