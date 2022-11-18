//
//  PostCommentContentView.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

import SwiftUI

struct PostCommentContentView<T>: View where T: PostCommentViewModelType{
    @ObservedObject private var viewModel: T

    init(viewModel: T) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List(viewModel.items) { item in
                PostListItemView(commentData: item)
            }
            .navigationBarTitle(Text("All Comments"), displayMode: .inline)
        }
        .listStyle(.plain)
        .onAppear {
            self.viewModel.onAppear()
        }
    }
}

struct PostCommentContentView_Previews: PreviewProvider {
    static var previews: some View {
        let postDIContainer = AppDIContainer.makePostSceneDIContainer()
        return postDIContainer.makePostCommentContentView(withID: 1)
    }
}
