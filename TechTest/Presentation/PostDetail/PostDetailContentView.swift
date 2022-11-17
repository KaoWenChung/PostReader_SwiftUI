//
//  PostDetailContentView.swift
//  TechTest
//
//  Created by wyn on 2022/11/17.
//

import SwiftUI

struct PostDetailContentView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5){
                    Text("Hobbies")
                        .font(.system(.title))
                        .fontWeight(.bold)
                    Text("The quest for a balanced life")
                        .font(.callout)
                }
                Spacer()
            }
            .padding(.leading)
            .padding(.top)
            Spacer()
        }
        .navigationBarTitle(Text("All Posts"), displayMode: .inline)
    }
}

struct PostDetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailContentView()
    }
}

