//
//  TabbarContentView.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

import SwiftUI

struct TabbarContentView: View {
    var body: some View {
        TabView {
            let postDIContainer = AppDIContainer.makePostSceneDIContainer()
            let contentView = postDIContainer.makePostListContentView()
            contentView
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("Post")
                }
            let savedPostListView = postDIContainer.makeSavedPostListContentView()
            savedPostListView
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Bookmark")
                }
        }
    }
}

struct TabbarContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarContentView()
    }
}
