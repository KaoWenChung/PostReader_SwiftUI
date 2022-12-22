//
//  SavedPostDetailViewModel.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

final class SavedPostDetailViewModel: PostDetailViewModelType {
    
    private let showPostDetailUseCase: ShowPostDetailUseCaseType
    private let actions: PostDetailViewModelActions?

    private(set) var postData: Post
    private(set) var saveButtonTitle: String = CommonString.saved.text
    private(set) var saveButtonImage: String = ImageContent.fillBookmark
    
    init(postData: Post,
         useCase: ShowPostDetailUseCaseType,
         actions: PostDetailViewModelActions?) {
        self.showPostDetailUseCase = useCase
        self.postData = postData
        self.actions = actions
    }
}

extension SavedPostDetailViewModel {
    func updateSaveStatus() {
        let request = PostsRequest(id: postData.id)
        showPostDetailUseCase.delete(request)
        actions?.didTapSavedButton?()
    }
    
    func onAppear() {}

    func didShowComment() {
        print("work in progress")
    }
}
