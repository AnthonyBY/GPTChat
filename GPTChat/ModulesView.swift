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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ModulesViewPreviews: PreviewProvider {
    static var previews: some View {
        ModulesView()
    }
}
