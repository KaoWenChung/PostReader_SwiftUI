//
//  PostDetailViewModel.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

import Combine
import Dispatch

protocol PostDetailViewModelInputType {
    func save()
    func onAppear()
}
protocol PostDetailViewModelOutputType: ObservableObject {
    var postData: Post { get }
}

protocol PostDetailViewModelType: PostDetailViewModelInputType, PostDetailViewModelOutputType {
    
}
final class PostDetailViewModel: PostDetailViewModelType {

    private let showPostDetailUseCase: ShowPostDetailUseCaseType
    private let id: Int
    @Published private(set) var postData: Post
    

    init(withID id: Int, useCase: ShowPostDetailUseCaseType) {
        self.showPostDetailUseCase = useCase
        self.id = id
        self.postData = Post(id: id, title: "Loading...", body: "Loading...")
    }

    func onAppear() {
        // await async performBackgroundTask only works for above iOS 15
        showPostDetailUseCase.execute(withID: id) { value in
            DispatchQueue.main.async {
                self.postData = value
            }
        }
    }

    func save() {
        let request = PostsRequest(id: id)
        showPostDetailUseCase.save(response: postData, for: request)
    }
}
