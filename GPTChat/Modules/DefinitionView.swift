//
//
//  DefinitionView.swift
//
//  Created by Anthony Marchenko on 3/13/23.
//
//  This software is confidential and proprietary information.
//  

import SwiftUI

struct DefinitionView: View {
    @EnvironmentObject private var model: AppModel

    @Environment(\.dismiss) var dismiss
    @FocusState private var fieldIsFocused: Bool
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32){
                    VStack {
                        HStack {
                            TextField("Required", text: $model.definitionEntryText, axis: .vertical)
                                .padding(8)
                                .background(Color(.secondarySystemFill).cornerRadius(10))
                                .padding(.horizontal, 24)

                            if model.definitionEntryText.isEmpty {
                                Button("Paste") {
                                    model.definitionEntryText = UIPasteboard.general.string ?? ""
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

                    if model.isEmptyDefinitionScreen, !model.definitionEntryText.isEmpty {
                        Text("Tap 'Generate' in the top right corner of your screen")
                            .font(.system(size: 18))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                    }

                    if model.isThinking {
                        VStack {
                            Text("Generating definition...")
                            ProgressView().progressViewStyle(.circular)
                        }
                    }
                    if model.hasResultDefinitionScreen {
                        ResultView(generatedText: model.generatedDefinition)
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
                            model.definitionEntryText = ""
                            model.generatedDefinition = ""
                        }
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Generate") {
                    model.makeDefinition()
                }.disabled(model.isThinking || model.definitionEntryText.isEmpty)
            }
        }
    }
}


