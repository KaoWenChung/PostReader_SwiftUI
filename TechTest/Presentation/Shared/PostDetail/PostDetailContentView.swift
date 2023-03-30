//
//  PostDetailContentView.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//

import SwiftUI

struct PostDetailContentView<T>: View where T: PostDetailViewModelType {

    @ObservedObject private var viewModel: T

    init(viewModel: T) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: UIContent.stackViewSpacing) {
                    Text(viewModel.postData.title)
                        .font(.system(.title))
                        .fontWeight(.bold)
                    Text(viewModel.postData.body)
                        .font(.callout)
                }
                Spacer()
            }
            .padding(.leading)
            .padding(.top)
            .onAppear {
                self.viewModel.onAppear()
            }
            Spacer()
        }
        .navigationBarTitle(Text(viewModel.postData.title), displayMode: .inline)
        HStack {
            Button {
                viewModel.didShowComment()
            } label: {
                Image(ImageContent.bubbleText)
                Text(CommonString.comment.text)
            }
            .padding(.leading)
            Spacer()
            Button {
                viewModel.updateSaveStatus()
            } label: {
                Image(viewModel.saveButtonImage)
                Text(viewModel.saveButtonTitle)
            }
            .padding(.trailing)
        }
    }
}

#if DEBUG
struct PostDetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        let postDIContainer = AppDIContainer().makePostSceneDIContainer()
        return postDIContainer.makePostDetailContentView(withID: 1, actions: nil)
    }
}
#endif
