//
//  SavedPostDetailViewModel.swift
//  TechTest
//
//  Created by wyn on 2022/11/18.
//

import Combine
import Dispatch

final class SavedPostDetailViewModel: PostDetailViewModelType {
    func updateSaveStatus() {}
    
    func onAppear() {}
    
    var postData: Post
    private(set) var isShowButtons: Bool = false
    private(set) var saveButtonTitle: String = ""
    private(set) var saveButtonImage: String = ""
    
    init(postData: Post) {
        self.postData = postData
    }
}
