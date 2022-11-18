//
//  PostDetailRepositoryType.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

protocol PostDetailRepositoryType {
    func fetchPostDetail(withID id: Int, completion: @escaping (Post) -> Void)
    func save(response: Post, for request: PostsRequest)
}
