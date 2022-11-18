//
//  SavedPostListRepository.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

final class SavedPostListRepository {

    private let cache: SavedPostsResponseStorageType

    init(cache: SavedPostsResponseStorageType) {
        self.cache = cache
    }
}

extension SavedPostListRepository: SavedPostListRepositoryType {
    func fetchPostList(completion: @escaping ([Post]) -> Void) {
        cache.getAllSavedPosts(completion: completion)
    }
}
