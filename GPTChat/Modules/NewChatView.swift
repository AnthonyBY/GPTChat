//
//
//  NewChatView.swift
//
//  Created by Anthony Marchenko on 3/12/23.
//
//  This software is confidential and proprietary information.
//  

import SwiftUI

struct NewChatView: View {

    @EnvironmentObject private var model: AppModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 32){
                VStack {
                    HStack {
                        TextField("Required", text: $model.newChatEntryText, axis: .vertical)
                            .padding(8)
                            .background(Color(.secondarySystemFill).cornerRadius(10))
                            .padding(.leading, 24)

                        if model.newChatEntryText.isEmpty {
                            Button("Paste") {
                                model.newChatEntryText = UIPasteboard.general.string ?? ""
                            }
                            .padding(.trailing, 24)
                        }
                    }
                    Text("Provide text")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 34)
                }

                if model.isEmptyNewChatScreen, !model.newChatEntryText.isEmpty {
                    Text("Tap 'send' in the top right corner of your screen")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
            .navigationTitle("New Chat")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
