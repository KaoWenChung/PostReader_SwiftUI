//
//  TabbarContentView.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

import SwiftUI

protocol TabbarContentViewType : View {}

struct TabbarContentView<PostDestinationView: View, SavedPostDestinationView: View>: TabbarContentViewType {
    @State private var viewModel: TabbarViewModel<PostDestinationView, SavedPostDestinationView>
    init(viewModel: TabbarViewModel<PostDestinationView, SavedPostDestinationView>) {
        self.viewModel = viewModel
    }

    var body: some View {
        TabView {
            viewModel.postListView
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("Post")
                }
            viewModel.savedPostListView
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Bookmark")
                }
        }
    }
}
