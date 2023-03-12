//
//
//  ConceptView.swift
//
//  Created by Anthony Marchenko on 3/13/23.
//
//  This software is confidential and proprietary information.
//  

import SwiftUI

struct ConceptView: View {

    @EnvironmentObject private var model: AppModel

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                if model.isEmptyConceptScreen {
                    Text("Tap 'Generate' in the top right corner of your screen")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                }

                if model.isThinking {
                    VStack {
                        Text("Generating random concept...")
                        ProgressView().progressViewStyle(.circular)
                    }
                }
                if model.hasResultConceptScreen {
                    Text(model.generatedConcept)
                }
            }
            .navigationTitle("Random Concept")
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

                    if !model.generatedConcept.isEmpty {
                        Button("Reset") {
                            model.generatedConcept = ""
                        }
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Generate") {
                    model.makeConcept()
                }.disabled(model.isThinking)
            }
        }
    }
}
