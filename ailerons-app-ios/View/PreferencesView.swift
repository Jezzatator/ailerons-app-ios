//
//  PreferencesView.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 16/01/2024.
//

import SwiftUI

struct PreferencesView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vmPreferences = PreferencesViewModel()
    
    var body: some View {
        NavigationStack {
            
            Form {
                Section("Réglagles") {
                    
                    Picker("Unité de mesure", selection: $vmPreferences.selectedUnit) {
                                   ForEach(UnitOfMeasurement.allCases, id: \.self) { unit in
                                       Text(unit.rawValue)
                        }
                    }
                }
                

            
                Section("A Propos de Ailerons") {
                   
                    NavigationLink(destination: WebView(urlString: "https://www.asso-ailerons.fr/qui-sommes-nous/")) {
                        Text("Association Ailerons")
                    }

                    NavigationLink(destination: WebView(urlString: "https://github.com/Jezzatator/ailerons-app-ios")) {
                        VStack(alignment: .leading) {
                            Text("Version")
                            Text("1.0.0")
                                .fontWeight(.ultraLight)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            
            Spacer()
            VStack {
                Text("Créer et conceptualisé à Ada Tech School")
                    .fontWeight(.light)
                    .foregroundStyle(.gray)
            }
            


                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                dismiss()
                            }
                        }
                    }
        }
        .scrollContentBackground(.hidden)
    }
}

//#Preview {
//    PreferencesView()
//}
