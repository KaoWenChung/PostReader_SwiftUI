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
    var saveButtonTitle: String { get }
    var saveButtonImage: String { get }
}

protocol PostDetailViewModelType: PostDetailViewModelInputType, PostDetailViewModelOutputType {
    
}
final class PostDetailViewModel: PostDetailViewModelType {

    private let showPostDetailUseCase: ShowPostDetailUseCaseType
    private let id: Int
    @Published private(set) var postData: Post
    @Published private(set) var isSaved: Bool = false
    @Published private(set) var saveButtonTitle: String = "Loading..."
    @Published private(set) var saveButtonImage: String = "bookmark"

    init(withID id: Int, useCase: ShowPostDetailUseCaseType) {
        self.showPostDetailUseCase = useCase
        self.id = id
        self.postData = Post(id: id, title: "Loading...", body: "Loading...")
    }

    func onAppear() {
        checkSaveStatus()
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
        saveButtonTitle = "Saved"
        saveButtonImage = "bookmark.fill"
    }

    private func checkSaveStatus() {
        let request = PostsRequest(id: id)
        showPostDetailUseCase.checkSaveStatus(by: request) { result in
            DispatchQueue.main.async {
                self.saveButtonTitle = result ? "Saved" : "Save"
                self.saveButtonImage = result ? "bookmark.fill" : "bookmark"
            }
        }
    }
}
