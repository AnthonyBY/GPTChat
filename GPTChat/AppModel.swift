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
}

enum Modules: CaseIterable, Identifiable {
    case newChat

    var id: String { return title }

    var title: String {
        switch self {
        case .newChat: return "New Chat"
        }
    }

    var sfSymbol: String {
        switch self {
        case .newChat: return "text.bubble"
        }
    }
}
