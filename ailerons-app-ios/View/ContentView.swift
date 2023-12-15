//
//  ContentView.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 15/12/2023.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        VStack {
            Image(systemName: "fish.circle")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, Ailerons!")
            
            ViewControllerWrapper()
                .edgesIgnoringSafeArea(.all)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
