//
//
//  ContentView.swift
//
//  Created by Anthony Marchenko on 3/2/23.
//  
//  This software is confidential and proprietary information.
//  

import SwiftUI

struct ModulesView: View {
    @EnvironmentObject private var model: AppModel

    var body: some View {
        NavigationStack {
            VStack {
                List(Modules.allCases) { module in
                    Button {
                        model.selectedModule = module
                    } label: {
                        Label {
                            Text(module.title)
                                .font(.system(size: 20, weight: .medium))
                                .padding(.vertical, 10)
                        } icon: {
                            Image(systemName: module.sfSymbol)
                        }
                    }
                }
            }
            .navigationTitle("Modules")
            .sheet(item: $model.selectedModule) { screen in
                switch screen {
                case .newChat: NewChatView()
                case .randomConcept: ConceptView()
                case .relatedTopics: RelatedTopicsView()
                case .definition: DefinitionView()
                case .article: ArticleView()
                }
            }
        }
        .environmentObject(model)
    }
}

struct ModulesViewPreviews: PreviewProvider {
    static var previews: some View {
        ModulesView()
    }
}
