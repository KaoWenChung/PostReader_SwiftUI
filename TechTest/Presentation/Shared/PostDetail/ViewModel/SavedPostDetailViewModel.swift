//
//  SavedPostDetailViewModel.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

final class SavedPostDetailViewModel: PostDetailViewModelType {
    
    private(set) var postData: Post
    private(set) var isShowButtons: Bool = false
    private(set) var saveButtonTitle: String = ""
    private(set) var saveButtonImage: String = ""
    
    init(postData: Post) {
        self.postData = postData
    }
}

extension SavedPostDetailViewModel {
    func updateSaveStatus() {}
    
    func onAppear() {}

    func didShowComment() {}
}
