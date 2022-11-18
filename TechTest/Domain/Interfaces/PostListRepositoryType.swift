//
//  PostListRepositoryType.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

protocol PostListRepositoryType {
    func fetchPostList() async throws -> ([Post], CancellableType)
}
