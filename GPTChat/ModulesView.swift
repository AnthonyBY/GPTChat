//
//
//  ContentView.swift
//
//  Created by Anthony Marchenko on 3/2/23.
//  
//  This software is confidential and proprietary information.
//  

import SwiftUI

struct ContentView: View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
