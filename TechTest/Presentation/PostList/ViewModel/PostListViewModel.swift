//
//  PostListViewModel.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//

import Combine

protocol PostListViewModelInputType {
    func onAppear()
}
protocol PostListViewModelOutputType: ObservableObject {
    var items: [Post] { get }
}
protocol PostListViewModelType: PostListViewModelInputType, PostListViewModelOutputType { }

final class PostListViewModel: PostListViewModelType {
    @Published private(set) var items: [Post] = []
    

    func onAppear() {
        items = [Post(id: 0, title: "wow1", body: "body1"),
                 Post(id: 1, title: "wow2", body: "body2"),
                 Post(id: 2, title: "wow3", body: "body3"),
                 Post(id: 3, title: "wow4", body: "body4")]
    }
    
    private(set) var displayedPosts: [Post] = []
    
    func fetchAllPosts() {
        
    }
}
