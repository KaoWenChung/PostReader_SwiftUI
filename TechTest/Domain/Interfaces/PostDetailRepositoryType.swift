//
//  PostDetailRepositoryType.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

protocol PostDetailRepositoryType {
    func fetchPostDetail(withID id: Int, completion: @escaping (Post) -> Void)
    func checkSaveStatus(by request: PostsRequest, completion: @escaping (Bool) -> Void)
    func save(response: Post, for request: PostsRequest)
    func delete(_ request: PostsRequest)
}
