//
//  PostsRequestDTO.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

struct PostsRequest: Encodable {
    let postId: Int
    init(id: Int) {
        self.postId = id
    }
}
