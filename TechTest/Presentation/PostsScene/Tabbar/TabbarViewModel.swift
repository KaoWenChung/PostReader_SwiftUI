//
//  TabbarViewModel.swift
//  TechTest
//
//  Created by wyn on 2022/11/29.
//

import SwiftUI

protocol TabbarViewModelInputType {
    associatedtype SavedPostDestinationView: View
    associatedtype PostDestinationView: View
    var postListView: PostDestinationView { get }
    var savedPostListView: SavedPostDestinationView { get }
}

protocol TabbarViewModelType: TabbarViewModelInputType {}

final class TabbarViewModel<PostDestinationView: View, SavedPostDestinationView: View>: TabbarViewModelType {
    
    let postListView: PostDestinationView
    let savedPostListView: SavedPostDestinationView
    
    init(postListView: PostDestinationView, savedPostListView: SavedPostDestinationView) {
        self.postListView = postListView
        self.savedPostListView = savedPostListView
    }
}
