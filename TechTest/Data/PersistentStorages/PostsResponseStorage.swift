//
//  PostsResponseStorage.swift
//  TechTest
//
//  Created by wyn on 2022/11/16.
//

import Foundation

protocol PostsResponseStorageType {
    func getResponse(for request: PostsRequestDTO, completion: @escaping (Result<PostsResponseDTO?, CoreDataStorageError>) -> Void)
    func save(response: PostsResponseDTO, for requestDTO: PostsRequestDTO)
}

struct PostsRequestDTO: Encodable {
    
}
struct PostsResponseDTO: Decodable {
    
}
