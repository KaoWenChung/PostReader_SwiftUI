//
//  PostsResponseStorage.swift
//  TechTest
//
//  Created by wyn on 2022/11/16.
//

protocol PostsResponseStorageType {
    func getResponse(for request: PostsRequest, completion: @escaping (Post?) -> Void)
    func save(response: Post, for requestDTO: PostsRequest)
    func delete(_ request: PostsRequest)
}
