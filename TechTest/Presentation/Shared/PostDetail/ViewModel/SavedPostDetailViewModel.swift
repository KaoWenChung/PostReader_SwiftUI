//
//  SavedPostDetailViewModel.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

final class SavedPostDetailViewModel: PostDetailViewModelType {
    
    private let showPostDetailUseCase: ShowPostDetailUseCaseType

    private(set) var postData: Post
    private(set) var saveButtonTitle: String = ""
    private(set) var saveButtonImage: String = ""
    
    init(postData: Post,
         useCase: ShowPostDetailUseCaseType) {
        self.showPostDetailUseCase = useCase
        self.postData = postData
    }
}

extension SavedPostDetailViewModel {
    func updateSaveStatus() {
        let request = PostsRequest(id: postData.id)
        showPostDetailUseCase.delete(request)
    }
    
    func onAppear() {}

    func didShowComment() {
        print("work in progress")
    }
}
