//
//  PostsResponseStorage.swift
//  TechTest
//
//  Created by wyn on 2022/11/16.
//

import Foundation

protocol PostsResponseStorageType {
    func getResponse(for request: PostsRequest, completion: @escaping (Result<Post?, CoreDataStorageError>) -> Void)
    func save(response: Post, for requestDTO: PostsRequest)
    func delete(_ request: PostsRequest)
}
