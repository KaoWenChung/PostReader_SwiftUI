//
//  SwiftUIView.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//

import SwiftUI

struct PostListContentView<T>: View where T: PostListViewModelType {
    @ObservedObject private var viewModel: T

    init(viewModel: T) {
        self.viewModel = viewModel
    }

    var body: some View {
        List(viewModel.items) { item in
            PostListItemView(itemData: item)
                .onTapGesture {
                    viewModel.didSelectItem(item)
                }
        }
        .navigationBarTitle(Text(viewModel.title), displayMode: .inline)
        .listStyle(.plain)
        .onAppear {
            reloadData()
        }
        .alert(item: $viewModel.error) { appError in
            let button = Alert.Button.default(Text(CommonString.retry.text)) {
                reloadData()
            }
            return Alert(title: Text(CommonString.error.text),
                         message: Text(appError.errorDescription.text),
                         dismissButton: button)
        }
    }

    private func reloadData() {
        Task.init {
            await viewModel.reloadData()
        }
    }
}

#if DEBUG
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        let postDIContainer = AppDIContainer().makePostSceneDIContainer()
        return postDIContainer.makePostListContentView(actions: PostListViewModelActions(showPostDetail: { _ in }))
    }
}
#endif
