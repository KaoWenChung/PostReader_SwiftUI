//
//  SwiftUIView.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//

import SwiftUI
import Combine

struct PostListContentView<T>: View where T: PostListViewModelType {
    @ObservedObject var viewModel: T

    init(viewModel: T) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List(viewModel.items) { todo in
                PostListItemView(itemData: todo)
            }
            .navigationBarTitle(Text("All Posts"))
        }
        .listStyle(.plain)
        .onAppear {
            self.viewModel.onAppear()
        }
    }
}
























struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PostListContentView(viewModel: PostListViewModel())
    }
}
