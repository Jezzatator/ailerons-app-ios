//
//  PreferencesView.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 16/01/2024.
//

import SwiftUI

struct PreferencesView: View {
    let unites = ["Métriques", "Impériales"]
    @State private var unite = "Métriques"
    
    var body: some View {
        VStack {
            Form {
                Picker("Unités de mesure", selection: $unite) {
                    ForEach(unites, id: \.self) {
                        Text($0)
                    }
                }
                
                Picker("Unités de mesure", selection: $unite) {
                    ForEach(unites, id: \.self) {
                        Text($0)
                    }
                }
                
                Picker("Unités de mesure", selection: $unite) {
                    ForEach(unites, id: \.self) {
                        Text($0)
                    }
                }
                
            }
            Spacer()
            Text("Créer et conceptualisé à Ada")
        }
    }
}

#Preview {
    PreferencesView()
}
