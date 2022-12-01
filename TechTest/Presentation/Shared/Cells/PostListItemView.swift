//
//  PostListItemView.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//

import SwiftUI

struct PostListItemView: View {
    private let viewModel: PostItemViewModel
    init(itemData: Post) {
        viewModel = PostItemViewModel(post: itemData)
    }
    init(commentData: Comment) {
        viewModel = PostItemViewModel(comment: commentData)
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.title)
                .font(.headline)
            Text(viewModel.body)
                .font(.subheadline)
        }
    }
}

struct PostListItemView_Previews: PreviewProvider {
    static var previews: some View {
        PostListItemView(itemData: Post(id: 1, title: "title", body: "body"))
    }
}
