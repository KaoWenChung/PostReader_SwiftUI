//
//  PostDetailViewModel.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

import Combine
import Dispatch

struct PostDetailViewModelActions {
    let showPostComment: (Int) -> Void
}

protocol PostDetailViewModelInputType {
    func didShowComment()
    func updateSaveStatus()
    func onAppear()
}
protocol PostDetailViewModelOutputType: ObservableObject {
    var postData: Post { get }
    var isShowButtons: Bool { get }
    var saveButtonTitle: String { get }
    var saveButtonImage: String { get }
}

protocol PostDetailViewModelType: PostDetailViewModelInputType, PostDetailViewModelOutputType { }

final class PostDetailViewModel: PostDetailViewModelType {

    private let showPostDetailUseCase: ShowPostDetailUseCaseType
    private let actions: PostDetailViewModelActions?
    private let id: Int
    private var isSaved: Bool = false
    private(set) var isShowButtons: Bool = true
    @Published private(set) var postData: Post
    @Published private(set) var saveButtonTitle: String = "Loading..."
    @Published private(set) var saveButtonImage: String = "bookmark"

    init(withID id: Int,
         useCase: ShowPostDetailUseCaseType,
         actions: PostDetailViewModelActions?) {
        self.showPostDetailUseCase = useCase
        self.id = id
        self.postData = Post(id: id, title: "Loading...", body: "Loading...")
        self.actions = actions
    }

    private func checkSaveStatus() {
        let request = PostsRequest(id: id)
        showPostDetailUseCase.checkSaveStatus(by: request) { result in
            self.isSaved = result
            DispatchQueue.main.async {
                self.updateButtonData()
            }
        }
    }

    private func updateButtonData() {
        saveButtonTitle = isSaved ? "Saved" : "Save"
        saveButtonImage = isSaved ? "bookmark.fill" : "bookmark"
    }
}

extension PostDetailViewModel {
    func didShowComment() {
        actions?.showPostComment(id)
    }

    func updateSaveStatus() {
        let request = PostsRequest(id: id)
        if isSaved {
            showPostDetailUseCase.delete(request)
        } else {
            showPostDetailUseCase.save(response: postData, for: request)
        }
        isSaved.toggle()
        updateButtonData()
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
}
