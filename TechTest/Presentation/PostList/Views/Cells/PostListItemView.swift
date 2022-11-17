//
//  PostListItemView.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//

import SwiftUI

struct PostListItemView: View {
    private let itemData: Post
    init(itemData: Post) {
        self.itemData = itemData
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text(itemData.title)
                .font(.headline)
            Text(itemData.body)
                .font(.subheadline)
        }
    }
}

struct PostListItemView_Previews: PreviewProvider {
    static var previews: some View {
        PostListItemView(itemData: Post(id: 1, title: "title", body: "body"))
    }
}
