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
                VStack(alignment: .leading, spacing: 5){
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
        
        Button("Post Comment") {
            print("Button tapped!")
        }
    }
}

struct PostDetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        let postDIContainer = AppDIContainer.makePostSceneDIContainer()
        return postDIContainer.makePostDetailContentView(withID: 1)
    }
}

