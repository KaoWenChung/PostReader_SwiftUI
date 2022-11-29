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
        NavigationView {
            List(viewModel.items) { item in
                // TODO: Separate to a coordinator
                let contentView = viewModel.destinationView(item)
                NavigationLink(destination: contentView) {
                    PostListItemView(itemData: item)
                }
//                if viewModel is PostListViewModel {
//                    let contentView = postDIContainer.makePostDetailContentView(withID: item.id)
//                    NavigationLink(destination: contentView) {
//                        PostListItemView(itemData: item)
//                    }
//                } else {
//                    let contentView = postDIContainer.makeSavedPostDetailContentView(with: item)
//                    NavigationLink(destination: contentView) {
//                        PostListItemView(itemData: item)
//                    }
//                }
            }
            .navigationBarTitle(Text("All Posts"), displayMode: .inline)
        }
        .listStyle(.plain)
        .onAppear {
            self.viewModel.onAppear()
        }
    }
}




//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        let postDIContainer = AppDIContainer.makePostSceneDIContainer()
//        return postDIContainer.makePostListContentView()
//    }
//}
