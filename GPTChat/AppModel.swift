//
//
//  AppModel.swift
//
//  Created by Anthony Marchenko on 3/2/23.
//
//  This software is confidential and proprietary information.
//  

import SwiftUI
import OpenAISwift

final class AppModel: ObservableObject {

    @Published var isThinking: Bool = false
    @Published var selectedModule: Modules?

    @Published var newChatEntryText: String = ""
    @Published var generatedNewChat: String = ""
    var isEmptyNewChatScreen: Bool { !isThinking && generatedNewChat.isEmpty
    }
    var hasResultNewChatScreen: Bool { !isThinking && !generatedNewChat.isEmpty }

    @Published var generatedConcept: String = ""
    var isEmptyConceptScreen: Bool { !isThinking && generatedConcept.isEmpty
    }
    var hasResultConceptScreen: Bool { !isThinking && !generatedConcept.isEmpty }

    @Published var relatedTopicsEntryText: String = ""
    @Published var generatedRelatedTopics: String = ""
    var isEmptyRelatedTopicsScreen: Bool { !isThinking && generatedRelatedTopics.isEmpty
    }
    var hasResultRelatedTopicsScreen: Bool { !isThinking && !generatedRelatedTopics.isEmpty }

    @Published var definitionEntryText: String = ""
    @Published var generatedDefinition: String = ""
    var isEmptyDefinitionScreen: Bool { !isThinking && generatedDefinition.isEmpty
    }
    var hasResultDefinitionScreen: Bool { !isThinking && !generatedDefinition.isEmpty }

    @Published var articleEntryText: String = ""
    @Published var generatedArticle: String = ""
    var isEmptyArticleScreen: Bool { !isThinking && generatedArticle.isEmpty
    }
    var hasResultArticleScreen: Bool { !isThinking && !generatedArticle.isEmpty }
    
    private var client: OpenAISwift?

    func setup() {
        client = OpenAISwift(authToken: Secrets.authToken)
    }

    func send(text: String, completion: @escaping (String) -> Void) {
        isThinking = true
        client?.sendCompletion(with: text, completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                completion(output)
            case .failure:
                let output = "Oops! Error generation output."
                completion(output)
            }
        })
    }

    func makeNewChat() {
        send(text: "\(newChatEntryText)") { output in
            DispatchQueue.main.async {
                self.generatedNewChat = output.trimmingCharacters(in: .whitespacesAndNewlines)
                self.isThinking = false
            }
        }
    }

    func makeConcept() {
        send(text: "Generate a concept, generally a word or many, in the real of anything, that is grounded in reality, and that may or may not be valuable to learn about. Simple provide the short concept without punctuation") { output in
            DispatchQueue.main.async {
                self.generatedConcept = output.trimmingCharacters(in: .whitespacesAndNewlines)
                self.isThinking = false
            }
        }
    }

    func makeRelatedTopics() {
        send(text: "Generate 5 topics that are closely related to \(relatedTopicsEntryText). Simply provide the related topics separated by new line.") { output in
            DispatchQueue.main.async {
                self.generatedRelatedTopics = output.trimmingCharacters(in: .whitespacesAndNewlines)
                self.isThinking = false
            }
        }
    }

    func makeDefinition() {
        send(text: "Provide the definition of \(definitionEntryText).") { output in
            DispatchQueue.main.async {
                self.generatedDefinition = output.trimmingCharacters(in: .whitespacesAndNewlines)
                self.isThinking = false
            }
        }
    }

    func makeArticle() {
        send(text: "Generate an in-depth, grounded in reality, 1-paragraph wikipedia article for a reader who does not understand the topic of \(articleEntryText). Simple provide generated article.") { output in
            DispatchQueue.main.async {
                self.generatedArticle = output.trimmingCharacters(in: .whitespacesAndNewlines)
                self.isThinking = false
            }
        }
    }
}

enum Modules: CaseIterable, Identifiable {
    case newChat
    case randomConcept
    case relatedTopics
    case definition
    case article

    var id: String { return title }

    var title: String {
        switch self {
        case .newChat: return "New Chat"
        case .randomConcept: return "Random Concept"
        case .relatedTopics: return "Related Topics"
        case .definition: return "Definition"
        case .article: return "Article"
        }
    }

    var sfSymbol: String {
        switch self {
        case .newChat: return "text.bubble"
        case .randomConcept: return "lightbulb"
        case .relatedTopics: return "square.stack.3d.up"
        case .definition: return "exclamationmark.circle"
        case .article: return "book"
        }
    }
}
