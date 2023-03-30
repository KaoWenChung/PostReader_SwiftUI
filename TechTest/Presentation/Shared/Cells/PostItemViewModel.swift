//
//  PostItemViewModel.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

struct PostItemViewModel {
    let title: String
    let body: String
    init(post: Post) {
        title = post.title
        body = post.body
    }
    init(comment: Comment) {
        title = comment.name
        body = comment.body
    }
}
