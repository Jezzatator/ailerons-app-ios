//
//  ContentView.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 15/12/2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var router: TabRouter
    
    var body: some View {
        VStack {
            Text("Hello!")
            Image("ailerons-logo")
                .imageScale(.small)
            
            Button {
                router.change(to: .reglages)
            } label: {
                Text("Switch to the other screen")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(TabRouter())
}
