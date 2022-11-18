//
//  APIEndpoints.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//


struct APIEndpoints {
    static func getPostList() -> Endpoint<[Post]> {
        return Endpoint(path: "posts",
                        method: .get)
    }

    static func getPostDetail(withID postID: Int) -> Endpoint<Post> {
        return Endpoint(path: "posts/\(postID)",
                        method: .get)
    }

    static func getPostComment(withID postID: Int) -> Endpoint<[Comment]> {
        return Endpoint(path: "posts/\(postID)/comments/",
                        method: .get)
    }
}

