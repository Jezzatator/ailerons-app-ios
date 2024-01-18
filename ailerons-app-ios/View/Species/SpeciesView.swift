//
//  SpeciesView.swift
//  ailerons-app-ios
//
//  Created by Jérémie - Ada on 16/01/2024.
//

import SwiftUI

struct SpeciesView: View {
    @StateObject var supabaseVM = SupabaseAPI()
    
     private var indivs: [SupaIndiv] = []

    var body: some View {
        NavigationStack {
            List {
                ForEach(supabaseVM.testIndiv, id: \.id) { indiv in
                    NavigationLink {
                        SpecieDetailView(individual: indiv)
                    } label: {
                        SpicieRow(binomialName: indiv.binomialName, commonName: indiv.commonName, individualName: indiv.individualName)
                    }
                }
            }
            .navigationTitle("Espèces")
        }
        .onAppear() {
            Task {
                if supabaseVM.testIndiv.isEmpty {
                    await supabaseVM.fetch {
                        print("Number of items fetched: \(supabaseVM.testIndiv.count)")
                    }
                }
            }
        }
    }
}

#Preview {
    SpeciesView()
}
