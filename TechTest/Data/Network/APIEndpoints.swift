//
//  APIEndpoints.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//

struct APIEndpoints {
    static func getPostList() -> Endpoint<[PostResponseDTO]> {
        return Endpoint(path: "posts",
                        method: .get)
    }

    static func getPostDetail(withID postID: Int) -> Endpoint<PostResponseDTO> {
        return Endpoint(path: "posts/\(postID)",
                        method: .get)
    }

    static func getPostComment(withID postID: Int) -> Endpoint<[CommentResponseDTO]> {
        return Endpoint(path: "posts/\(postID)/comments/",
                        method: .get)
    }
}
