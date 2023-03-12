//
//
//  ArticleView.swift
//
//  Created by Anthony Marchenko on 3/13/23.
//
//  This software is confidential and proprietary information.
//  

import SwiftUI

struct ArticleView: View {
    @EnvironmentObject private var model: AppModel

    @Environment(\.dismiss) var dismiss
    @FocusState private var fieldIsFocused: Bool
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32){
                    VStack {
                        HStack {
                            TextField("Required", text: $model.articleEntryText, axis: .vertical)
                                .padding(8)
                                .background(Color(.secondarySystemFill).cornerRadius(10))
                                .padding(.horizontal, 24)

                            if model.articleEntryText.isEmpty {
                                Button("Paste") {
                                    model.articleEntryText = UIPasteboard.general.string ?? ""
                                }
                                .padding(.trailing, 24)
                            }
                        }
                        Text("Provide a topic or keyword")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 34)
                    }

                    if model.isEmptyArticleScreen, !model.articleEntryText.isEmpty {
                        Text("Tap 'Generate' in the top right corner of your screen")
                            .font(.system(size: 18))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                    }

                    if model.isThinking {
                        VStack {
                            Text("Generating article...")
                            ProgressView().progressViewStyle(.circular)
                        }
                    }
                    if model.hasResultArticleScreen {
                        ResultView(generatedText: model.generatedArticle)
                    }
                }
                .padding(.vertical, 32)
            }
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle(model.selectedModule?.title ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { screenToolbar }
        }
    }

    private var screenToolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack{
                    Button("Close") {
                        dismiss()
                    }

                    if !model.generatedDefinition.isEmpty {
                        Button("Reset") {
                            model.articleEntryText = ""
                            model.generatedArticle = ""
                        }
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Generate") {
                    model.makeArticle()
                }.disabled(model.isThinking || model.articleEntryText.isEmpty)
            }
        }
    }
}

