//
//  PostCommentRepositoryType.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

protocol PostCommentRepositoryType {
    func fetchPostComment(withID: Int) async throws -> [Comment]
}
