//
//  PostDetailRepositoryType.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

protocol PostDetailRepositoryType {
    func fetchPostDetail(withID: Int) async throws -> Post
    func saveRecentQuery(query: PostsRequest, completion: @escaping (Result<PostsRequest, Error>) -> Void)
}
