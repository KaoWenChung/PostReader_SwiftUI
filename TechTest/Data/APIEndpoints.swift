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
}

