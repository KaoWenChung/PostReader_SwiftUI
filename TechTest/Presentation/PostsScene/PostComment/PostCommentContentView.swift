//
//  PostCommentContentView.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

import SwiftUI

struct PostCommentContentView<T>: View where T: PostCommentViewModelType {
    @ObservedObject private var viewModel: T

    init(viewModel: T) {
        self.viewModel = viewModel
    }

    var body: some View {
        List(viewModel.items) { item in
            PostListItemView(commentData: item)
        }
        .navigationBarTitle(Text(CommonString.allComments.text), displayMode: .inline)
        .listStyle(.plain)
        .onAppear {
            loadData()
        }
        .alert(item: $viewModel.error) { appError in
            let button = Alert.Button.default(Text(CommonString.retry.text)) {
                loadData()
            }
            return Alert(title: Text(CommonString.error.text),
                         message: Text(appError.errorDescription.text),
                         dismissButton: button)
        }
    }
    private func loadData() {
        Task.init {
            await viewModel.loadData()
        }
    }
}

#if DEBUG
struct PostCommentContentView_Previews: PreviewProvider {
    static var previews: some View {
        let postDIContainer = AppDIContainer().makePostSceneDIContainer()
        return postDIContainer.makePostCommentContentView(withID: 1)
    }
}
#endif
